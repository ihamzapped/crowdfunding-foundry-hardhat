// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

// import {console} from "forge-std/console.sol";
import {Test, console, StdAssertions, StdCheats} from "forge-std/Test.sol";
import {BaseSetup} from "./BaseSetup.t.sol";
import {CrowdFunding} from "../../contracts/CrowdFunding.sol";

contract Test_Contribute is Test, BaseSetup {
    function test_deadline() public {
        crowdFunding.contribute{value: 100}();

        // skip block time by 1s
        skip(1);

        vm.expectRevert();
        crowdFunding.contribute{value: 100}();
    }

    function test_amount() public {
        crowdFunding.contribute{value: 100}();

        vm.expectRevert();
        crowdFunding.contribute{value: 99}();
    }

    function test_new_contributor() public {
        hoax(dev);
        crowdFunding.contribute{value: 100}();

        assertEq(crowdFunding.noOfContributors(), 1);
        assertEq(crowdFunding.raised(), 100);
        assertEq(crowdFunding.contributors(dev), 100);
    }

    function test_old_contributor() public {
        startHoax(dev);
        crowdFunding.contribute{value: 100}();
        crowdFunding.contribute{value: 100}();

        assertEq(crowdFunding.noOfContributors(), 1);
        assertEq(crowdFunding.raised(), 200);
        assertEq(crowdFunding.contributors(dev), 200);
    }

    function test_multi_contributors() public {
        hoax(dev);
        crowdFunding.contribute{value: 100}();
        hoax(users[2]);
        crowdFunding.contribute{value: 100}();
        hoax(users[3]);
        crowdFunding.contribute{value: 100}();

        assertEq(crowdFunding.noOfContributors(), 3);
        assertEq(crowdFunding.raised(), 300);
        assertEq(crowdFunding.contributors(dev), 100);
        assertEq(crowdFunding.contributors(users[2]), 100);
        assertEq(crowdFunding.contributors(users[3]), 100);
    }
}
