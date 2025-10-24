# Add new version of the module in bash script

# 1. add new version of the module in bash script
unzip custom_delivery_report.zip && rm -rf custom_delivery_report.zip __MACOSX/ && supervisorctl start odoo

2. remove old version of the module in bash script
rm -rf custom_delivery_report && supervisorctl stop odoo