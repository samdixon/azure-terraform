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

resource "azurerm_network_security_group" "terraformTestNSG" {
    name = "NetworkSecurityGroup"
    location = "eastus"
    resource_group_name = "${azurerm_resource_group.terraformTest.name}"

    security_rule {
        name = "SSH"
        priority = 1001
        direction = "inbound"
        access = "allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

    tags {
        environment = "Terraform Demo"
    }
}

resource "azurerm_network_interface" "terraformTestNic" {
    name = "MyNic"
    location = "eastus"
    resource_group_name = "${azurerm_resource_group.terraformTest.name}"
    network_security_group_id = "${azurerm_network_security_group.terraformTestNSG.id}"

    ip_configuration {
        name = "myNicConfiguration"
        subnet_id = "${azurerm_subnet.terraformTestSubnet1.id}"
        private_ip_address_allocation = "dynamic"
        private_ip_address = "${azurerm_public_ip.terraformTestPublicIp.id}"
    }

    tags {
        environment = "Terraform Demo"
    }
}


