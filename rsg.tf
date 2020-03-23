# Code for Resource Groups begins here.
# See https://www.terraform.io/docs/providers/azurerm/r/resource_group.html for syntax

resource "azurerm_resource_group" "vnet_hub_rsg" {
  name     = var.vnet_hub_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "vnet_m2_rsg" {
  name     = var.vnet_m2_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "vnet_ns_rsg" {
  name     = var.vnet_ns_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "api_rsg" {
  name     = var.api_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "back_rsg" {
  name     = var.back_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "front_rsg" {
  name     = var.front_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "data_rsg" {
  name     = var.data_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "mgmt_rsg" {
  name     = var.mgmt_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "ns_rsg" {
  name     = var.ns_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "services_rsg" {
  name     = var.services_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "rbast_rsg" {
  name     = var.rbast_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}


