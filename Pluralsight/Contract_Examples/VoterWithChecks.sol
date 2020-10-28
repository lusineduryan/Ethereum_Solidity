pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract VoterWithChecks {

    uint[] public votes;
    mapping (address => bool) hasVoted;
    string[] public options;

    constructor(string[] memory _options) public {
        options = _options;
        votes.length = options.length;
    }

    function vote(uint option) public {
        require(0 <= option && option < options.length, "Invalid option");
        require(!hasVoted[msg.sender], "Account has already voted");

        hasVoted[msg.sender] = true;
        votes[option] = votes[option] + 1;
    }

    function getOptions() public view returns (string[] memory) {
        return options;
    }

    function getVotes() public view returns (uint[] memory) {
        return votes;
    }
}