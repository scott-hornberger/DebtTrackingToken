contract PayerInterface {
    // DebtTrackingToken contract on the blockchain
    DebtTrackingToken debtTracker = DebtTrackingToken(
        0xd3b7...
        // address of the DebtTrackingToken
    );

    mapping(address => uint) private balances;

    modifier hasBalance(address _payee) { require(balances[_payee] > 0); _; }

    // Standard withdrawal pattern withdraw
    function withdraw() public {
        withdrawFor(msg.sender);
    }

    // Allows one account to initiate the withdrawal for another account
    function withdrawFor(address _payee) hasBalance(_payee) public {
        uint balance = balances[_payee];
        balances[_payee] = 0;
        _payee.transfer(balance);
        debtTracker.clearDebt(_payee);
    }

    function addToBalance(address _payee, uint _addBalance) internal {
        uint newBalance = safeAdd(balances[_payee], _addBalance);
        setBalance(_payee, newBalance);
    }

    function setBalance(address _payee, uint _newBalance) internal {
        balances[_payee] = _newBalance;
        debtTracker.announceDebt(_payee, balances[_payee]);
    }

    function safeAdd(uint a, uint b) private pure returns (uint) {
        uint c = a + b;
        require(c >= a + b);
        return c;
    }
}
