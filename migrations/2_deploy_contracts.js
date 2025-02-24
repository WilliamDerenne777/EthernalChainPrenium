const EthernalChain = artifacts.require("EthernalChain");

module.exports = function(deployer) {
  deployer.deploy(EthernalChain, "0x1234"); // Vous pouvez remplacer "0x1234" par l'identifiant que vous souhaitez
};