pragma solidity ^0.4.17;

////////////////////////////////////////////////////////////////////////////////
// Example of a contract that does not inherit from PayeeInterface contract.
// Made to illustrate the options available to already-created contracts that
// wish to be interact with DebtTrackingInterfaceSystem.
////////////////////////////////////////////////////////////////////////////////
// NOTE: This contract does NOT inherit from the PayeeInterface class.
// To get the funds owed to it by some contract D that inherits from the
// PayerInterface contract, an account will have to interact with the DebtTrackingInterfaceMain
// contract by calling claimNextEther(<this contract's address>), which will
// prompt contract D to transfer ether to <this contract's address> if this
// contract has a balance with contract D.
//
// If Debtor D does not inherit the PayerInterface class, then this contract will
// have to intereact the "old" way by calling Debtor D's withdraw() method, or
// some equivalent (per Debtor D's implementation).
////////////////////////////////////////////////////////////////////////////////
contract Creditor1 {
    function Creditor1() public payable {}

    function () public payable {
    }

    function thisBalance() public view returns (uint) {
        return address(this).balance;
    }
}
