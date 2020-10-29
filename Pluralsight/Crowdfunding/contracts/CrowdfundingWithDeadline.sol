pragma solidity ^0.5.0;

contract CrowdfundingWithDeadline {
    enum State { Ongoing, Failed, Succeeded, Paidout }

    string public name;
    uint public targetAmount;
    uint public fundingDeadline;
    address payable public beneficiary;
    State public state;
    mapping(address => uint) public amounts;
    bool public collected;
    uint public totalCollected;

    modifier inState(State expectedState) {
        require(state == expectedState, "Invalid State");
        _;
    }

    constructor(string memory contractName, uint targetAmountEth, uint durationInMin, address payable beneficiaryAddress) public {
        name = contractName;
        targetAmount = targetAmountEth * 1 ether;
        fundingDeadline = currentTime() + durationInMin * 1 minutes;
        beneficiary = beneficiaryAddress;
        state = State.Ongoing;
    }

    function contribute() public payable inState(State.Ongoing) {
        require(beforeDeadline(), "No contributions after the deadline!");
        amounts[msg.sender] += msg.value;
        totalCollected += msg.value;

        if(totalCollected >= targetAmount) {
            collected = true;
        }
    }

    function finishCrowdfunding() public inState(State.Ongoing) {
        require(!beforeDeadline(), "Cannot fininsh campaign before the deadline!");

        if(!collected) {
            state = State.Failed;
        } else {
            state = State.Succeeded;
        }
    }

    function collect() public inState(State.Succeeded) {
        if(beneficiary.send(totalCollected)) {
            state = State.Paidout;
        } else {
            state = State.Failed;
        }
    }

    function withdraw() public inState(State.Failed) {
        require(amounts[msg.sender] > 0, "Nothing was contributed!");
        uint contribution = amounts[msg.sender];
        amounts[msg.sender] = 0;

        if(!msg.sender.send(contribution)) {
            amounts[msg.sender] = contribution;
        }
    }

    function beforeDeadline() public view returns(bool) {
        return currentTime() < fundingDeadline;
    }

    function currentTime() internal view returns(uint) {
        return now;
    }
}