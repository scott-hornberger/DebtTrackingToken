var Debtor0 = artifacts.require("./examples/Debtor0.sol");
var Debtor1 = artifacts.require("./examples/Debtor1.sol");
var Debtor2 = artifacts.require("./examples/Debtor2.sol");
var Debtor3 = artifacts.require("./examples/Debtor3.sol");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Debtor0, {from: accounts[9], value: 1000000000000000000});
  deployer.deploy(Debtor1, {from: accounts[9], value: 1000000000000000000});
  deployer.deploy(Debtor2, {from: accounts[9], value: 1000000000000000000});
  deployer.deploy(Debtor3, {from: accounts[9], value: 1000000000000000000});
};
