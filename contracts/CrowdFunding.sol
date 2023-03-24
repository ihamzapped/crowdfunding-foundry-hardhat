// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract CrowdFunding {
    address public owner;

    uint256 public goal;
    uint256 public raised;
    uint256 public deadline;
    uint256 public minContribution;
    uint256 public noOfContributors;

    mapping(address => uint256) public contributors;

    constructor(uint256 _goal, uint256 _deadline, uint256 _minContribution) {
        goal = _goal;
        owner = msg.sender;
        deadline = _deadline;
        minContribution = _minContribution;
    }

    function contribute() public payable {
        require(deadline >= block.timestamp, "!time");
        require(msg.value >= minContribution, "!amount");

        if (contributors[msg.sender] == 0) noOfContributors++;

        raised += msg.value;
        contributors[msg.sender] += msg.value;
    }

    receive() external payable {
        contribute();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
