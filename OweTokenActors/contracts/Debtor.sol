pragma solidity ^0.4.17;

import './OweTokenDebtor.sol';

contract Debtor is OweTokenDebtor {
    function Debtor() public payable {}

    function pay() public payable {
        require(msg.value > 0);
        addToBalance(msg.sender, msg.value);
    }

    function thisBalance() public view returns (uint) {
        return address(this).balance;
    }
}
