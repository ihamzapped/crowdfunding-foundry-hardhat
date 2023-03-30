// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

import {BaseSetup} from "./BaseSetup.t.sol";
import {Test, console, StdAssertions, StdCheats} from "forge-std/Test.sol";

contract Refund is Test, BaseSetup {
    function test_refund() public {
        startHoax(dev);

        uint balBefore = dev.balance;

        crowdFunding.contribute{value: 500}();

        skip(2);
        crowdFunding.refund();

        uint balAfter = dev.balance;

        assertEq(balBefore, balAfter);
        assertEq(crowdFunding.contributors(dev), 0);
    }

    function test_goal_reached() public {
        startHoax(dev);
        crowdFunding.contribute{value: 11500}();

        skip(2);
        vm.expectRevert();
        crowdFunding.refund();
    }

    function test_before_deadline() public {
        startHoax(dev);
        crowdFunding.contribute{value: 500}();

        vm.expectRevert();
        crowdFunding.refund();
    }

    function test_not_contributor() public {
        vm.expectRevert();
        crowdFunding.refund();
    }
}
