resource "random_string" "username" {
  length  = 6
  special = false
}

resource "random_password" "pw" {
  length = 16
}

resource "azurerm_mysql_flexible_server" "db_server" {
  name                   = "${var.name}db"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  administrator_login    = random_string.username.result
  administrator_password = random_password.pw.result
  backup_retention_days  = 7
  version                = "8.0.21"
  zone                   = "2"
  sku_name = "B_Standard_B1ms"
}

resource "azurerm_mysql_flexible_database" "db" {
  name                = var.name
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.db_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "example" {
  name                = "azure_services"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.db_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}