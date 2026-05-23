#!/bin/bash
set -e

MYSQL_DIR="/Users/mac/mysql/mysql-8.0.28-macos11-x86_64"
GF_DIR="$HOME/glassfish7"
ANT_DIR="$HOME/tools/apache-ant-1.10.14"
PROJECT_DIR="/Users/mac/NetBeansProjects/Pro_Fin_GEVM/ProyectoFinal"
SCHEMA="/Users/mac/NetBeansProjects/Pro_Fin_GEVM/schema.sql"
GF_ADMIN="$GF_DIR/glassfish/bin/asadmin"

echo "🌌 Prendiendo OBLIVION..."

# 1. MySQL
if pgrep -q mysqld 2>/dev/null; then
    echo "  ✅ MySQL ya corriendo"
else
    echo "  ⏳ Iniciando MySQL..."
    nohup "$MYSQL_DIR/bin/mysqld" --user=mysql --socket=/tmp/mysql.sock \
        --datadir="$MYSQL_DIR/data" > /tmp/mysql.log 2>&1 &
    for i in $(seq 1 15); do
        sleep 1
        if "$MYSQL_DIR/bin/mysqladmin" ping --socket=/tmp/mysql.sock 2>/dev/null; then
            break
        fi
    done
    echo "  ✅ MySQL listo"
fi

# 1b. Inicializar BD si está vacía
if ! "$MYSQL_DIR/bin/mysql" --socket=/tmp/mysql.sock -u root -e "SELECT 1 FROM db_plataforma_ia.usuarios LIMIT 1" &>/dev/null; then
    echo "  ⏳ Inicializando base de datos..."
    "$MYSQL_DIR/bin/mysql" --socket=/tmp/mysql.sock -u root < "$SCHEMA"
    echo "  ✅ Base de datos lista"
else
    echo "  ✅ Base de datos ya inicializada"
fi

# 2. GlassFish
if "$GF_ADMIN" list-domains 2>/dev/null | grep -q "domain1 running"; then
    echo "  ✅ GlassFish ya corriendo"
else
    echo "  ⏳ Iniciando GlassFish..."
    nohup "$GF_ADMIN" start-domain domain1 > /tmp/gf_start.log 2>&1 &
    for i in $(seq 1 60); do
        sleep 2
        if "$GF_ADMIN" list-domains 2>/dev/null | grep -q "domain1 running"; then
            break
        fi
    done
    echo "  ✅ GlassFish listo"
fi

# 3. Build & Deploy
echo "  ⏳ Compilando..."
"$ANT_DIR/bin/ant" -f "$PROJECT_DIR/build.xml" clean dist 2>&1 | tail -2

echo "  ⏳ Desplegando..."
"$GF_ADMIN" deploy --force=true "$PROJECT_DIR/dist/ProyectoFinal.war" 2>&1 | tail -1

echo ""
echo "🌌 OBLIVION corriendo en http://localhost:8080/ProyectoFinal/"
