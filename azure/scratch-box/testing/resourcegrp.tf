resource "azurerm_resource_group" "terraformTest" {
    name = "terraformTestGroup"
    location = "eastus"

    tags {
        environment = "Terraform Demo"
    }
}
