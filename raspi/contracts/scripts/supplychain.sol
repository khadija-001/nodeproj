// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

contract Supplychain {
    address owner;
import "@openzeppelin/contracts/access/AccessControl.sol";

contract Supplychain is AccessControl {
    bytes32 public constant PRODUCER_ROLE = keccak256("PRODUCER_ROLE");
    bytes32 public constant DISTRIBUTOR_ROLE = keccak256("DISTRIBUTOR_ROLE");
    bytes32 public constant RETAILER_ROLE = keccak256("RETAILER_ROLE");

    constructor() {
        owner = msg.sender;
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
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
    require(isValidTemperature(temp), "Temperature is not within the valid range");
    require(hasAccessToStatus(msg.sender), "Sender does not have access to update status");

    Status memory statusInfo = Status(location, block.timestamp, temp, humidity, heatindex, wid, pid, total_quantity, flag);
    product_Status[pid].push(statusInfo);
}

function hasAccessToStatus(address sender) internal view returns (bool) {
    // Implement your access control logic here
    // For example, check if the sender has the Distributor role
    return distributorRole.hasRole(sender, DISTRIBUTOR_ROLE);
}

function isValidTemperature(string memory temp) internal pure returns (bool) {
    int256 temperature = parseInt(temp);
    int256 tempFahrenheit = (temperature * 9 / 5) + 32; // Convert to Fahrenheit

    return (tempFahrenheit >= 40 && tempFahrenheit <= 70);
}

function parseInt(string memory _a) internal pure returns (int256) {
    bytes memory bresult = bytes(_a);
    int256 mint = 0;
    bool decimals = false;
    for (uint256 i = 0; i < bresult.length; i++) {
        if ((uint8(bresult[i]) >= 48) && (uint8(bresult[i]) <= 57)) {
            if (decimals) {
                if (uint8(bresult[i]) == 46) {
                    revert(); // More than one decimal point in number
                }
                if (mint >= 0) {
                    mint *= 10;
                    mint += int256(uint8(bresult[i])) - 48;
                } else {
                    mint *= 10;
                    mint -= int256(uint8(bresult[i])) - 48;
                }
            } else {
                mint *= 10;
                mint += int256(uint8(bresult[i])) - 48;
            }
        } else if (uint8(bresult[i]) == 46) decimals = true;
        else revert(); // Invalid character in input
    }
    if (!decimals) mint *= 10**18;
    return mint;
}
 }

    function getProductStatus(uint256 id) public view returns (Status[] memory) {
        return product_Status[id];
    }
}
