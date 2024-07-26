module MyModule {
    struct Identity has copy, drop, store {
        email: vector<u8>,
        cin: vector<u8>,
    }

    public fun create_identity(account: &signer, email: vector<u8>, cin: vector<u8>) {
        let identity = Identity { email, cin };
        move_to(account, identity);
    }

      public fun verify_identity(account: &signer, email: vector<u8>, cin: vector<u8>): bool {
        let identity = borrow_global<Identity>(Signer::address_of(account));
        vector::equal(&identity.email, &email) && vector::equal(&identity.cin, &cin)
    }
}
