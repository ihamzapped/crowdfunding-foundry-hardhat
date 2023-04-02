// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import {ICrowdFunding} from "./Interface.sol";

contract CrowdFundingStorage is ICrowdFunding {
    address public owner;

    uint public goal;
    uint public raised;
    uint public deadline;
    uint public countRequests;
    uint public minContribution;
    uint public noOfContributors;

    mapping(uint => Request) public requests;
    mapping(address => uint) public contributors;
}
