resource "azurerm_resource_group" "resource_group" {
    name = "${var.name}-resource-group"
    location = "${var.location}"

    tags {
        environment = "${var.name}-environment"
    }
}
