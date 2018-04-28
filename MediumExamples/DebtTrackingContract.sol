contract DebtTrackingToken is ERC721Token {
    // ...
    mapping(uint => Debt) public debts;

    struct Debt {
        address creditor;
        address debtor;
        uint amount;
    }

    function announceDebt(address _payee, uint _amount) public {
        uint debtId = getDebtId(_payee, msg.sender);
        if (!exists(debtId)) {
            super._mint(_payee, debtId);
        }
        debts[debtId] = Debt(_payee, msg.sender, _amount);
    }

    function clearDebt(address _payee) public {
        uint debtId = getDebtId(_payee, msg.sender);
        super._burn(_payee, debtId);
        delete debts[debtId];
        // event
    }

    function claimNextDebt() public {
        claimNextDebt(msg.sender);
    }

    function claimNextDebt(address _payee) public {
        require(balanceOf(_payee) > 0);
        uint debtId = tokenOfOwnerByIndex(_payee, 0);
        address debtorAddr = debts[debtId].debtor;
        Payer debtor = Payer(debtorAddr);
        debtor.withdrawFor(_payee);
    }

    function getDebtId(address _payee, address _debtor) private pure returns (uint) {
        return uint(sha256(_payee, _debtor));
    }
    // ...
}
