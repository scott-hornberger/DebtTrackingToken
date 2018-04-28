pragma solidity ^0.4.17;

import './DebtTrackingToken.sol';

////////////////////////////////////////////////////////////////////////////////
// Optional contract that payee contracts could inherit from to allow them to
// communicate directly with the DebtTrackingToken through this contract
//
// Note: This is a sketch of an idea for tracking debts and automating
// payments on the Ethereum blockchain.
////////////////////////////////////////////////////////////////////////////////
contract PayeeInterface {
    // DebtTrackingToken object to interact with the contract
    DebtTrackingToken private debtTracker = DebtTrackingToken(
        // TODO: This needs to point at the DebtTrackingToken contract on the
        // blockchain. For my setup, the DebtTrackingToken contract is created
        // at this address. Your system may differ. The Payer/Payee Interfaces
        // will not function properly if this isn't the DebtTrackingToken address.
        // Migrate the DebtTrackingToken, then use that address here!
        0xAF42E86Cc52fC1CeCed626621CAf63f24175EE10
    );

    // Queries debtTracker to see the number of debts owed to this contract
    function numDebtsOwedToContract() public view returns (uint) {
        return debtTracker.balanceOf(this);
    }

    // Queries debtTracker to see if this contract has any debts owed it
    function debtOwedToContract() public view returns (bool) {
        return numDebtsOwedToContract() > 0;
    }

    // Initiates the withdrawal process for the next debt
    function claimNextDebt() public {
        debtTracker.claimNextDebt();
    }
}
