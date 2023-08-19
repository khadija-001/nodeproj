// Interact.sol
pragma solidity ^0.8.0;

contract Interact {
    uint256 public temperature;

    function setTemperature(uint256 _temperature) external {
        temperature = _temperature;
    }

    function checkTemperature() external view returns (string memory) {
        if (temperature < 52) {
            return "Temperature is too low";
        } else if (temperature > 74) {
            return "Temperature is too high";
        } else {
            return "Temperature is within the acceptable range";
        }
    }
}
