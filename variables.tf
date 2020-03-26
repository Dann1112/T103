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
  description = "Name of the Backoffice azure resource group."
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

##################
#VIRTUAL NETWORKS#
##################

variable "vnet_name" {
  description = "name for the m2 vnet."
  default     = "EU2-VNET01-PRD"
}

variable "vnet_hub_address_space" {
  description = "address range for vnet."
  default     = ["172.16.208.0/22"]
}

variable "vnet_m2_address_space" {
  description = "address range for vnet."
  default     = ["172.16.192.0/20"]
}

variable "vnet_ns_address_space" {
  description = "address range for vnet."
  default     = ["172.16.212.0/22"]
}

###### NS #######

variable "ns_alb_subnet_name" {
  description = "Name of the NS ALB subnet"
  default     = "EU2-VNET01-ALB-PRD"
}

variable "ns_nsip_subnet_name" {
  description = "Name of the NS NSIP subnet"
  default     = "EU2-VNET01-NSIP-PRD"
}

variable "ns_back_subnet_name" {
  description = "Name of the NS Backend subnet"
  default     = "EU2-VNET01-BACK-PRD"
}

variable "ns_nsip_subnet_range" {
  description = "IP range for NS NSIP subnet"
  default     = "172.16.212.0/24"
}

variable "ns_alb_subnet_range" {
  description = "IP range for NS ALB subnet"
  default     = "172.16.213.0/24"
}

variable "ns_back_subnet_range" {
  description = "IP range for NS Backend subnet"
  default     = "172.16.214.0/24"
}

####### M2 #######

variable "m2_front_subnet_name"{
  description = "Name of the M2 Frontend subnet"
  default     = "EU2-VNET01-FRONT-PRD"
}

variable "m2_front2_subnet_name"{
  description = "Name of the M2 Frontend subnet"
  default     = "EU2-VNET01-FRONT2-PRD"
}

variable "m2_agw_subnet_name"{
  description = "Name of the M2 Application Gateway subnet"
  default     = "EU2-VNET01-AGW-PRD"
}

variable "m2_api_subnet_name"{
  description = "Name of the M2 APIs subnet"
  default     = "EU2-VNET01-API-PRD"
}

variable "m2_legacy_subnet_name"{
  description = "Name of the M2 Legacy subnet"
  default     = "EU2-VNET01-LEGACY-PRD"
}

variable "m2_fsrvc_subnet_name"{
  description = "Name of the M2 Frontend Services subnet"
  default     = "EU2-VNET01-FSRVC-PRD"
}

variable "m2_srvc_subnet_name"{
  description = "Name of the M2 Services subnet"
  default     = "EU2-VNET01-SRVC-PRD"
}

variable "m2_back_subnet_name"{
  description = "Name of the M2 Backoffice subnet"
  default     = "EU2-VNET01-BACK-PRD"
}

variable "m2_data_subnet_name"{
  description = "Name of the M2 Data subnet"
  default     = "EU2-VNET01-DATA-PRD"
}

variable "m2_front2_subnet_range" {
  description = "IP range for M2 Frontend (React Version) subnet"
  default     = "172.16.192.0/26"
}

variable "m2_back_subnet_range" {
  description = "IP range for M2 Backoffice subnet"
  default     = "172.16.192.64/26"
}

variable "m2_front_subnet_range" {
  description = "IP range for M2 Frontend subnet"
  default     = "172.16.192.128/26"
}

variable "m2_fsrvc_subnet_range" {
  description = "IP range for M2 Frontend Services subnet"
  default     = "172.16.193.0/26"
}

variable "m2_srvc_subnet_range" {
  description = "IP range for M2 Services subnet"
  default     = "172.16.193.64/26"
}

variable "m2_legacy_subnet_range" {
  description = "IP range for M2 Legacy subnet"
  default     = "172.16.193.128/27"
}

variable "m2_data_subnet_range" {
  description = "IP range for M2 Data subnet"
  default     = "172.16.194.0/24"
}

variable "m2_agw_subnet_range" {
  description = "IP range for M2 Application Gateway subnet"
  default     = "172.16.195.0/27"
}

variable "m2_api_subnet_range" {
  description = "IP range for M2 APIs subnet"
  default     = "172.16.195.32/27"
}

##### HUB #####

variable "hub_rbast_subnet_name" {
  description = "Name of the bastion subnet"
  default     = "EU2-VNET01-RBAST01-PRD"
}

variable "hub_vpn_subnet_name" {
  description = "Name of the VPN subnet"
  default     = "EU2-VNET01-VPN-PRD"
}

variable "hub_rbast_subnet_range" {
  description = "IP range for bastion subnet"
  default     = "172.16.211.0/28"
}

variable "hub_vpn_subnet_range" {
  description = "IP range for VPN subnet"
  default     = "172.16.211.224/27"
}