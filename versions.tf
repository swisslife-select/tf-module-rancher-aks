terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.37.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  required_version = ">= 0.13"
}
