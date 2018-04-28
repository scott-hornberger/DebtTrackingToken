pragma solidity ^0.4.17;

import './DebtTrackingToken.sol';

////////////////////////////////////////////////////////////////////////////////
// A contract that payer contracts could inherit from track their debts, handle
// withdrawals, and announce debts to the DebtTrackingToken contract. The
//
// Note: This is a sketch of an idea for tracking debts and automating
// payments on the Ethereum blockchain.
////////////////////////////////////////////////////////////////////////////////
contract PayerInterface {
    /* MEMBER VARIABLES */
    // DebtTrackingToken object to interact with the contract
    DebtTrackingToken private debtTracker = DebtTrackingToken(
        // TODO: This needs to point at the DebtTrackingToken contract on the
        // blockchain. For my setup, the DebtTrackingToken contract is created
        // at this address. Your system may differ. The Payer/Payee Interfaces
        // will not function properly if this isn't the DebtTrackingToken address.
        // Migrate the DebtTrackingToken, then use that address here!
        0xAF42E86Cc52fC1CeCed626621CAf63f24175EE10
    );

    // Balances of those who the Payer owes money
    mapping(address => uint) public balances;

    /* MODIFIERS */
    // Require _payee to have balance
    modifier hasBalance(address _payee) { require(balances[_payee] > 0); _; }

    /* PUBLIC METHODS
        These methods are required to take part in the debt tracking system. */
    // Allows msg.sender to withdraw its balance
    function withdraw() public {
        withdraw(msg.sender);
    }

    // Allows an account to start the withdrawal process on _payee's behalf
    function withdraw(address _payee) hasBalance(_payee) public {
        uint balance = balances[_payee];
        balances[_payee] = 0;
        _payee.transfer(balance);
        debtTracker.clearDebt(_payee);
    }

    /* INTERNAL METHODS */
    // Adds _addBalance to _payee's balance, and announces the debt
    function addToBalance(address _payee, uint _addBalance) internal {
        balances[_payee] = safeAdd(balances[_payee], _addBalance);
        debtTracker.announceDebt(_payee, balances[_payee]);
    }

    // Sets _payee's balance to _newBalance, and announces the debt
    function setBalance(address _payee, uint _newBalance) internal {
        balances[_payee] = _newBalance;
        debtTracker.announceDebt(_payee, balances[_payee]);
    }

    // Checks for overflow after addition
    function safeAdd(uint a, uint b) internal pure returns (uint) {
        uint c = a + b;
        require(c >= a + b);
        return c;
    }
}
