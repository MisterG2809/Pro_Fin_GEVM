#!/bin/bash
set -e

MYSQL_DIR="/Users/mac/mysql/mysql-8.0.28-macos11-x86_64"
GF_DIR="$HOME/glassfish7"
GF_ADMIN="$GF_DIR/glassfish/bin/asadmin"

echo "🛑 Apagando OBLIVION..."

# Detener GlassFish
if "$GF_ADMIN" list-domains 2>/dev/null | grep -q "domain1 running"; then
    echo "  ⏳ Deteniendo GlassFish..."
    "$GF_ADMIN" stop-domain domain1 2>&1 | tail -1
    echo "  ✅ GlassFish detenido"
else
    echo "  ⏭ GlassFish no estaba corriendo"
fi

# Detener MySQL
if pgrep -q mysqld 2>/dev/null; then
    echo "  ⏳ Deteniendo MySQL..."
    "$MYSQL_DIR/bin/mysqladmin" --socket=/tmp/mysql.sock -u root shutdown 2>&1
    echo "  ✅ MySQL detenido"
else
    echo "  ⏭ MySQL no estaba corriendo"
fi

echo "✅ Todo apagado"
