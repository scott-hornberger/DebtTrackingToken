pragma solidity ^0.4.17;

import './OweTokenCreditor.sol';
import './Debtor.sol';

contract Creditor is OweTokenCreditor {
    function Creditor() public payable {}

    function sendEtherToAccount(address _acct, uint _amt) public {
        require(address(this).balance > _amt);
        Debtor(_acct).pay.value(_amt)();
    }

    function () public payable {
    }

    function thisBalance() public view returns (uint) {
        return address(this).balance;
    }
}
