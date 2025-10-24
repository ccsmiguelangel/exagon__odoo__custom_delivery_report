# Fix v17.0.1.2.0 - Agregado Empaquetado

## Mejora Implementada
Agregada información de empaquetado al PDF de albarán.

## Problema Anterior
v17.0.1.1.1 funcionaba pero no mostraba empaquetado.

## Solución
Acceso correcto a empaquetado a través del modelo padre `stock.move`:

```xml
<t t-if="move_line.move_id.product_packaging_id">
    <br/>
    <span style="font-size: 11px; color: #666;">
        (<span t-field="move_line.move_id.product_packaging_id.name"/>)
    </span>
</t>
```

## Estructura de Modelos
```
stock.picking
  └── move_line_ids (stock.move.line)
        └── move_id (stock.move) ← AQUÍ está product_packaging_id
              └── product_packaging_id ✅
```

## Deploy
```bash
# 1. Subir custom_delivery_report.zip vía FTPS
# 2. Descomprimir en /cloudclusters/odoo/odoo/addons/
# 3. Reiniciar Odoo
# 4. Apps → Upgrade "Custom Delivery Report"
```

## ✅ Resultado
Tabla de 3 columnas con empaquetado:
- Producto ✅
- Lote/Nº serie ✅
- Entregado:
  - Cantidad (línea principal)
  - Empaquetado (debajo, si existe)

## Nota Técnica
- Campo: `move_line.move_id.product_packaging_id`
- NO usar: `move_line.product_packaging_id` (NO existe)
- Solo QWeb: `t-if` y `t-field`

