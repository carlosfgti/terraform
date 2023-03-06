# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Create three Azure virtual machines
resource "azurerm_virtual_machine" "example_instances" {
  count                = 3
  name                 = "example-instance-${count.index + 1}"
  location             = "eastus"
  resource_group_name  = "example-resource-group"
  network_interface_ids = [azurerm_network_interface.example_nic.*.id]

  vm_size = "Standard_B1s"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "example-os-disk-${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "example-instance-${count.index + 1}"
    admin_username = "adminuser"
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }
}

# Create network interfaces for the virtual machines
resource "azurerm_network_interface" "example_nic" {
  count               = 3
  name                = "example-nic-${count.index + 1}"
  location            = "eastus"
  resource_group_name = "example-resource-group"

  ip_configuration {
    name                          = "example-ipconfig-${count.index + 1}"
    subnet_id                     = azurerm_subnet.example_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a subnet for the virtual machines
resource "azurerm_subnet" "example_subnet" {
  name                 = "example-subnet"
  resource_group_name  = "example-resource-group"
  virtual_network_name = "example-vnet"
  address_prefixes     = ["10.0.2.0/24"]
}
