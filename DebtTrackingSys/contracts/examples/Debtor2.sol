pragma solidity ^0.4.17;

import '../PayerInterface.sol';

contract Debtor2 is PayerInterface {
    function Debtor2() public payable {}

    function addCreditor(address _creditor, uint _amount) public {
        addToBalance(_creditor, _amount);
    }

    function thisBalance() public view returns (uint) {
        return address(this).balance;
    }
}
