String defaultStore = """query GetDefaultStore {
    GetDefaultStore {
        id
        storeName
        phoneNumber
        officialemail
        zipcode
        streetAddress1
        streetAddress2
        GSTIN
        logo {
            id
            preview
            source
        }
    }
}""";

String vendorInfo = """query GetVendorInfo {
    GetVendorInfo {
        id
        vendorName
        phoneNumber
        email
        store {
            id
            storeName
            phoneNumber
            officialemail
            zipcode
            streetAddress1
            streetAddress2
            GSTIN
            singleStore
            rentalStore
            channelMarkets
            balance {
                id
                balance
                updatedAt
                balanceVolume
            }
        }
    }
}""";


String getSingleVendor = """query GetSingleVendor(\$id: ID!){
    vendor(id: \$id) {
        id
        vendorName
        phoneNumber
        email
        store {
            id
            storeName
            phoneNumber
            officialemail
            zipcode
            streetAddress1
            streetAddress2
            GSTIN
            singleStore
            rentalStore
            channelMarkets
            balance {
                id
                balance
                updatedAt
                balanceVolume
            }
        }
    }
}""";


String getOrderLines = """query GetOrderLines(\$id: ID, \$limit: Int, \$offset: Int){
    orderLines(
        filter: {
            store:{
                id: {
                    eq: \$id
                }
            }
        },
        paging: {
            limit: \$limit
            offset: \$offset
        },
        sorting:{
            field:createdAt
            direction:ASC
        }
    ) {
        id
        priceField
        createdAt
        stage
        store {
            id
            storeName
            phoneNumber
        }
        item {
            id
            quantity
            productVariant {
                id
                name
            }
        }
        order {
            id
            totalPrice
            address
            user{
                id
                firstName
                lastName
            }
        }
    }
}
""";

String getSingleOrderLine = """query GetSingleOrderLine(\$id: ID!){
    orderLine(
        id: \$id
    ) {
        id
        priceField
        stage
        store {
            id
            storeName
        }
        item {
            id
            quantity
            productVariant {
                id
                name
            }
        }
        order {
            id
            address
            createdAt
              user {
                id
                firstName
                lastName
                phoneNumber
            }
        }
    }
}""";