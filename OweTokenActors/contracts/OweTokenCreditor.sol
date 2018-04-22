pragma solidity ^0.4.17;

import '../../OweToken/contracts/OweToken.sol';

contract OweTokenCreditor {
    OweToken private oweToken = OweToken(
        0xAF42E86Cc52fC1CeCed626621CAf63f24175EE10
    );

    function numDebtsOwedToContract() public view returns (uint) {
        return oweToken.balanceOf(this);
    }

    function claimNextDebt() public {
        uint debtId = oweToken.tokenOfOwnerByIndex(this, 0);
        oweToken.claimEther(debtId);
    }
}
