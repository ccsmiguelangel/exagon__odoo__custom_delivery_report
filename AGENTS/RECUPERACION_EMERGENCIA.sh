#!/bin/bash
# Script de Recuperación de Emergencia
# Ejecutar en Web Shell de CloudClusters

echo "═══════════════════════════════════════════════════════════"
echo "  RECUPERACIÓN DE EMERGENCIA - ODOO"
echo "═══════════════════════════════════════════════════════════"
echo ""

# 1. Verificar estado de Odoo
echo "1. Verificando estado de Odoo..."
supervisorctl status odoo

# 2. Iniciar Odoo si está parado
echo ""
echo "2. Iniciando Odoo..."
supervisorctl start odoo

# Esperar que arranque
echo ""
echo "⏱️  Esperando 30 segundos a que Odoo arranque..."
sleep 30

# 3. Verificar que arrancó
echo ""
echo "3. Verificando que Odoo está corriendo..."
supervisorctl status odoo

STATUS=$(supervisorctl status odoo | grep RUNNING)

if [ -n "$STATUS" ]; then
    echo "✅ Odoo está corriendo"
else
    echo "❌ Odoo NO está corriendo"
    echo ""
    echo "Intentando reiniciar..."
    supervisorctl restart odoo
    sleep 30
fi

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  PRÓXIMOS PASOS"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "1. Verificar que Odoo responde:"
echo "   - Abrir navegador"
echo "   - Ir a tu URL de Odoo"
echo "   - Verificar que carga"
echo ""
echo "2. Si Odoo carga correctamente:"
echo "   - Ejecutar script de limpieza de módulo"
echo "   - O reinstalar módulo correctamente"
echo ""
echo "3. Si Odoo NO carga:"
echo "   - Revisar logs: tail -f /var/log/odoo/odoo-server.log"
echo "   - Contactar soporte CloudClusters"
echo ""
echo "═══════════════════════════════════════════════════════════"

