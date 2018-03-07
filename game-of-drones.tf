resource "azurerm_resource_group" "funcapp" {
  name     = "${var.resource_group_name}"
  location = "${var.region}"
}

resource "azurerm_storage_account" "funcapp" {
  name                     = "fnadminstore"
  resource_group_name      = "${azurerm_resource_group.funcapp.name}"
  location                 = "${azurerm_resource_group.funcapp.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "dronestorage" {
  name                     = "${var.storage_account_name == "default" ? join("", list("fn0st0", replace(var.function_app_name, "/[^a-z0-9]/", ""))) : var.storage_account_name}"
  resource_group_name      = "${azurerm_resource_group.funcapp.name}"
  location                 = "${azurerm_resource_group.funcapp.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_app_service_plan" "funcapp" {
  name                = "${var.service_plan_name == "default" ? join("", list("fn0sp0", replace(var.function_app_name, "/[^a-z0-9]/", ""))) : var.service_plan_name}"
  location            = "${azurerm_resource_group.funcapp.location}"
  resource_group_name = "${azurerm_resource_group.funcapp.name}"

  sku {
    tier     = "${var.service_plan_tier}"
    size     = "${var.service_plan_size}"
    capacity = "${var.service_plan_capacity}"
  }
}

resource "azurerm_function_app" "funcapp" {
  name                      = "${var.function_app_name}"
  location                  = "${azurerm_resource_group.funcapp.location}"
  resource_group_name       = "${azurerm_resource_group.funcapp.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.funcapp.id}"
  storage_connection_string = "${azurerm_storage_account.funcapp.primary_connection_string}"

  #  version                   = "${var.version}"
  app_settings {
    "backdrone_STORAGE" = "${azurerm_storage_account.dronestorage.primary_connection_string}"
  }

  provisioner "local-exec" {
    command = "echo $(az functionapp deployment source config --repo-url ${var.function_app_git_source} --name ${var.function_app_name} --resource-group ${var.resource_group_name})"
  }
}
