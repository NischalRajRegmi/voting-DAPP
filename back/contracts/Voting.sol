pragma solidity >=0.4.22 <0.9.0;

contract Voting {

    struct Voter{
        uint256 voter_id;
        bool voted;
    }

    struct Candidate {
        string name;
        string party;
        uint256 vote_count;
    }

    address public admin;

    uint256 public candidate_count;
    // Candidate[] candidates;
    event voted(address voted_by, string candidate_name);

    mapping(address => Voter) public voters;
    mapping(uint256 => Candidate) candidates;

    constructor() {
        admin = msg.sender;
        candidate_count = 0;
    }

    function change_admin(address new_admin) public {
        require(msg.sender == admin, "Only old admin can change admin.");
        admin = new_admin;
    }

    function vote(uint256 candidate_id) public {
        Voter storage vote_sender = voters[msg.sender];
        require(vote_sender.voter_id != 0, "User should first provide their citizenship number");
        require(!vote_sender.voted, "Already voted");
        require(candidate_id < candidate_count, "Candidate S.N. doesnot exists");
        vote_sender.voted = true;
        candidates[candidate_id].vote_count++;
        emit voted(msg.sender, candidates[candidate_id].name);
    }

    function insert_candidate(string memory n_name, string memory p_party) public {
        require(bytes(n_name).length > 0, "Insert name properly");
        require(bytes(p_party).length > 0, "Insert party properly");
        require(msg.sender == admin, "Only admin can add candidates");

        Candidate memory candidate = Candidate({
            name: n_name,
            party: p_party,
            vote_count: 0
        });

        candidates[candidate_count] = candidate;
        candidate_count++;
    }

    function remove_candidate(uint256 c_id) public {
        require(msg.sender == admin, "Only admin can remove candidates");
        if(c_id < candidate_count) {
            for (uint256 i = c_id; i < candidate_count - 1; i++) {
                candidates[i] = candidates[i+1];
            }
            candidate_count--;
        } 
    }

    function initialize_voter(uint256 c_id) public {
        Voter storage vote_sender = voters[msg.sender];
        require(vote_sender.voter_id == 0, "Citizenship id already initialized");
        vote_sender.voter_id = c_id;
    }

    function get_candidate(uint256 c_id) public view returns (Candidate memory) {
        require(c_id < candidate_count, "Candidate not Available");
        return candidates[c_id];
    }

    function has_voted() public view returns (bool) {
        return voters[msg.sender].voted;
    }

    function has_vid() public view returns (bool) {
        return voters[msg.sender].voter_id > 0;
    }

}