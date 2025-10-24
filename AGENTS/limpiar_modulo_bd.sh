#!/bin/bash
# Script para limpiar módulo de la base de datos
# Ejecutar en Web Shell de CloudClusters

echo "═══════════════════════════════════════════════════════════"
echo "  LIMPIEZA DE MÓDULO: custom_delivery_email"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Solicitar nombre de la base de datos
read -p "Nombre de la base de datos de Odoo: " DB_NAME

echo ""
echo "⚠️  ADVERTENCIA: Este script eliminará el módulo de la base de datos"
echo "    Asegúrate de tener un backup antes de continuar"
echo ""
read -p "¿Continuar? (s/n): " CONFIRM

if [ "$CONFIRM" != "s" ] && [ "$CONFIRM" != "S" ]; then
    echo "Operación cancelada"
    exit 0
fi

echo ""
echo "Limpiando módulo de la base de datos..."

# Ejecutar comandos SQL
psql -U odoo -d "$DB_NAME" <<EOF
-- Verificar módulo
SELECT id, name, state FROM ir_module_module WHERE name = 'custom_delivery_email';

-- Eliminar módulo
DELETE FROM ir_module_module WHERE name = 'custom_delivery_email';

-- Limpiar dependencias
DELETE FROM ir_module_module_dependency WHERE name = 'custom_delivery_email';

-- Verificar eliminación
SELECT COUNT(*) as registros_restantes FROM ir_module_module WHERE name = 'custom_delivery_email';
EOF

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Módulo limpiado de la base de datos"
    echo ""
    echo "PRÓXIMOS PASOS:"
    echo "1. Reiniciar Odoo desde panel CloudClusters"
    echo "2. Verificar que el módulo ya no aparece en Apps"
else
    echo ""
    echo "❌ Error al limpiar la base de datos"
    echo "Verifica:"
    echo "- Nombre de la base de datos correcto"
    echo "- Permisos de usuario odoo"
    echo "- Conexión a PostgreSQL"
fi

echo ""
echo "═══════════════════════════════════════════════════════════"

