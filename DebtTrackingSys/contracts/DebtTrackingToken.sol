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

    // Public Methods
    function announceDebt(address _creditor, uint _amount) public {
        uint debtId = getDebtId(_creditor, msg.sender);
        if (!exists(debtId)) {
            super._mint(_creditor, debtId);
        }
        debts[debtId] = Debt(_creditor, msg.sender, _amount);
    }

    function clearDebt(address _creditor)
        public
        onlyDebtor(getDebtId(_creditor, msg.sender))
    {
        uint debtId = getDebtId(_creditor, msg.sender);
        super._burn(_creditor, debtId);
        delete debts[debtId];
        // event
    }

    function claimNextDebt() public {
        claimNextDebt(msg.sender);
    }

    function claimNextDebt(address _creditor) public {
        require(balanceOf(_creditor) > 0);
        uint debtId = tokenOfOwnerByIndex(_creditor, 0);
        address debtorAddr = debts[debtId].debtor;
        PayerInterface debtor = PayerInterface(debtorAddr);
        debtor.withdraw(_creditor);
    }

    // Private Methods
    function getDebtId(address _creditor, address _debtor) private pure returns (uint) {
        return uint(sha256(_creditor, _debtor));
    }

    // Unsupported Functionality
    // These functions all revert. We don't want allow this functionality
    function safeTransferFrom(address, address, uint256) public  { revert(); }
    function safeTransferFrom(address, address, uint256, bytes) public { revert(); }
    function approve(address, uint256) public  { revert(); }
    function getApproved(uint256) public view returns (address)  { revert(); }
    function setApprovalForAll(address, bool) public  { revert(); }
    function isApprovedForAll(address, address) public view returns (bool)  { revert(); }
    function transferFrom(address, address, uint256) public  { revert(); }
}
