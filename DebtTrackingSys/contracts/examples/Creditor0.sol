pragma solidity ^0.4.17;

import '../PayeeInterface.sol';

contract Creditor0 is PayeeInterface {
    function Creditor0() public payable {}

    function () public payable {
    }

    function thisBalance() public view returns (uint) {
        return address(this).balance;
    }
}
