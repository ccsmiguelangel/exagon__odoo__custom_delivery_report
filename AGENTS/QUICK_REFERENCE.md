# ⚡ Quick Reference

## Deploy
```bash
# 1. FTPS → /cloudclusters/odoo/odoo/addons/custom_delivery_[report|email]/
# 2. Panel CloudClusters → Restart Odoo
# 3. Apps → Update Apps List → Instalar
# 4. Ajustes > Inventario → Activar formato personalizado
```

## Config por Empresa
```python
# Leer
param_key = f'custom_delivery_report.use_custom_format.company_{o.company_id.id}'
value = env['ir.config_parameter'].sudo().get_param(param_key, 'False')
is_active = value == 'True'

# Escribir
env['ir.config_parameter'].sudo().set_param(param_key, True)
```

## QWeb Seguro
```xml
<!-- ✅ CORRECTO -->
<t t-foreach="o.move_line_ids" t-as="line">
    <t t-if="line.product_id">
        <span t-field="line.quantity"/>
        <span t-esc="line.lot_id.name or ''"/>
    </t>
</t>

<!-- ❌ INCORRECTO -->
<t t-foreach="o.move_line_ids.filtered(lambda x: x.qty_done > 0)">
    <span t-esc="getattr(line, 'lot_id', False)"/>
</t>
```

## Campos Seguros
```python
✅ line.quantity               # stored
✅ line.product_id             # relational
✅ line.lot_id                 # relational
✅ line.product_packaging_id   # relational
❌ line.qty_done               # computed
```

## Troubleshooting
```bash
# Logs
tail -f /var/log/odoo/odoo-server.log | grep custom_delivery

# Permisos
chmod -R 755 /cloudclusters/odoo/odoo/addons/custom_delivery_*/

# Diagnóstico
./AGENTS/diagnostico_modulo.sh
```

## Errores Comunes
| Error | Causa | Fix |
|-------|-------|-----|
| cannot be downloaded | No reiniciado | Reiniciar Odoo |
| PDF no cambia | Caché | Ctrl+F5 + Regenerar Assets |
| QWeb error | Campo computed | Usar campos stored |
| Config no funciona | `env.company` usado | Usar `o.company_id` |
