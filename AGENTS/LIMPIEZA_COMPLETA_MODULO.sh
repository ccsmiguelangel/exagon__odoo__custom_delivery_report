#!/bin/bash
# Script de Limpieza Completa del Módulo custom_delivery_email
# Ejecutar DESPUÉS de que Odoo esté corriendo

echo "═══════════════════════════════════════════════════════════"
echo "  LIMPIEZA COMPLETA: custom_delivery_email"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Solicitar confirmación
echo "⚠️  ADVERTENCIA:"
echo "   - Este script limpiará COMPLETAMENTE el módulo"
echo "   - Eliminará registros de la base de datos"
echo "   - Eliminará archivos del servidor"
echo ""
read -p "Nombre de tu base de datos Odoo: " DB_NAME

if [ -z "$DB_NAME" ]; then
    echo "❌ Necesitas proporcionar el nombre de la base de datos"
    exit 1
fi

echo ""
read -p "¿Continuar con la limpieza? (escribir SI en mayúsculas): " CONFIRM

if [ "$CONFIRM" != "SI" ]; then
    echo "Operación cancelada"
    exit 0
fi

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  INICIANDO LIMPIEZA"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Paso 1: Parar Odoo
echo "1. Deteniendo Odoo..."
supervisorctl stop odoo
sleep 5

# Paso 2: Limpiar base de datos
echo ""
echo "2. Limpiando base de datos..."
psql -U odoo -d "$DB_NAME" <<EOF
-- Eliminar módulo
DELETE FROM ir_module_module WHERE name = 'custom_delivery_email';

-- Limpiar dependencias
DELETE FROM ir_module_module_dependency WHERE name = 'custom_delivery_email';

-- Limpiar vistas
DELETE FROM ir_ui_view WHERE arch_db LIKE '%custom_delivery_email%';

-- Limpiar datos
DELETE FROM ir_model_data WHERE module = 'custom_delivery_email';

-- Limpiar plantillas de email
DELETE FROM mail_template WHERE name LIKE '%Albarán de Entrega - Formato Personalizado%';

-- Verificar limpieza
SELECT COUNT(*) as registros_modulo FROM ir_module_module WHERE name = 'custom_delivery_email';
SELECT COUNT(*) as registros_data FROM ir_model_data WHERE module = 'custom_delivery_email';
EOF

if [ $? -eq 0 ]; then
    echo "✅ Base de datos limpiada"
else
    echo "❌ Error al limpiar base de datos"
    echo "Iniciando Odoo de nuevo..."
    supervisorctl start odoo
    exit 1
fi

# Paso 3: Eliminar archivos del módulo
echo ""
echo "3. Eliminando archivos del módulo..."
if [ -d "/cloudclusters/odoo/odoo/addons/custom_delivery_email" ]; then
    rm -rf /cloudclusters/odoo/odoo/addons/custom_delivery_email
    echo "✅ Archivos eliminados"
else
    echo "⚠️  Directorio del módulo no existe (ya estaba eliminado)"
fi

# Paso 4: Limpiar caché de Python
echo ""
echo "4. Limpiando caché de Python..."
find /cloudclusters/odoo -name "*.pyc" -delete 2>/dev/null
find /cloudclusters/odoo -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null
echo "✅ Caché limpiado"

# Paso 5: Reiniciar Odoo
echo ""
echo "5. Reiniciando Odoo..."
supervisorctl start odoo

echo ""
echo "⏱️  Esperando 30 segundos a que Odoo arranque..."
sleep 30

# Verificar estado
echo ""
echo "6. Verificando estado..."
supervisorctl status odoo

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  LIMPIEZA COMPLETADA"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "PRÓXIMOS PASOS:"
echo ""
echo "1. Verificar que Odoo carga en el navegador"
echo ""
echo "2. Si Odoo funciona correctamente:"
echo "   ✅ El módulo ha sido eliminado completamente"
echo "   ✅ Puedes reinstalarlo si quieres desde cero"
echo ""
echo "3. Si quieres reinstalar el módulo:"
echo "   - Subir archivos limpios via FTPS"
echo "   - Reiniciar Odoo"
echo "   - Apps → Update Apps List"
echo "   - Buscar e instalar"
echo ""
echo "4. Si Odoo NO funciona:"
echo "   - Ver logs: tail -f /var/log/odoo/odoo-server.log"
echo "   - Contactar soporte CloudClusters"
echo ""
echo "═══════════════════════════════════════════════════════════"

