pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract MultiSigWallet {
    uint minApprovers;

    address payable beneficiary;
    address payable owner;

    mapping (address => bool) approvedBy;
    mapping (address => bool) isApprover;
    uint approvalsNum;

    constructor(address[] memory _approvers, uint _minApprovers, address payable _beneficiary) public payable {
        require(
            _minApprovers <= _approvers.length,
            "Required number of apporvers should be less than number of approvers");

        minApprovers = _minApprovers;
        beneficiary = _beneficiary;
        owner = msg.sender;

        for (uint i = 0; i < _approvers.length; i++) {
            address approver = _approvers[i];
            isApprover[approver] = true;
        }
    }

    function approve() public {
        require(isApprover[msg.sender], "Not an approver");
        if (!approvedBy[msg.sender]) {
            approvedBy[msg.sender] = true;
            approvalsNum++;
        }

        if (approvalsNum == minApprovers) {
            beneficiary.send(address(this).balance);
            selfdestruct(owner);
        }
    }

    function reject() public {
        require(isApprover[msg.sender], "Not an approver");

        selfdestruct(owner);
    }
}