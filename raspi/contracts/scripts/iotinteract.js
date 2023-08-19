const { ethers } = require('hardhat');
const interact = require('./interact'); // Import your interact.js file

const AddStatus = async (location, temp, humidity, heatindex, wid, pid, total_quantity, flag) => {
    try {
        // Fetch data from the IoT simulator using an API call (this is hypothetical)
        const iotData = await fetchIoTData(); // Implement this function based on your IoT simulator's API

        // Destructure the fetched data
        const { temperature, humidity, heatIndex } = iotData;

        // Connect to the deployed smart contract
        const contract = await interact.connectToContract();

        // Call the smart contract function to add the status
        const tx = await contract.AddStatus(location, temperature, humidity, heatIndex, wid, pid, total_quantity, flag);

        // Wait for the transaction to be mined
        await tx.wait();

        
        console.log('Status added successfully.');
    } catch (error) {
        console.error('Error adding status:', error);
    }
};

// Fetch IoT data using a hypothetical API call
const fetchIoTData = async () => {
    // Implement the logic to fetch data from the IoT simulator's API
    // For this example, let's assume you are fetching temperature, humidity, and heat index
    return {
        temperature: 25.5,
        humidity: 60.2,
        heatIndex: 28.7
    };
};

module.exports = {
    AddStatus
};
