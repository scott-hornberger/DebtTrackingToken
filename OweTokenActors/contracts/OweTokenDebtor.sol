pragma solidity ^0.4.17;

import '../../OweToken/contracts/OweToken.sol';

contract OweTokenDebtor {
    OweToken oweToken = OweToken(
        0xAF42E86Cc52fC1CeCed626621CAf63f24175EE10
    );

    mapping(address => uint) public balances;

    modifier hasBalance(address _creditor) { require(balances[_creditor] > 0); _; }

    function withdraw() public {
        withdraw(msg.sender);
    }

    function withdraw(address _creditor) hasBalance(_creditor) public {
        uint balance = balances[_creditor];
        balances[_creditor] = 0;
        _creditor.transfer(balance);
        oweToken.clearDebt(_creditor);
    }

    function addToBalance(address _creditor, uint _addBalance) internal {
        balances[_creditor] = safeAdd(balances[_creditor], _addBalance);
        oweToken.announceDebt(_creditor, balances[_creditor]);
    }

    function setBalance(address _creditor, uint _newBalance) internal {
        balances[_creditor] = _newBalance;
        oweToken.announceDebt(_creditor, balances[_creditor]);
    }

    function safeAdd(uint a, uint b) private pure returns (uint) {
        uint c = a + b;
        require(c >= a + b);
        return c;
    }
}
