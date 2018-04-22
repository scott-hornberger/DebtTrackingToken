var Creditor = artifacts.require("./Creditor.sol");

module.exports = function(deployer) {
  deployer.deploy(Creditor);
};
