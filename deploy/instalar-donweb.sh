#!/usr/bin/env bash
# ==========================================================
# Instala o actualiza Top Level en el servidor de DonWeb, al lado de los
# otros proyectos SIN TOCARLOS.
#
#   Top Level → /var/www/toplevel · PM2 "toplevel" · primer puerto libre desde 3001
#             base tienda_toplevel (usuario propio) · https://toplevel.veltaweb.com.ar
#
# Uso (como root, dentro del servidor):
#   1) Solo revisar, sin cambiar nada:
#      curl -fsSL https://raw.githubusercontent.com/ExequielJuarez/TopLevel/main/deploy/instalar-donweb.sh | bash -s -- --revisar
#   2) Instalar (o actualizar si ya está):
#      curl -fsSL https://raw.githubusercontent.com/ExequielJuarez/TopLevel/main/deploy/instalar-donweb.sh | bash
#
# Cuidados con los demás proyectos:
#   - Antes de cambiar algo revisa que la carpeta, la base, el usuario de la base,
#     el nombre en PM2, el sitio de Nginx y el dominio no existan ya. Si algo choca, se
#     detiene sin haber tocado nada.
#   - Usa un puerto que no use ningún proceso ni ningún sitio de Nginx.
#   - No actualiza ni reinicia programas que ya estén instalados (MariaDB, Nginx, Node).
#   - Nginx solo se recarga (no se reinicia) y solo si la configuración completa da OK;
#     si no, saca el sitio nuevo y deja todo como estaba.
#   - Certbot solo toca el bloque de toplevel.veltaweb.com.ar.
# ==========================================================
set -euo pipefail

DOMINIO="toplevel.veltaweb.com.ar"
CARPETA="/var/www/toplevel"
REPO="https://github.com/ExequielJuarez/TopLevel.git"
APP="toplevel"
BASE="tienda_toplevel"
USUARIO_BASE="toplevel"
SITIO="/etc/nginx/sites-available/$APP"
ENLACE="/etc/nginx/sites-enabled/$APP"
SOLO_REVISAR=0
[ "${1:-}" = "--revisar" ] && SOLO_REVISAR=1

paso() { printf '\n\033[1;33m▶ %s\033[0m\n' "$1"; }
ok() { printf '\033[1;32m✔ %s\033[0m\n' "$1"; }
choque() { printf '\033[1;31m✘ %s\033[0m\n' "$1"; CHOQUES=$((CHOQUES + 1)); }
CHOQUES=0

[ "$(id -u)" -eq 0 ] || { echo "Correlo como root"; exit 1; }

# ── Actualización: Top Level ya instalada por este script ─────
if [ "$SOLO_REVISAR" = 0 ] && [ -d "$CARPETA/.git" ] && [ -f "$CARPETA/.env" ] \
   && git -C "$CARPETA" remote get-url origin 2>/dev/null | grep -qi "ExequielJuarez/TopLevel"; then
  paso "Top Level ya está instalada: traigo los cambios de GitHub"
  cd "$CARPETA"
  git pull --ff-only
  npm ci --omit=dev --no-audit --no-fund
  pm2 restart "$APP" --update-env
  pm2 save
  ok "Actualizada: https://$DOMINIO"
  exit 0
fi

# ══════════ Revisión previa: no se cambia nada todavía ══════════
paso "Revisando que Top Level no choque con los otros proyectos"

