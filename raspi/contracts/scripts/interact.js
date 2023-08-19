const Web3 = require('web3');
const contractAbi = require('./YourContractAbi.json'); // Load your contract ABI

const web3 = new Web3(new Web3.providers.HttpProvider('https://polygon-mumbai.g.alchemy.com/v2/<your_key>'));

const contractAddress = '<your_contract_address>';
const contract = new web3.eth.Contract(contractAbi, contractAddress);

async function addStatus() {
    const accounts = await web3.eth.getAccounts();
    const sender = accounts[0];

    // Replace the following values with actual data
    const location = 'Some Location';
    const temp = '65'; // Example temperature
    const humidity = '50'; // Example humidity
    const heatindex = '70'; // Example heat index
    const wid = 1; // Worker ID
    const pid = 1; // Product ID
    const total_quantity = 100;
    const flag = true;

    try {
        const result = await contract.methods.AddStatus(location, temp, humidity, heatindex, wid, pid, total_quantity, flag).send({ from: sender });
        console.log('Status added:', result);
    } catch (error) {
        console.error('Error:', error);
    }
}

addStatus();
