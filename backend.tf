terraform {

    backend "azurerm {
        resource_group_name = "rsg-storage_accounts"
        storage_account_name = "gdalestorageacc01"
        container_name = "gdalestoragecontainer01"
    }
}