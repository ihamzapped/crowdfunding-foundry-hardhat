// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import {Request} from "./Interface.sol";

contract CrowdFundingStorage {
    uint public immutable goal;
    uint public immutable deadline;
    address public immutable owner;
    uint public immutable minContribution;

    uint public raised;
    uint public countRequests;
    uint public noOfContributors;

    mapping(uint => Request) public requests;
    mapping(address => uint) public contributors;

    constructor(uint256 _goal, uint256 _deadline, uint256 _minContribution) {
        goal = _goal;
        owner = msg.sender;
        deadline = _deadline;
        minContribution = _minContribution;
    }
}
