# -*- coding: utf-8 -*-
{
    'name': 'Custom Delivery Report',
    'version': '17.0.1.2.2',
    'category': 'Inventory/Delivery',
    'summary': 'Personaliza reportes de albarán (PDF y Email) por empresa',
    'description': """
        Módulo configurable por empresa que personaliza reportes de albarán:
        - Formato PDF personalizado de albarán de entrega
        - Plantilla de email personalizada con tabla detallada
        - Columnas: Producto | Lote/Nº serie | Entregado (con empaquetado)
        
        Cada empresa puede activar/desactivar el formato personalizado
        independientemente desde Ajustes > Inventario > Operaciones
    """,
    'author': 'ccsmiguelangel',
    'license': 'LGPL-3',
    'depends': [
        'stock',
        'mail',
    ],
    'data': [
        'views/res_config_settings_views.xml',
        'views/report_deliveryslip.xml',
        'data/mail_template_delivery.xml',
    ],
    'installable': True,
    'application': False,
    'auto_install': False,
}

