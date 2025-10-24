#!/bin/bash
# Script de Diagnóstico para custom_delivery_email
# Ejecutar en Web Shell de CloudClusters

echo "═══════════════════════════════════════════════════════════"
echo "  DIAGNÓSTICO: custom_delivery_email"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Variables
MODULE_PATH="/cloudclusters/odoo/odoo/addons/custom_delivery_email"
LOG_FILE="/var/log/odoo/odoo-server.log"

# 1. Verificar que el módulo existe
echo "1. Verificando existencia del módulo..."
if [ -d "$MODULE_PATH" ]; then
    echo "   ✅ El módulo existe en: $MODULE_PATH"
else
    echo "   ❌ ERROR: El módulo NO existe en: $MODULE_PATH"
    echo "   → Subir el módulo via FTPS a esa ruta"
    exit 1
fi
echo ""

# 2. Verificar archivos críticos
echo "2. Verificando archivos críticos..."
REQUIRED_FILES=(
    "__init__.py"
    "__manifest__.py"
    "models/__init__.py"
    "models/res_config_settings.py"
    "views/report_deliveryslip.xml"
    "views/res_config_settings_views.xml"
    "data/mail_template_delivery.xml"
)

ALL_PRESENT=true
for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$MODULE_PATH/$file" ]; then
        echo "   ✅ $file"
    else
        echo "   ❌ FALTA: $file"
        ALL_PRESENT=false
    fi
done
echo ""

if [ "$ALL_PRESENT" = false ]; then
    echo "   ❌ ERROR: Faltan archivos críticos"
    echo "   → Subir todos los archivos necesarios"
    exit 1
fi

# 3. Verificar permisos
echo "3. Verificando permisos..."
PERMS=$(stat -c "%a" "$MODULE_PATH" 2>/dev/null || stat -f "%OLp" "$MODULE_PATH" 2>/dev/null)
echo "   Permisos actuales: $PERMS"
if [ "$PERMS" = "755" ] || [ "$PERMS" = "775" ]; then
    echo "   ✅ Permisos correctos"
else
    echo "   ⚠️  Permisos podrían ser un problema"
    echo "   → Ejecutar: chmod -R 755 $MODULE_PATH"
fi
echo ""

# 4. Verificar sintaxis Python
echo "4. Verificando sintaxis Python..."
python3 -m py_compile "$MODULE_PATH/__init__.py" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "   ✅ __init__.py es válido"
else
    echo "   ❌ ERROR en __init__.py"
fi

python3 -m py_compile "$MODULE_PATH/models/res_config_settings.py" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "   ✅ res_config_settings.py es válido"
else
    echo "   ❌ ERROR en res_config_settings.py"
fi
echo ""

# 5. Verificar sintaxis XML
echo "5. Verificando sintaxis XML..."
if command -v xmllint &> /dev/null; then
    for xmlfile in "$MODULE_PATH"/views/*.xml "$MODULE_PATH"/data/*.xml; do
        if [ -f "$xmlfile" ]; then
            xmllint --noout "$xmlfile" 2>/dev/null
            if [ $? -eq 0 ]; then
                echo "   ✅ $(basename $xmlfile) es válido"
            else
                echo "   ❌ ERROR en $(basename $xmlfile)"
            fi
        fi
    done
else
    echo "   ⚠️  xmllint no disponible, saltando verificación XML"
fi
echo ""

# 6. Buscar errores en logs
echo "6. Buscando errores en logs recientes..."
if [ -f "$LOG_FILE" ]; then
    ERRORS=$(grep -i "custom_delivery" "$LOG_FILE" | grep -i error | tail -n 5)
    if [ -z "$ERRORS" ]; then
        echo "   ✅ No se encontraron errores recientes"
    else
        echo "   ⚠️  Errores encontrados:"
        echo "$ERRORS"
    fi
else
    echo "   ⚠️  No se puede acceder al log: $LOG_FILE"
fi
echo ""

# 7. Verificar archivos no deseados
echo "7. Verificando archivos no deseados..."
UNWANTED=$(find "$MODULE_PATH" -name "*.txt" -o -name ".DS_Store" 2>/dev/null)
if [ -z "$UNWANTED" ]; then
    echo "   ✅ No hay archivos .txt o .DS_Store"
else
    echo "   ⚠️  Archivos no necesarios encontrados:"
    echo "$UNWANTED"
    echo "   → Considerar eliminarlos"
fi
echo ""

# Resumen
echo "═══════════════════════════════════════════════════════════"
echo "  RESUMEN DEL DIAGNÓSTICO"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Módulo encontrado: ✅"
echo "Archivos presentes: $( [ "$ALL_PRESENT" = true ] && echo '✅' || echo '❌' )"
echo "Permisos correctos: $( [ "$PERMS" = "755" ] && echo '✅' || echo '⚠️' )"
echo ""
echo "PRÓXIMOS PASOS:"
echo "1. Reiniciar Odoo desde panel CloudClusters"
echo "2. Esperar 2-3 minutos"
echo "3. Apps → Update Apps List"
echo "4. Buscar 'custom' e instalar"
echo ""
echo "═══════════════════════════════════════════════════════════"


