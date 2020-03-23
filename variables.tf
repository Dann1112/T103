provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  version         = 2.0
  features        {}
}

variable "subscription_id" {
  description = "Enter Subscription ID for provisioning resources in Azure"
}

variable "client_id" {
  description = "Enter Client ID for Application created in Azure AD"
}

variable "client_secret" {
  description = "Enter Client secret for Application in Azure AD"
}

variable "tenant_id" {
  description = "Enter Tenant ID / Directory ID of your Azure AD. Run Get-AzureSubscription to know your Tenant ID"
}

variable "buildby" {
  description = "Name of the builder"
  default     = "Daniel Manrique"
}

variable "buildticket" {
  description = "Ticket Number for the build"
  default     = "03232020-01"
}

variable "environment" {
  description = "Prod,QA,STG,DEV,etc."
  default     = "Prod"
}

variable "location" {
  description = "Azure region for the environment."
  default     = "East US 2"
}

###################
# RESOURCE GROUPS #
###################

variable "vnet_hub_rsg_name" {
  description = "Name of the VNET azure resource group."
  default     = "EU2-PRD-VNET-HUB"
}

variable "vnet_m2_rsg_name" {
  description = "Name of the VNET azure resource group."
  default     = "EU2-PRD-VNET-M2"
}

variable "vnet_ns_rsg_name" {
  description = "Name of the VNET azure resource group."
  default     = "EU2-PRD-VNET-NS"
}

variable "ns_rsg_name" {
  description = "Name of the NetScaler azure resource group."
  default     = "EU2-PRD-NS"
}

variable "front_rsg_name" {
  description = "Name of the Frontend azure resource group."
  default     = "EU2-PRD-FRONT"
}

variable "api_rsg_name" {
  description = "Name of the API azure resource group."
  default     = "EU2-PRD-API"
}

variable "services_rsg_name" {
  description = "Name of the Services azure resource group."
  default     = "EU2-PRD-SERV"
}

variable "back_rsg_name" {
  description = "Name of the Backend azure resource group."
  default     = "EU2-PRD-BACK"
}

variable "data_rsg_name" {
  description = "Name of the Data azure resource group."
  default     = "EU2-PRD-DATA"
}

variable "mgmt_rsg_name" {
  description = "Name of the MGMT azure resource group."
  default     = "EU2-PRD-MGMT"
}

variable "rbast_rsg_name" {
  description = "Name of the bastion azure resource group."
  default     = "EU2-RSG-RAX-SFT"
}

