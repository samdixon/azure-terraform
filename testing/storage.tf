resource "random_id" "randomId" {
    keepers = {
        resource_group = "${azurerm_resource_group.terraformTest.name}"
    }

    byte_length = 8
}

resource "azurerm_storage_account" "myStorageAccount" {
    name = "diag${random_id.randomId.hex}"
    resource_group_name = "${azurerm_resource_group.terraformTest.name}"
    location = "eastus"
    account_replication_type = "LRS"
    account_tier = "Standard"

    tags {
        environment = "Terraform Demo"
    }
}