echo "Proyectos en PM2:"
pm2 jlist 2>/dev/null | node -e 'let s="";process.stdin.on("data",d=>s+=d).on("end",()=>{try{for(const p of JSON.parse(s))console.log("   -",p.name,"·",p.pm2_env.status,"·",p.pm2_env.pm_cwd)}catch{console.log("   (no se pudo leer PM2)")}})' || true
echo "Sitios de Nginx activos:"
for f in /etc/nginx/sites-enabled/*; do [ -e "$f" ] && echo "   - $(basename "$f"): $(grep -hoE 'server_name[^;]+' "$f" | head -1)"; done
echo "Bases de datos:"
mysql -N -e "SHOW DATABASES" 2>/dev/null | grep -vE '^(information_schema|mysql|performance_schema|sys)$' | sed 's/^/   - /' || echo "   (no se pudo leer MariaDB)"

[ -e "$CARPETA" ] && choque "Ya existe la carpeta $CARPETA"
pm2 describe "$APP" >/dev/null 2>&1 && choque "Ya hay un proceso de PM2 llamado \"$APP\""
[ -e "$SITIO" ] || [ -e "$ENLACE" ] && choque "Ya existe el sitio de Nginx \"$APP\""
if grep -rqsE "server_name[^;]*\b$DOMINIO\b" /etc/nginx/sites-enabled/ /etc/nginx/conf.d/ 2>/dev/null; then
  choque "Otro sitio de Nginx ya usa $DOMINIO"
fi
if mysql -N -e "SHOW DATABASES LIKE '$BASE'" 2>/dev/null | grep -q .; then choque "Ya existe la base $BASE"; fi
if mysql -N -e "SELECT 1 FROM mysql.user WHERE user='$USUARIO_BASE'" 2>/dev/null | grep -q .; then choque "Ya existe el usuario de base \"$USUARIO_BASE\""; fi

# Primer puerto libre: que nadie lo escuche y que ningún sitio de Nginx lo use
PUERTO=""
for p in $(seq 3001 3099); do
  if ! ss -ltnH 2>/dev/null | awk '{print $4}' | grep -qE "[:.]$p\$" \
     && ! grep -rqsE "127\.0\.0\.1:$p\b|localhost:$p\b" /etc/nginx/ 2>/dev/null; then
    PUERTO=$p; break
  fi
done
[ -n "$PUERTO" ] && ok "Puerto libre para Top Level: $PUERTO" || choque "No encontré un puerto libre entre 3001 y 3099"

for prog in node npm pm2 nginx mysql git; do command -v "$prog" >/dev/null || echo "   (falta $prog: se instalará)"; done
echo "Memoria:"; free -h | sed 's/^/   /'

if [ "$CHOQUES" -gt 0 ]; then
  printf '\n\033[1;31mSe encontraron %s choques. No se cambió nada.\033[0m\n' "$CHOQUES"
  echo "Pasale este resultado a quien te ayuda con el servidor para elegir otros nombres."
  exit 1
fi
ok "No choca con nada"
if [ "$SOLO_REVISAR" = 1 ]; then
  echo "Modo revisión: no se cambió nada. Para instalar, corré el comando sin --revisar."
  exit 0
fi

# ══════════ Instalación ══════════
paso "1/7 Programas (solo instala los que faltan; no actualiza los que ya están)"
FALTAN=""
for paquete in git nginx mariadb-server certbot python3-certbot-nginx; do
  dpkg -s "$paquete" >/dev/null 2>&1 || FALTAN="$FALTAN $paquete"
done
if [ -n "$FALTAN" ]; then
  apt-get update -qq
  apt-get install -y -qq --no-upgrade $FALTAN >/dev/null
  ok "Instalado:$FALTAN"
else
  ok "Ya estaba todo instalado"
fi
command -v pm2 >/dev/null || npm install -g pm2 >/dev/null

paso "2/7 Bajando el proyecto de GitHub"
mkdir -p /var/www
git clone -q "$REPO" "$CARPETA"
cd "$CARPETA"
npm ci --omit=dev --no-audit --no-fund

paso "3/7 Base de datos $BASE con su propio usuario"
CLAVE_BASE="$(openssl rand -hex 16)"
mysql -e "CREATE DATABASE $BASE CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER '$USUARIO_BASE'@'localhost' IDENTIFIED BY '$CLAVE_BASE';
GRANT ALL PRIVILEGES ON $BASE.* TO '$USUARIO_BASE'@'localhost';
FLUSH PRIVILEGES;"
ok "Base lista (la clave quedó solo en $CARPETA/.env; ese usuario no ve las otras bases)"

paso "4/7 Archivo .env del servidor"
cat > .env <<EOF
NODE_ENV=production
HOST=127.0.0.1
PORT=$PUERTO
SESSION_SECRET=$(openssl rand -hex 32)
APP_URL=https://$DOMINIO

DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=$USUARIO_BASE
DB_PASSWORD=$CLAVE_BASE
DB_NAME=$BASE
DB_TIMEZONE=-03:00
DB_POOL_MAX=5

MP_ACCESS_TOKEN=
MP_WEBHOOK_SECRET=
MP_NOMBRE_TIENDA=Top Level
MP_MAX_CUOTAS=6
PAGO_VENCE_HORAS=48

TRANSFERENCIA_ALIAS=
TRANSFERENCIA_CBU=
TRANSFERENCIA_TITULAR=
TRANSFERENCIA_BANCO=

SMTP_HOST=smtp.gmail.com
SMTP_PORT=465
SMTP_USER=
SMTP_PASS=
MAIL_FROM=Top Level <tu-cuenta@gmail.com>

GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=
GOOGLE_CALLBACK_URL=https://$DOMINIO/auth/google/callback

TIENDA_DIRECCION=
TIENDA_TELEFONO=
TIENDA_EMAIL=
TIENDA_CUIT=
TIENDA_WHATSAPP=
TIENDA_INSTAGRAM=
TIENDA_HORARIOS=
EOF
chmod 600 .env
ok ".env creado"

paso "5/7 Tablas y productos de prueba (solo en $BASE)"
npm run db:instalar

paso "6/7 Prendiendo Top Level con PM2 (puerto $PUERTO; los demás procesos no se tocan)"
pm2 start src/app.js --name "$APP"
pm2 save
sleep 3
pm2 logs "$APP" --lines 8 --nostream || true

paso "7/7 Nginx para $DOMINIO y certificado https"
cat > "$SITIO" <<EOF
server {
    listen 80;
    listen [::]:80;
    server_name $DOMINIO;
    client_max_body_size 20M;

    location /admin/notificaciones/stream {
        proxy_pass http://127.0.0.1:$PUERTO;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
        proxy_set_header Host \$host;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_buffering off;
        proxy_read_timeout 1h;
    }

    location / {
        proxy_pass http://127.0.0.1:$PUERTO;
        proxy_http_version 1.1;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF
ln -s "$SITIO" "$ENLACE"
if nginx -t 2>/dev/null; then
  systemctl reload nginx
  ok "Nginx recargado (los otros sitios siguen funcionando igual)"
else
  rm -f "$ENLACE" "$SITIO"
  nginx -t || true
  echo "⚠️  La configuración de Nginx no dio OK: saqué el sitio de Top Level y no recargué nada."
  echo "   Top Level quedó prendida en el puerto $PUERTO, pero sin dominio. Pasale este error a quien te ayuda."
  exit 1
fi

if certbot --nginx -d "$DOMINIO" --non-interactive --agree-tos --register-unsafely-without-email --redirect; then
  ok "https activado"
else
  echo "⚠️  No se pudo sacar el certificado todavía. La tienda ya anda en http://$DOMINIO."
  echo "   Probá más tarde con: certbot --nginx -d $DOMINIO --redirect"
fi

printf '\n\033[1;32m══════════════════════════════════════════\033[0m\n'
ok "Top Level publicada: https://$DOMINIO (puerto interno $PUERTO)"
pm2 status
