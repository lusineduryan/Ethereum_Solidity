pragma solidity ^0.5.0;

contract CrowdfundingWithDeadline {
    enum State { Ongoing, Failed, Succeeded, Paidout }

    string public name;
    uint public targetAmount;
    uint public fundingDeadline;
    address public beneficiary;
    State public state;

    constructor(string memory contractName, uint targetAmountEth, uint durationInMin, address beneficiaryAddress) public {
        name = contractName;
        targetAmount = targetAmountEth * 1 ether;
        fundingDeadline = currentTime() + durationInMin * 1 minutes;
        beneficiary = beneficiaryAddress;
        state = State.Ongoing;
    }

    function currentTime() internal view returns(uint) {
        return now;
    }
}