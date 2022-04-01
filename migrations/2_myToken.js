const Token = artifacts.require("MyToken");
const initial_supply = 1000;

module.exports = function(deployer) {
  deployer.deploy(Token, initial_supply);
};