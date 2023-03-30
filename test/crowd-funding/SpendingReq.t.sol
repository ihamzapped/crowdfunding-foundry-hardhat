// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

import {BaseSetup} from "./BaseSetup.t.sol";
import {Test, console, StdAssertions, StdCheats} from "forge-std/Test.sol";

contract SpendingReq is Test, BaseSetup {
    function test_owner() public {
        startHoax(dev);
        vm.expectRevert();
        crowdFunding.createSpendingReq(
            1 ether,
            payable(owner),
            "I'm going to revert"
        );
    }

    function test_createReq() public {
        uint _amount = 10 ether;
        string memory _description = "I'm going to revert";
        address payable _recipient = payable(dev);

        hoax(owner);
        crowdFunding.createSpendingReq(_amount, _recipient, _description);

        (
            uint amount,
            bool completed,
            uint noOfVoters,
            string memory description,
            address payable recipient
        ) = crowdFunding.requests(0);

        assertFalse(completed);
        assertEq(noOfVoters, 0);
        assertEq(amount, _amount);
        assertEq(recipient, _recipient);
        assertEq(description, _description);
        assertEq(crowdFunding.countRequests(), 1);
    }
}
