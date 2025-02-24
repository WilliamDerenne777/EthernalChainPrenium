const Web3 = require('web3');
const EthernalChain = require('../build/contracts/EthernalChain.json');
require('dotenv').config();

const web3 = new Web3(new Web3.providers.HttpProvider(process.env.BLOCKCHAIN_URL));
const contractAddress = 'DÉPLOYÉ_ADRESSE_CONTRAT'; // Remplacez par l'adresse du contrat déployé
const contract = new web3.eth.Contract(EthernalChain.abi, contractAddress);

// Exemple de fonctionnalité pour ajouter un enregistrement
async function setRecord(record) {
    const accounts = await web3.eth.getAccounts();
    await contract.methods.setRecord(record).send({ from: accounts[0] });
}

// Exemple de fonctionnalité pour obtenir tous les enregistrements
async function getRecords() {
    const records = await contract.methods.getRecords().call();
    return records;
}

module.exports = { setRecord, getRecords };