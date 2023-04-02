// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

import {BaseSetup} from "./BaseSetup.t.sol";
import {Test, console, StdAssertions, StdCheats} from "forge-std/Test.sol";

contract SpendingReq is Test, BaseSetup {
    uint amount = 10 ether;
    string description = "hehe i'm description";
    address payable recipient = payable(dev);

    function test_owner() public {
        startHoax(dev);
        vm.expectRevert();
        crowdFunding.createSpendingReq(amount, payable(owner), description);
    }

    function test_createReq() public {
        hoax(owner);
        crowdFunding.createSpendingReq(amount, recipient, description);

        (
            uint _amount,
            bool _completed,
            uint _noOfVoters,
            string memory _description,
            address payable _recipient
        ) = crowdFunding.requests(0);

        assertFalse(_completed);
        assertEq(_noOfVoters, 0);
        assertEq(amount, _amount);
        assertEq(recipient, _recipient);
        assertEq(description, _description);
        assertEq(crowdFunding.countRequests(), 1);
    }
}
