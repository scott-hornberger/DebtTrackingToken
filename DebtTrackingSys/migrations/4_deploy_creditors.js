var Creditor0 = artifacts.require("./examples/Creditor0.sol");
var Creditor1 = artifacts.require("./examples/Creditor1.sol");

module.exports = function(deployer) {
  deployer.deploy(Creditor0);
  deployer.deploy(Creditor1);
};
