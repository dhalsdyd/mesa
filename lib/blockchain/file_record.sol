// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FileTracking {
    struct FileRecord {
        string ipfsHash;
        address owner;
        uint256 timestamp;
    }

    struct AccessLog {
        address user;
        uint256 timestamp;
        string deviceInfo;
    }

    mapping(string => FileRecord) public files;
    mapping(string => AccessLog[]) public accessLogs;

    event FileUploaded(string ipfsHash, address indexed owner, uint256 timestamp);
    event FileAccessed(string ipfsHash, address indexed user, uint256 timestamp, string deviceInfo);

    // 파일 등록 (IPFS 해시 저장)
    function uploadFile(string memory _ipfsHash) public {
        require(bytes(files[_ipfsHash].ipfsHash).length == 0, "File already exists");

        files[_ipfsHash] = FileRecord({
            ipfsHash: _ipfsHash,
            owner: msg.sender,
            timestamp: block.timestamp
        });

        emit FileUploaded(_ipfsHash, msg.sender, block.timestamp);
    }

    // 파일 접근 기록 저장
    function logFileAccess(string memory _ipfsHash, string memory _deviceInfo) public {
        require(bytes(files[_ipfsHash].ipfsHash).length != 0, "File not found");

        accessLogs[_ipfsHash].push(AccessLog({
            user: msg.sender,
            timestamp: block.timestamp,
            deviceInfo: _deviceInfo
        }));

        emit FileAccessed(_ipfsHash, msg.sender, block.timestamp, _deviceInfo);
    }

    // 파일 접근 로그 조회
    function getAccessLogs(string memory _ipfsHash) public view returns (AccessLog[] memory) {
        return accessLogs[_ipfsHash];
    }
}
