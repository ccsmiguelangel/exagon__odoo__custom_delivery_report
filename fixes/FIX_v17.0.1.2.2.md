# Fix v17.0.1.2.2 - Pluralización y Eliminación de Duplicación

## Problemas Corregidos

### 1. Falta de Pluralización
Antes: `24,000 Unidades (4 Caja de 6Uds.)`  
Ahora: `24,000 Unidades (4 Cajas de 6Uds.)`

### 2. Duplicación de "Uds."
Antes: `24,000 Unidades (4 Caja 6 Uds. 6 Uds.)`  
Ahora: `24,000 Unidades (4 Cajas de 6Uds.)`

## Solución Implementada

### Lógica de Pluralización
```xml
<t t-set="pkg_qty" t-value="int(move_line.quantity / packaging.qty) if packaging.qty else 0"/>

<!-- Condicional para plural/singular -->
<t t-if="pkg_qty > 1">Cajas</t>
<t t-else="">Caja</t>
```

### Corrección de Duplicación
**Causa:** Se usaba `<span t-field="packaging.name"/>` que imprimía el nombre del empaquetado (ej: "Caja") y luego se agregaba "Uds." manualmente.

**Solución:** Usar texto fijo "Caja/Cajas" con condicional y eliminar `t-field="packaging.name"`.

## Código Completo
```xml
<t t-if="move_line.move_id.product_packaging_id">
    <t t-set="packaging" t-value="move_line.move_id.product_packaging_id"/>
    <t t-set="pkg_qty" t-value="int(move_line.quantity / packaging.qty) if packaging.qty else 0"/>
    <span> (</span>
    <t t-esc="pkg_qty"/>
    <span> </span>
    <t t-if="pkg_qty > 1">Cajas</t>
    <t t-else="">Caja</t>
    <span> de </span>
    <t t-esc="int(packaging.qty)"/>
    <span>Uds.)</span>
</t>
```

## Ejemplos

| Cantidad | Empaque | Resultado |
|----------|---------|-----------|
| 6 Unidades | 6/Caja | `6 Unidades (1 Caja de 6Uds.)` |
| 12 Unidades | 6/Caja | `12 Unidades (2 Cajas de 6Uds.)` |
| 24 Unidades | 6/Caja | `24 Unidades (4 Cajas de 6Uds.)` |

## Deploy
```bash
# 1. Subir custom_delivery_report.zip vía FTPS
# 2. Descomprimir en /cloudclusters/odoo/odoo/addons/
# 3. Reiniciar Odoo
# 4. Apps → Upgrade "Custom Delivery Report"
```

## Resultado
Formato limpio con pluralización correcta y sin duplicaciones.

