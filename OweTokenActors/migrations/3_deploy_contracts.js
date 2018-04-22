var Debtor = artifacts.require("./Debtor.sol");

module.exports = function(deployer) {
  deployer.deploy(Debtor);
};
