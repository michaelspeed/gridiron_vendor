String login = """mutation administratorLogin(\$email: String!, \$password: String!){
    administratorLogin(email: \$email, password: \$password) {
        user {
            id
            firstName
            lastName
            verified
            phoneNumber
        }
        token
        store {
            id
        }
        type
    }
}""";