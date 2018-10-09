resource "azurerm_virtual_network" "terraformTestNetwork" {
    name = "myvnet"
    address_space = ["10.0.0.0/16"]
    location = "eastus"
    resource_group_name = "${azurerm_resource_group.terraformTest.name}"

    tags {
        environment = "Terraform Demo"
    }
}

resource "azurerm_subnet" "terraformTestSubnet1" {
    name = "mySubnet"
    resource_group_name = "${azurerm_resource_group.terraformTest.name}"
    virtual_network_name = "${azurerm_virtual_network.terraformTestNetwork.name}"
    address_prefix = "10.0.2.0/24"

}

resource "azurerm_public_ip" "terraformTestPublicIp" {
    name = "publicIp"
    location = "eastus"
    resource_group_name = "${azurerm_resource_group.terraformTest.name}"
    public_ip_address_allocation = "dynamic"

    tags {
        environment = "Terraform Demo"
    }
}

