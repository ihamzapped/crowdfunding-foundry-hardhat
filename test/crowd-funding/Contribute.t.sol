// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

// import {console} from "forge-std/console.sol";
import {Test, console} from "forge-std/Test.sol";
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
}
