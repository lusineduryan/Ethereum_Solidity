pragma solidity ^0.5.0;

contract CrowdfundingWithDeadline {
    enum State { Ongoing, Failed, Succeeded, Paidout }

    string public name;
    uint public targetAmount;
    uint public fundingDeadline;
    address public beneficiary;
    State public state;
    mapping(address => uint) public amounts;
    bool public collected;
    uint public totalCollected;

    modifier inState(State expectedState) {
        require(state == expectedState, "Invalid State");
        _;
    }

    constructor(string memory contractName, uint targetAmountEth, uint durationInMin, address beneficiaryAddress) public {
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

    function beforeDeadline() public view returns(bool) {
        return currentTime() < fundingDeadline;
    }

    function currentTime() internal view returns(uint) {
        return now;
    }
}