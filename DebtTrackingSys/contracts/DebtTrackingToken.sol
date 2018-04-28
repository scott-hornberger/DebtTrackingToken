pragma solidity ^0.4.17;

import './PayerInterface.sol';
import '../node_modules/zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol';

contract DebtTrackingToken is ERC721Token {
    string private NAME = "Owe Token";
    string private SYMBOL = "OWE";
    mapping(uint => Debt) public debts;

    struct Debt {
        address creditor;
        address debtor;
        uint amount;
    }

    modifier onlyCreditor(uint debtId) {
        require(debts[debtId].creditor == msg.sender);
        _;
    }

    modifier onlyDebtor(uint debtId) {
        require(debts[debtId].debtor == msg.sender);
        _;
    }

    // Contstructor
    function DebtTrackingToken() public payable ERC721Token(NAME, SYMBOL) { }

    /* PUBLIC METHODS */
    // Creates or updates a debt. Makes new token if one does not exist for this
    // debtId. If the debt exists, then only the amount is updated.
    // Important note: there will only ever be one debtId and one token for a
    // debt where msg.sender owes _payee. IF the debt is cleared later, then a
    // token can be made again.
    function announceDebt(address _payee, uint _amount) public {
        uint debtId = getDebtId(_payee, msg.sender);
        if (!exists(debtId)) {
            super._mint(_payee, debtId);
        }
        debts[debtId] = Debt(_payee, msg.sender, _amount);
        // event
    }

    // Deletes the token related to the debt between msg.sender and _payee
    function clearDebt(address _payee)
        public
        onlyDebtor(getDebtId(_payee, msg.sender))
    {
        uint debtId = getDebtId(_payee, msg.sender);
        super._burn(_payee, debtId);
        delete debts[debtId];
        // event
    }

    // Initialize the withdrawal process for msg.sender
    function claimNextDebt() public {
        claimNextDebt(msg.sender);
    }

    // Initialize the withdrawal process for _payee
    function claimNextDebt(address _payee) public {
        require(balanceOf(_payee) > 0);
        uint debtId = tokenOfOwnerByIndex(_payee, 0);
        address debtorAddr = debts[debtId].debtor;
        PayerInterface debtor = PayerInterface(debtorAddr);
        debtor.withdraw(_payee);
    }

    /* Private Methods */
    // Create a unique debtId for a debt between _payer and _payee
    function getDebtId(address _payee, address _payer) private pure returns (uint) {
        return uint(sha256(_payee, _payer));
    }

    /* UNSUPPORTED FUNCTIONALITY */
    // These methods all revert. We don't want allow this functionality
    // Reverting on these function is allowed per ERC-721 standard.
    function safeTransferFrom(address, address, uint256) public  { revert(); }
    function safeTransferFrom(address, address, uint256, bytes) public { revert(); }
    function approve(address, uint256) public  { revert(); }
    function getApproved(uint256) public view returns (address)  { revert(); }
    function setApprovalForAll(address, bool) public  { revert(); }
    function isApprovedForAll(address, address) public view returns (bool)  { revert(); }
    function transferFrom(address, address, uint256) public  { revert(); }
}
