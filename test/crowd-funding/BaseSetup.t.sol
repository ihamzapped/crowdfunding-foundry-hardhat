// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

// import {console} from "forge-std/console.sol";
import {stdStorage, StdStorage, Test, console, StdAssertions} from "forge-std/Test.sol";
import {CrowdFunding} from "../../contracts/CrowdFunding.sol";

import {Utils} from "../Utils.sol";

contract BaseSetup is Test {
    Utils internal utils;
    CrowdFunding internal crowdFunding;

    address payable[] internal users;
    address internal owner;
    address internal dev;

    function setUp() public virtual {
        utils = new Utils();
        users = utils.createUsers(4);
        owner = users[0];
        dev = users[1];

        vm.prank(owner);
        crowdFunding = new CrowdFunding(1000, block.timestamp, 100);
    }

    function test_setup() public {
        assertEq(crowdFunding.goal(), 1000);
        assertEq(crowdFunding.deadline(), 1);
        assertEq(crowdFunding.minContribution(), 100);
    }
}
