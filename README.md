# Custom Delivery - Odoo 17

Módulo Odoo 17 que personaliza PDF y Email de albaranes de entrega.

## Módulos
- `custom_delivery_report` - Nombre recomendado
- `custom_delivery_email` - Nombre antiguo (mismo código)

## Características
- Tabla de 3 columnas: Producto | Lote/Nº serie | Entregado
- Configurable por empresa
- Respeta empaquetado de productos

## Instalación
```bash
# 1. FTPS: Subir a /cloudclusters/odoo/odoo/addons/
# 2. Reiniciar Odoo desde panel CloudClusters
# 3. Apps → Update Apps List → Instalar
# 4. Ajustes > Inventario → Activar formato personalizado
```

## Documentación
- **Para IA:** Lee `.cursor/rules/proyecto.mdc`
- **Inicio rápido:** `AGENTS/00_START_HERE.md`
- **Referencia:** `AGENTS/QUICK_REFERENCE.md`

## Scripts Útiles
```bash
./AGENTS/diagnostico_modulo.sh         # Diagnóstico
./AGENTS/limpiar_modulo_bd.sh          # Limpieza BD
./AGENTS/RECUPERACION_EMERGENCIA.sh    # Recuperación
```

## Versión
17.0.1.2.2 ✅ Con pluralización

