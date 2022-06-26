resource azurerm_network_security_group mgmt_snet_nsg {
  name                = local.mgmt_snet_nsg_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource azurerm_network_security_rule mgmt_snet_allow_inbound_nsg_rule {
  count                       = var.mgmt_snet_allow_ip_list == null ? 0 : 1
  name                        = "allow-inbound"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = local.mgmt_snet_allow_ip_list
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.mgmt_snet_nsg.name
}

resource azurerm_subnet_network_security_group_association mgmt_snet_nsg_assoc {
  subnet_id                 = azurerm_subnet.mgmt_snet.id
  network_security_group_id = azurerm_network_security_group.mgmt_snet_nsg.id
}

resource azurerm_network_security_group dns_snet_nsg {
  name                = local.dns_snet_nsg_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource azurerm_network_security_rule dns_snet_allow_inbound_nsg_rule {
  count                       = var.dns_snet_allow_ip_list == null ? 0 : 1
  name                        = "allow-inbound"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = local.dns_snet_allow_ip_list
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.dns_snet_nsg.name
}

resource azurerm_subnet_network_security_group_association dns_snet_nsg_assoc {
  subnet_id                 = azurerm_subnet.dns_snet.id
  network_security_group_id = azurerm_network_security_group.dns_snet_nsg.id
}