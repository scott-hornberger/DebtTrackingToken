contract Payee {
    DebtTrackingToken private debtTracker = DebtTrackingToken(
        0xd3t7....
        // address of the DebtTrackingToken on the blockchain
    );

    function numDebtsOwedToContract() public view returns (uint) {
        return debtTracker.balanceOf(this);
    }

    function debtOwedToContract() public view returns (bool) {
        return numDebtsOwedToContract() > 0;
    }

    function claimNextDebt() public {
        debtTracker.claimNextDebt();
    }
}
