// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

/**
 * @title CrowdFunding Interface
 * @dev Interface for a crowdfunding contract that allows contributors to donate ether, create spending requests, vote on spending requests, and spend the donated funds.
 */

/**
 * @dev Struct representing a spending request.
 * @param amount The amount of ether being requested.
 * @param completed A boolean indicating whether or not the request has been completed.
 * @param noOfVoters The total number of contributors who have voted on the spending request.
 * @param description A description of the spending request.
 * @param recipient The address of the recipient of the ether.
 * @param voters A mapping of addresses of contributors who have voted on the spending request to booleans indicating whether or not they have voted.
 */
struct Request {
    uint amount;
    bool completed;
    uint noOfVoters;
    string description;
    address payable recipient;
    mapping(address => bool) voters;
}

interface ICrowdFunding {
    /**
     * @dev Contribute to the crowdfunding contract by sending ether.
     */
    function contribute() external payable;

    /**
     * @dev Refund the contributed ether to the contributor in case the funding goal is not met.
     */
    function refund() external;

    /**
     * @dev Create a new spending request.
     * @param _amount The amount of ether to be spent.
     * @param _recipient The address of the recipient of the ether.
     * @param _description A description of the spending request.
     */
    function createSpendingReq(
        uint _amount,
        address payable _recipient,
        string memory _description
    ) external;

    /**
     * @dev Vote on a spending request.
     * @param _reqIndex The index of the spending request to vote on.
     */
    function voteSpendingReq(uint _reqIndex) external;

    /**
     * @dev Spend the funds allocated to a spending request.
     * @param _reqIndex The index of the spending request to spend funds on.
     */
    function spendReq(uint _reqIndex) external;

    /**
     * @dev Get the balance of the crowdfunding contract.
     * @return The balance of the crowdfunding contract.
     */
    function getBalance() external view returns (uint);

    /**
     * @dev Event emitted when a contributor donates ether to the crowdfunding contract.
     * @param _sender The address of the contributor.
     * @param _amount The amount of ether donated.
     * @param _raised The total amount of ether raised so far.
     * @param _noOfContributors The total number of contributors who have donated.
     */
    event Contribute(
        address _sender,
        uint _amount,
        uint _raised,
        uint _noOfContributors
    );

    /**
     * @dev Event emitted when a new spending request is created.
     * @param _index The index of the new spending request.
     * @param _amount The amount of ether to be spent.
     * @param _recipient The address of the recipient of the ether.
     * @param _description A description of the spending request.
     */
    event NewRequest(
        uint _index,
        uint _amount,
        address _recipient,
        string _description
    );

    /**
     * @dev Event emitted when a spending request is fulfilled.
     * @param _index The index of the spending request.
     * @param _completed Whether the spending request was successfully completed.
     * @param _amount The amount of ether spent.
     * @param _recipient The address of the recipient of the ether.
     * @param _description A description of the spending request.
     */
    event SpentRequest(
        uint _index,
        bool _completed,
        uint _amount,
        address _recipient,
        string _description
    );

    /**
     * @dev Event emitted when a contributor votes on a spending request.
     * @param _index The index of the spending request being voted on.
     * @param _voter The address of the voter.
     * @param _amount The amount of ether being voted with.
     * @param _recipient The address of the recipient of the ether.
     * @param _description A description of the spending request.
     * @param _noOfVoters The total number of contributors who have voted on the spending request.
     */
    event Voted(
        uint _index,
        address _voter,
        uint _amount,
        address _recipient,
        string _description,
        uint _noOfVoters
    );
}
