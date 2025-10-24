# Fixes - Custom Delivery

## Índice de Correcciones

### ✅ v17.0.1.2.3 (2025-10-19) - FIX FORMATO ESTÁNDAR
**Bug:** Error con checkbox desactivado  
**Fix:** qty_done → quantity en formato estándar  
**Estado:** ✅ **FUNCIONA** - Ambos formatos operativos

### ✅ v17.0.1.2.2 (2025-10-19) - CON PLURALIZACIÓN
**Mejora:** Pluralización automática y eliminación de duplicación  
**Muestra:** "24,000 Unidades (4 Cajas de 6Uds.)"  
**Estado:** ✅ **FUNCIONA** - Caja/Cajas según cantidad

### ✅ v17.0.1.2.1 (2025-10-19) - FORMATO COMPLETO
**Mejora:** Formato idéntico al reporte de operaciones  
**Muestra:** "12,000 Unidades (2 Caja 6 Uds.) BCN/Stock"  
**Estado:** ✅ Funcionó pero sin pluralización

### ✅ v17.0.1.2.0 (2025-10-19) - CON EMPAQUETADO
**Mejora:** Agregada información básica de empaquetado  
**Solución:** Acceso correcto vía `move_line.move_id.product_packaging_id`  

### ✅ v17.0.1.1.1 (2025-10-19) - PRIMERA VERSIÓN FUNCIONAL
**Error:** `AttributeError: 'stock.move.line' object has no attribute 'product_packaging_id'`  
**Fix:** Eliminado código de empaquetado inexistente. Simplificado a campos nativos.  
**Estado:** ✅ Funcionó pero sin empaquetado  
**Archivo:** [FIX_v17.0.1.1.1.md](FIX_v17.0.1.1.1.md)

---

**Nota:** Todas las versiones anteriores (v1.0.0 - v1.1.0) NO funcionaron por usar campos inexistentes o funciones Python no soportadas en QWeb.

---

## Formato
Cada fix se documenta en `FIX_v{version}.md` con:
- Error exacto
- Causa raíz
- Solución aplicada
- Pasos de deploy
- Resultado esperado


