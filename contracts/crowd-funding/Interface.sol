// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

interface ICrowdFunding {
    struct Request {
        uint amount;
        bool completed;
        uint noOfVoters;
        string description;
        address payable recipient;
        mapping(address => bool) voters;
    }
}
