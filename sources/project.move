module MyModule::DAOVotingPlatform {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    /// Struct representing a proposal.
    struct Proposal has store, key {
        description: vector<u8>,  // Proposal description
        yes_votes: u64,           // Total yes votes
        no_votes: u64,            // Total no votes
    }

    /// Function to create a new proposal.
    public fun create_proposal(owner: &signer, description: vector<u8>) {
        let proposal = Proposal {
            description,
            yes_votes: 0,
            no_votes: 0,
        };
        move_to(owner, proposal);
    }

    /// Function to vote on a proposal.
    public fun vote_on_proposal(voter: &signer, owner: address, vote_yes: bool) acquires Proposal {
        let proposal = borrow_global_mut<Proposal>(owner);

        // Increase vote count based on the user's vote
        if (vote_yes) {
            proposal.yes_votes = proposal.yes_votes + 1;
        } else {
            proposal.no_votes = proposal.no_votes + 1;
        }
    }

}
