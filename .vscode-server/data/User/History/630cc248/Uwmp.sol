// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract temp {
    int public temperature;

    function read() public view returns (int) {
        return temperature;
    }

    function set(int _temperature) public {
        temperature = _temperature;
    }
}
