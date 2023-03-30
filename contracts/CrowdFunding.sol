// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import {ICrowdFunding} from "../interfaces/ICrowdFunding.sol";

contract CrowdFunding is ICrowdFunding {
    address public owner;

    uint public goal;
    uint public raised;
    uint public deadline;
    uint public countRequests;
    uint public minContribution;
    uint public noOfContributors;

    mapping(uint => Request) public requests;
    mapping(address => uint) public contributors;

    constructor(uint256 _goal, uint256 _deadline, uint256 _minContribution) {
        goal = _goal;
        owner = msg.sender;
        deadline = _deadline;
        minContribution = _minContribution;
    }

    receive() external payable {
        contribute();
    }

    function contribute() public payable {
        require(deadline >= block.timestamp, "!time");
        require(msg.value >= minContribution, "!amount");

        if (contributors[msg.sender] == 0) noOfContributors++;

        raised += msg.value;
        contributors[msg.sender] += msg.value;
    }

    function refund() public {
        require(contributors[msg.sender] > 0, "!contributor");
        require(block.timestamp > deadline && raised < goal, "!req");

        uint _amount = contributors[msg.sender];
        contributors[msg.sender] = 0;
        payable(msg.sender).transfer(_amount);
    }

    function createSpendingReq(
        uint _amount,
        address payable _recipient,
        string memory _description
    ) external Owner {
        Request storage req = requests[countRequests];
        countRequests++;

        req.amount = _amount;
        req.recipient = _recipient;
        req.description = _description;
    }

    function voteSpendingReq(uint _reqIndex) external {
        require(_reqIndex < countRequests, "!index");
        require(contributors[msg.sender] > 0, "!contributor");

        Request storage req = requests[_reqIndex];

        require(!req.voters[msg.sender], "hasVoted");

        req.voters[msg.sender] = true;
        req.noOfVoters++;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    modifier Owner() {
        require(msg.sender == owner, "!owner");
        _;
    }
}
