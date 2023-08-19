// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract AccessControlList {
    // Struct to store the data attributes with different access levels
    struct DataAttributes {
        string location;  // Full access for Producer and Distributor, Limited access for Retailer
        uint256 temperature;  // Full access for all except Customer (Limited access)
        uint256 humidity;     // Full access for all except Customer (Limited access)
        uint256 weight;       // Full access for all except Customer (Limited access)
        string smartBagsRFID; // Full access for Producer, Distributor, and Retailer, No access for Customer
    }

    // Mapping to store the data attributes for each address
    mapping(address => DataAttributes) private data;

    // Modifier to check if the sender has appropriate access
    modifier hasAccess(address sender) {
        require(
            sender == owner() || sender == distributor || sender == retailer,
            "Access denied."
        );
        _;
    }

    // Address variables for stakeholders
    address public owner; // Producer's address (Full access)
    address public distributor; // Distributor's address (Full access)
    address public retailer; // Retailer's address (Full access)
    address public customer; // Customer's address (No access)

    constructor() {
        owner = msg.sender;
        distributor = address(0);
        retailer = address(0);
        customer = address(0);
    }

    // Function to set the Distributor's address
    function setDistributor(address _distributor) external onlyOwner {
        distributor = _distributor;
    }

    // Function to set the Retailer's address
    function setRetailer(address _retailer) external onlyOwner {
        retailer = _retailer;
    }

    // Function to set the Customer's address (Optional: You may not need this if customers are not interacting with the contract)
    function setCustomer(address _customer) external onlyOwner {
        customer = _customer;
    }

    // Function to store location data (Full access for Producer and Distributor, Limited access for Retailer)
    function storeLocationData(string memory _location) external hasAccess(msg.sender) {
        data[msg.sender].location = _location;
    }

    // Function to store temperature data (Full access for all except Customer (Limited access))
    function storeTemperatureData(uint256 _temperature) external hasAccess(msg.sender) {
        data[msg.sender].temperature = _temperature;
    }

    // Function to store humidity data (Full access for all except Customer (Limited access))
    function storeHumidityData(uint256 _humidity) external hasAccess(msg.sender) {
        data[msg.sender].humidity = _humidity;
    }

    // Function to store weight data (Full access for all except Customer (Limited access))
    function storeWeightData(uint256 _weight) external hasAccess(msg.sender) {
        data[msg.sender].weight = _weight;
    }

    // Function to store smartBagsRFID data (Full access for Producer, Distributor, and Retailer, No access for Customer)
    function storeSmartBagsRFID(string memory _rfid) external hasAccess(msg.sender) {
        data[msg.sender].smartBagsRFID = _rfid;
    }

    // Function to fetch the location data for the sender
    function getLocationData() external view returns (string memory) {
        return data[msg.sender].location;
    }

    // Function to fetch the temperature data for the sender
    function getTemperatureData() external view returns (uint256) {
        return data[msg.sender].temperature;
    }

    // Function to fetch the humidity data for the sender
    function getHumidityData() external view returns (uint256) {
        return data[msg.sender].humidity;
    }

    // Function to fetch the weight data for the sender
    function getWeightData() external view returns (uint256) {
        return data[msg.sender].weight;
    }

    // Function to fetch the smartBagsRFID data for the sender
    function getSmartBagsRFID() external view returns (string memory) {
        return data[msg.sender].smartBagsRFID;
    }
}

