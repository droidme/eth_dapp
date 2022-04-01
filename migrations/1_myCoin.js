const Coin = artifacts.require("MyCoin");

module.exports = function(deployer) {
  deployer.deploy(Coin);
};

