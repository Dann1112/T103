###################
# VIRTUAL NETWORK #
###################

resource "azurerm_virtual_network" "vnet_ns" {
  name                = var.vnet_name
  address_space       = var.vnet_ns_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_ns_rsg.name

  subnet {
    name           = var.ns_alb_subnet_name
    address_prefix = var.ns_alb_subnet_range
    security_group = azurerm_network_security_group.ns_alb_nsg.id
  }

  subnet {
    name           = var.ns_nsip_subnet_name
    address_prefix = var.ns_nsip_subnet_range
    security_group = azurerm_network_security_group.ns_nsip_nsg.id
  }

  subnet {
    name           = var.ns_back_subnet_name
    address_prefix = var.ns_back_subnet_range
    security_group = azurerm_network_security_group.ns_back_nsg.id
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

data "azurerm_subnet" "ns_alb" {
  name                 = var.ns_alb_subnet_name
  virtual_network_name = azurerm_virtual_network.vnet_ns.name
  resource_group_name  = azurerm_resource_group.vnet_ns_rsg.name
  depends_on           = [azurerm_virtual_network.vnet_ns]
}

data "azurerm_subnet" "ns_nsip" {
  name                 = var.ns_nsip_subnet_name
  virtual_network_name = azurerm_virtual_network.vnet_ns.name
  resource_group_name  = azurerm_resource_group.vnet_ns_rsg.name
  depends_on           = [azurerm_virtual_network.vnet_ns]
}

data "azurerm_subnet" "ns_back" {
  name                 = var.ns_back_subnet_name
  virtual_network_name = azurerm_virtual_network.vnet_ns.name
  resource_group_name  = azurerm_resource_group.vnet_ns_rsg.name
  depends_on           = [azurerm_virtual_network.vnet_ns]
}


#############
# VNET NSGs #
#############

resource "azurerm_network_security_group" "ns_alb_nsg" {
  name                = "${var.ns_alb_subnet_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_ns_rsg.name

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
    source_address_prefix      = var.ns_alb_subnet_range
    destination_address_prefix = var.ns_alb_subnet_range
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
    destination_address_prefix = var.ns_alb_subnet_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_RDP_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.ns_alb_subnet_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SSH_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.ns_alb_subnet_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_WinRM_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.ns_alb_subnet_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SFTBROKER_INBOUND"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.ns_alb_subnet_range
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

resource "azurerm_network_security_group" "ns_nsip_nsg" {
  name                = "${var.ns_nsip_subnet_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_ns_rsg.name

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
    source_address_prefix      = var.ns_nsip_subnet_range
    destination_address_prefix = var.ns_nsip_subnet_range
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
    destination_address_prefix = var.ns_nsip_subnet_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_RDP_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.ns_nsip_subnet_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SSH_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.ns_nsip_subnet_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_WinRM_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.ns_nsip_subnet_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SFTBROKER_INBOUND"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.ns_nsip_subnet_range
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

resource "azurerm_network_security_group" "ns_back_nsg" {
  name                = "${var.ns_back_subnet_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_ns_rsg.name

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
    source_address_prefix      = var.ns_back_subnet_range
    destination_address_prefix = var.ns_back_subnet_range
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
    destination_address_prefix = var.ns_back_subnet_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_RDP_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.ns_back_subnet_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SSH_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.ns_back_subnet_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_WinRM_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.ns_back_subnet_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SFTBROKER_INBOUND"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = var.hub_rbast_subnet_range
    destination_address_prefix = var.ns_back_subnet_range
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

