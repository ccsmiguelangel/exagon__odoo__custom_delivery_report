# -*- coding: utf-8 -*-

from odoo import api, fields, models


class ResConfigSettings(models.TransientModel):
    """Configuración de formato de albarán por empresa"""
    _inherit = 'res.config.settings'

    use_custom_delivery_format = fields.Boolean(
        string='Usar formato personalizado de albarán',
        help='Activa el formato personalizado para PDF y email de albaranes.\n'
             'Formato: Producto | Lote/Nº serie | Entregado (con empaquetado)',
    )

    @api.model
    def get_values(self):
        """Obtener valor de configuración por empresa"""
        res = super(ResConfigSettings, self).get_values()
        company_id = self.env.company.id
        param_key = f'custom_delivery_report.use_custom_format.company_{company_id}'
        res.update(
            use_custom_delivery_format=self.env['ir.config_parameter'].sudo().get_param(
                param_key, default=False
            ) == 'True'
        )
        return res

    def set_values(self):
        """Guardar valor de configuración por empresa"""
        super(ResConfigSettings, self).set_values()
        company_id = self.env.company.id
        param_key = f'custom_delivery_report.use_custom_format.company_{company_id}'
        self.env['ir.config_parameter'].sudo().set_param(
            param_key,
            self.use_custom_delivery_format
        )

