
    module address::IdentityManagement {
        use std::signer;
        

        struct Identity has key {
            id: u64,
            name: vector<u8>,
            email: vector<u8>,
            verified: bool,
        }

        public fun register_identity(account: &signer, id: u64, name: vector<u8>, email: vector<u8>) {
            let identity = Identity { id, name, email, verified: false };
            move_to(account, identity);
        }

        public fun verify_identity(account: &signer) acquires Identity {
            let identity = borrow_global_mut<Identity>(signer::address_of(account));
            identity.verified = true;
        }

        public fun is_identity_valid(account: &signer, id: u64): bool acquires Identity {
            let identity = borrow_global<Identity>(signer::address_of(account));
            identity.id == id && identity.verified
        }
    }

