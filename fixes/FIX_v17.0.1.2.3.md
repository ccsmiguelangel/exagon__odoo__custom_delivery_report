# Fix v17.0.1.2.3 - Error qty_done en Formato Estándar

## Bug Crítico Corregido
Error cuando el checkbox NO está activado (formato estándar).

## Error Original
```
AttributeError: 'stock.move.line' object has no attribute 'qty_done'
Template: stock.report_delivery_document
Path: /t/t/t/div/table[1]/t[4]/tbody/t[2]
```

## Causa
El formato estándar (fallback cuando checkbox desactivado) usaba campo computed `qty_done`:
- Línea 90: `o.move_line_ids.filtered(lambda x: x.qty_done and x.product_id)`
- Línea 100: `<span t-field="move_line.qty_done"/>`

Campo `qty_done` es computed y no siempre está disponible en Odoo 17.

## Solución
Reemplazar `qty_done` por `quantity` (campo stored) en formato estándar.

### Cambios Realizados

**Línea 90:**
```xml
<!-- Antes -->
<t t-set="lines" t-value="o.move_line_ids.filtered(lambda x: x.qty_done and x.product_id)"/>

<!-- Después -->
<t t-set="lines" t-value="o.move_line_ids.filtered(lambda x: x.quantity and x.product_id)"/>
```

**Línea 100:**
```xml
<!-- Antes -->
<span t-field="move_line.qty_done"/>

<!-- Después -->
<span t-field="move_line.quantity"/>
```

## Consistencia
Ahora ambos formatos usan el mismo campo:
- Formato personalizado (checkbox activado): usa `quantity` ✅
- Formato estándar (checkbox desactivado): usa `quantity` ✅

## Deploy
```bash
# 1. Subir custom_delivery_report.zip vía FTPS
# 2. Descomprimir en /cloudclusters/odoo/odoo/addons/
# 3. Reiniciar Odoo
# 4. Apps → Upgrade "Custom Delivery Report"
```

## Resultado
El módulo funciona correctamente con checkbox activado O desactivado.

