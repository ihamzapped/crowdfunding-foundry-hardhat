// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

import {BaseSetup} from "./BaseSetup.t.sol";
import {Test, console, StdAssertions, StdCheats} from "forge-std/Test.sol";

contract VoteReq is Test, BaseSetup {
    uint amount = 10 ether;
    string description = "Lorem Ipsum";
    address payable recipient = payable(dev);

    function test_vote() public {
        hoax(owner);
        crowdFunding.createSpendingReq(amount, recipient, description);

        startHoax(dev);
        crowdFunding.contribute{value: 100}();
        crowdFunding.voteSpendingReq(0);

        changePrank(users[2]);
        crowdFunding.contribute{value: 100}();
        crowdFunding.voteSpendingReq(0);

        changePrank(users[3]);
        crowdFunding.contribute{value: 100}();
        crowdFunding.voteSpendingReq(0);

        (, , uint _noOfVoters, , ) = crowdFunding.requests(0);

        assertEq(_noOfVoters, 3);
    }

    function test_doubleVote() public {
        hoax(owner);
        crowdFunding.createSpendingReq(amount, recipient, description);

        startHoax(dev);
        crowdFunding.contribute{value: 100}();
        crowdFunding.voteSpendingReq(0);

        vm.expectRevert();
        crowdFunding.voteSpendingReq(0);
    }

    function test_isContributor() public {
        hoax(owner);
        crowdFunding.createSpendingReq(amount, recipient, description);

        hoax(dev);
        vm.expectRevert();
        crowdFunding.voteSpendingReq(0);
    }

    function test_noRequest() public {
        startHoax(owner);

        crowdFunding.contribute{value: 100}();

        vm.expectRevert();
        crowdFunding.voteSpendingReq(0);
    }
}
