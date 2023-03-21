// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

// import {console} from "forge-std/console.sol";
import {stdStorage, StdStorage, Test, console} from "forge-std/Test.sol";
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
        users = utils.createUsers(2);
        owner = users[0];
        vm.label(owner, "Owner");
        dev = users[1];
        vm.label(dev, "Developer");

        crowdFunding = new CrowdFunding(1000, block.timestamp, 100);
    }
}
