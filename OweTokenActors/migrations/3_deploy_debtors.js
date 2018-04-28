var Debtor0 = artifacts.require("./Debtor0.sol");
var Debtor1 = artifacts.require("./Debtor1.sol");
var Debtor2 = artifacts.require("./Debtor2.sol");
var Debtor3 = artifacts.require("./Debtor3.sol");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Debtor0, {from: accounts[9], value: 1000000000000000000});
  deployer.deploy(Debtor1, {from: accounts[9], value: 1000000000000000000});
  deployer.deploy(Debtor2, {from: accounts[9], value: 1000000000000000000});
  deployer.deploy(Debtor3, {from: accounts[9], value: 1000000000000000000});
};
