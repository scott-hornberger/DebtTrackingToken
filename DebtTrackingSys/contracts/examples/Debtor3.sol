pragma solidity ^0.4.17;

import '../PayerInterface.sol';

contract Debtor3 is PayerInterface {
    function Debtor3() public payable {}

    function addCreditor(address _creditor, uint _amount) public {
        addToBalance(_creditor, _amount);
    }

    function thisBalance() public view returns (uint) {
        return address(this).balance;
    }
}
