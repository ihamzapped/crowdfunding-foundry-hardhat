// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract CrowdFundingStorage {
    address public owner;

    uint public goal;
    uint public raised;
    uint public deadline;
    uint public countRequests;
    uint public minContribution;
    uint public noOfContributors;

    mapping(uint => Request) public requests;
    mapping(address => uint) public contributors;

    struct Request {
        uint amount;
        bool completed;
        uint noOfVoters;
        string description;
        address payable recipient;
        mapping(address => bool) voters;
    }
}
