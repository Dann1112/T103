###################
# VIRTUAL NETWORK #
###################

resource "azurerm_virtual_network" "vnet_hub" {
  name                = var.vnet_name
  address_space       = var.vnet_hub_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_hub_rsg.name

  subnet {
    name           = var.hub_rbast_subnet_name
    address_prefix = var.hub_rbast_subnet_range
    security_group = azurerm_network_security_group.hub_rbast_nsg.id
  }

  subnet {
    name           = var.hub_vpn_subnet_name
    address_prefix = var.hub_vpn_subnet_range
    security_group = azurerm_network_security_group.hub_vpn_nsg.id
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

########################
# SUBNETS DATA SOURCES #
########################

data "azurerm_subnet" "hub_rbast" {
  name                 = var.hub_rbast_subnet_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  resource_group_name  = azurerm_resource_group.vnet_hub_rsg.name
  depends_on           = [azurerm_virtual_network.vnet_hub]
}

data "azurerm_subnet" "hub_vpn" {
  name                 = var.hub_vpn_subnet_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  resource_group_name  = azurerm_resource_group.vnet_hub_rsg.name
  depends_on           = [azurerm_virtual_network.vnet_hub]
}

#############
# VNET NSGs #
#############

resource "azurerm_network_security_group" "hub_rbast_nsg" {
  name                = "${var.hub_rbast_subnet_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_hub_rsg.name

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PDFW"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "72.3.186.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PIAD"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "146.20.30.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PORD"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "161.47.6.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PHKG"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "120.136.39.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PLON"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "134.213.183.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PLON5"
    priority                   = 131
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "134.213.182.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PSYD"
    priority                   = 132
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "119.9.163.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PDFW"
    priority                   = 133
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "72.3.186.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PIAD"
    priority                   = 134
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "146.20.30.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PORD"
    priority                   = 135
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "161.47.6.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PHKG"
    priority                   = 136
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "120.136.39.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PLON"
    priority                   = 137
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "134.213.183.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PLON5"
    priority                   = 138
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "134.213.182.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PSYD"
    priority                   = 139
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "119.9.163.100/32"
    destination_address_prefix = var.hub_rbast_subnet_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "hub_vpn_nsg" {
  name                = "${var.hub_vpn_subnet_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_hub_rsg.name

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.hub_vpn_subnet_range
    destination_address_prefix = var.hub_vpn_subnet_range
  }

  security_rule {
    name                       = "Allow_AZURE_LB_INBOUND"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = var.hub_vpn_subnet_range
  }

  security_rule {
    name                       = "Allow_ApplicationGateway_Health_Ports_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "*"
    destination_address_prefix = var.hub_vpn_subnet_range
  }

  security_rule {
    name                       = "Allow_HTTP_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = var.hub_vpn_subnet_range
  }

  security_rule {
    name                       = "Allow_HTTPS_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = var.hub_vpn_subnet_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}