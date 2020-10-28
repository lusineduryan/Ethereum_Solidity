pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract HelloWorld {
    string message;

    function setMessage(string memory newMessage) public {
        message = newMessage;
    }

    function getMessage() public view returns (string memory) {
        return message;
    }

    function remove() public {
        selfdestruct(address(0x0));
    }
}
