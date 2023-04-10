// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

interface ICrowdFunding {
    function contribute() external payable;

    function refund() external;

    function voteSpendingReq(uint _reqIndex) external;

    function getBalance() external view returns (uint);

    /// @notice Only Owner
    function spendReq(uint _reqIndex) external;

    /// @notice Only Owner
    function createSpendingReq(
        uint _amount,
        address payable _recipient,
        string memory _description
    ) external;

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
