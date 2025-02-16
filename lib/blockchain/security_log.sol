// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecurityLog {
    struct Log {
        address user;
        uint256 timestamp;
        string details;
    }

    Log[] public logs;
    
    event SecurityEvent(address indexed user, string details, uint256 timestamp);

    function recordLog(string memory _details) public {
        logs.push(Log(msg.sender, block.timestamp, _details));
        emit SecurityEvent(msg.sender, _details, block.timestamp);
    }

    function getLogs() public view returns (Log[] memory) {
        return logs;
    }
}
