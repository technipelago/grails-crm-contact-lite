navigation = {
    main(global: true) {
        crmContact controller: 'crmContact', action: 'index', order: 10
    }
    admin(global: true) {
        crmAddressType controller: 'crmAddressType', action: 'index', order: 110
        crmContactCategoryType controller: 'crmContactCategoryType', action: 'index', order: 120
    }
}