// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract CrowdFundingEvents {
    event Contribute(
        address _sender,
        uint _amount,
        uint _raised,
        uint _noOfContributors
    );

    event NewRequest(
        uint _index,
        uint _amount,
        address _recipient,
        string _description
    );

    event SpentRequest(
        uint _index,
        bool _completed,
        uint _amount,
        address _recipient,
        string _description
    );

    event Voted(
        uint _index,
        address _voter,
        uint _amount,
        address _recipient,
        string _description,
        uint _noOfVoters
    );
}
