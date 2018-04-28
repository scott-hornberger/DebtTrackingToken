var OweToken = artifacts.require("./OweToken.sol");

module.exports = function(deployer) {
  deployer.deploy(OweToken);
};
