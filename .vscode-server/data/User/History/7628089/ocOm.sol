// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

contract Supplychain {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    uint256 product_id = 0;

    struct Product {
        uint256 id;
        string name;
        string price;
        string description;
        string reqtemp;
        string manufacturing;
        uint256 timestamp;
    }

    struct Status {
        string location;
        uint256 timestamp;
        string temp;
        string humidity;
        string heatindex;
        uint256 w_id;
        uint256 p_id;
        uint256 total_quantity;
        bool flag;
    }

    enum UserRole { Producer, Distributor, Retailer, Customer }

    mapping(address => UserRole) public userRoles;
    mapping(uint256 => Product) public products;
    mapping(uint256 => Status[]) public product_Status;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    modifier onlyProducer() {
        require(userRoles[msg.sender] == UserRole.Producer, "Only producers can call this function");
        _;
    }

    modifier onlyDistributor() {
        require(userRoles[msg.sender] == UserRole.Distributor, "Only distributors can call this function");
        _;
    }

    modifier onlyRetailer() {
        require(userRoles[msg.sender] == UserRole.Retailer, "Only retailers can call this function");
        _;
    }

    modifier onlyCustomer() {
        require(userRoles[msg.sender] == UserRole.Customer, "Only customers can call this function");
        _;
    }

    function setRole(address user, UserRole role) public onlyOwner {
        userRoles[user] = role;
    }

    function AddProduct(
        string memory name,
        string memory price,
        string memory description,
        string memory reqtemp,
        string memory manufacturing
    ) public onlyProducer {
        product_id++;
        Product memory productInfo = Product(product_id, name, price, description, reqtemp, manufacturing, block.timestamp);
        products[product_id] = productInfo;
    }

    function AddStatus(
        string memory location,
        string memory temp,
        string memory humidity,
        string memory heatindex,
        uint256 wid,
        uint256 pid,
        uint256 total_quantity,
        bool flag
    ) public onlyDistributor {
        Status memory statusInfo = Status(location, block.timestamp, temp, humidity, heatindex, wid, pid, total_quantity, flag);
        product_Status[pid].push(statusInfo);
    }

    function getProductStatus(uint256 id) public view returns (Status[] memory) {
        return product_Status[id];
    }
}
