# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

required_providers {
  random = {
    source  = "hashicorp/random"
    version = "~> 3.5.1"
  }

  null = {
    source  = "hashicorp/null"
    version = "~> 3.2.2"
  }
}

provider "random" "this" {}
provider "null" "this" {}

component "pet" {
  source = "./pet"

  inputs = {
    prefix = var.prefix
  }

  providers = {
    random = provider.random.this
  }
}

component "nulls" {
  source = "./nulls"

  inputs = {
    pet       = component.pet.name
    instances = var.instances
  }

  providers = {
    null = provider.null.this
  }
}

removed {
  source = "./nulls"

  from = component.nullsA
  providers = {
    null = provider.null.this
  }
}

#component "petz2" {
#  #source = "github.com/matejrisek/pet-only"
#  source = "git::ssh://github.com/matejrisek/pet-only.git"
#  inputs = {
#    prefix = var.prefix
#  }
#
#  providers = {
#    null = provider.null.this
#  }
#}
