# Custom Delivery Report - Módulo Odoo 17

## 📋 Descripción

Módulo para personalizar reportes (PDF y Email) de albaranes de entrega en Odoo 17, configurable por empresa.

### Características

- ✅ **Formato personalizado** de tabla en PDF y Email
- ✅ **Configurable por empresa** (multiempresa seguro)
- ✅ **Columnas personalizadas**: Producto | Lote/Nº serie | Entregado
- ✅ **Formato de cantidad** con detalles de empaquetado: "6,000 Unidades (1 Caja 6 Uds.)"

---

## 🚀 Instalación en CloudClusters

### 1. Transferir módulo vía FTPS

```
Ruta destino: /cloudclusters/odoo/odoo/addons/custom_delivery_report/
```

Subir toda la carpeta `custom_delivery_report` con su contenido.

### 2. Activar módulo en Odoo

1. Ir a **Aplicaciones** (Apps)
2. Clic en **Actualizar lista de aplicaciones** (Update Apps List)
3. Quitar filtro "Aplicaciones" y buscar: `custom delivery report`
4. Clic en **Instalar**

---

## ⚙️ Configuración

### Activar formato personalizado por empresa

1. Ir a **Ajustes** > **Inventario** > **Operaciones**
2. Buscar sección **"Usar formato personalizado de albarán"**
3. Activar el switch ✅
4. Clic en **Guardar**

**Importante**: Cada empresa debe activarlo individualmente desde su configuración.

---

## 📊 Uso

### Reporte PDF

Al generar un albarán de entrega desde **Inventario > Operaciones**:
- Si la empresa tiene activado el formato: muestra tabla personalizada
- Si no está activado: muestra formato estándar Odoo

### Email

Usar la plantilla **"Albarán de Entrega - Formato Personalizado"**:

1. Desde el albarán, clic en **Enviar por email**
2. Seleccionar plantilla: `Albarán de Entrega - Formato Personalizado`
3. Enviar

---

## 🔍 Estructura del Módulo

```
custom_delivery_report/
├── __init__.py
├── __manifest__.py
├── README.md
├── models/
│   ├── __init__.py
│   └── res_config_settings.py         # Configuración por empresa
├── data/
│   └── mail_template_delivery.xml     # Plantilla de email
└── views/
    ├── report_deliveryslip.xml        # Vista PDF personalizada
    └── res_config_settings_views.xml  # UI de configuración
```

---

## 🔒 Seguridad Multiempresa

- ✅ Cada empresa controla su configuración independientemente
- ✅ No afecta empresas que no activen el módulo
- ✅ Sin modificaciones al core de Odoo
- ✅ Desactivación reversible en cualquier momento

---

## 📝 Formato de Tabla

### Columnas

| Producto | Lote/Nº de serie | Entregado |
|----------|------------------|-----------|
| [MB0200] Caldo de Huesos de Pollo... | L1 191124PP2 Cad: Nov-25 | 6,000 Unidades (1 Caja 6 Uds.) |

### Campos de Odoo utilizados

- `move_line_ids.product_id.display_name` → Producto
- `move_line_ids.lot_id.name` → Lote/Nº de serie
- `move_line_ids.qty_done` → Cantidad entregada
- `move_line_ids.product_packaging_id` → Empaquetado (Caja, Pallet, etc.)
- `move_line_ids.product_packaging_qty` → Cantidad de paquetes

---

## 🛠️ Desinstalación

Si se necesita desinstalar:

1. Desactivar el switch en todas las empresas que lo usen
2. Ir a **Aplicaciones**
3. Buscar `custom delivery report`
4. Clic en **Desinstalar**

---

## 📌 Versión

- **Odoo**: 17.0 Community
- **Módulo**: 1.0.0
- **Licencia**: LGPL-3

---

## 💡 Notas Técnicas

- Campo de configuración: `use_custom_delivery_format` (company_dependent)
- Config parameter: `custom_delivery_report.use_custom_format`
- Herencia de vista: `stock.report_delivery_document`
- Compatible con Docker/Kubernetes

---

## 📞 Soporte

Para problemas o preguntas sobre el módulo, revisar:
- Logs de Odoo en CloudClusters
- Ajustes > Técnico > Email > Plantillas (verificar plantilla creada)

