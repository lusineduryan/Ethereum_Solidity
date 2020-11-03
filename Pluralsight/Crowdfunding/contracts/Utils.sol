pragma solidity >=0.4.24;

library Utils {
    function etherToWei(uint sumInEth) public pure returns(uint) {
        return sumInEth * 1 ether;
    }

    function minutesToSeconds(uint timeInMinutes) public pure returns(uint) {
        return timeInMinutes * 1 minutes;
    }
}