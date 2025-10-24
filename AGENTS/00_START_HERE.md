# 🚀 Start Here

## Documentación Cursor Rules
Todo está en `.cursor/rules/`:

- `proyecto.mdc` - Visión general (lee primero)
- `python.mdc` - Convenciones Python/Odoo
- `qweb.mdc` - Reglas QWeb XML
- `troubleshooting.mdc` - Solución de problemas

## Scripts Útiles

### Diagnóstico
```bash
./AGENTS/diagnostico_modulo.sh
```

### Limpieza
```bash
./AGENTS/limpiar_modulo_bd.sh         # Solo BD
./AGENTS/LIMPIEZA_COMPLETA_MODULO.sh  # BD + archivos
```

### Recuperación
```bash
./AGENTS/RECUPERACION_EMERGENCIA.sh   # Reinicia Odoo
```

## Instalación Rápida
1. FTPS: Subir a `/cloudclusters/odoo/odoo/addons/`
2. Panel: Reiniciar Odoo
3. Odoo: Apps → Update Apps List → Instalar

## Estructura Proyecto
```
.cursor/rules/          ← Reglas Cursor (lee primero)
AGENTS/                 ← Scripts útiles
custom_delivery_report/ ← Módulo (nombre nuevo)
custom_delivery_email/  ← Módulo (nombre viejo, mismo código)
```

## Para IA
Lee `.cursor/rules/proyecto.mdc` para contexto completo.
