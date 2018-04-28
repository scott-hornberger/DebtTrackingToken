pragma solidity ^0.4.17;

import './OweToken.sol';

contract OweTokenCreditor {
    OweToken private oweToken = OweToken(
        0xAF42E86Cc52fC1CeCed626621CAf63f24175EE10
    );

    function numDebtsOwedToContract() public view returns (uint) {
        return oweToken.balanceOf(this);
    }

    function debtOwedToContract() public view returns (bool) {
        return numDebtsOwedToContract() > 0;
    }

    function claimNextDebt() public {
        oweToken.claimNextDebt();
    }
}
