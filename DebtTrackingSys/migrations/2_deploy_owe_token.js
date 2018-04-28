var DebtTrackingToken = artifacts.require("./DebtTrackingToken.sol");

module.exports = function(deployer) {
  deployer.deploy(DebtTrackingToken);
};
