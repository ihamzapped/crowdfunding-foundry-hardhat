// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

import {BaseSetup} from "./BaseSetup.t.sol";
import {Test, console, StdAssertions, StdCheats} from "forge-std/Test.sol";

contract SpendReq is Test, BaseSetup {
    uint amount = 10 ether;
    string description = "hehe i'm description";
    address payable recipient = payable(dev);

    function localSetup() private {
        hoax(dev);
        crowdFunding.contribute{value: 100}();
        hoax(users[2]);
        crowdFunding.contribute{value: 100}();
        hoax(users[3]);
        crowdFunding.contribute{value: 100}();
        hoax(users[4]);
        crowdFunding.contribute{value: 100}();

        hoax(owner);
        crowdFunding.createSpendingReq(amount, recipient, description);

        hoax(dev);
        crowdFunding.voteSpendingReq(0);
        hoax(users[2]);
        crowdFunding.voteSpendingReq(0);
        hoax(users[3]);
        crowdFunding.voteSpendingReq(0);
    }

    function test_spendReq() public {
        localSetup();

        // fulfill goal
        hoax(dev);
        crowdFunding.contribute{value: 10 ether}();

        (uint _amount, , , , address payable _recipient) = crowdFunding
            .requests(0);

        uint rBal = address(_recipient).balance;
        uint cBal = address(crowdFunding).balance;

        hoax(owner);
        crowdFunding.spendReq(0);

        uint rBalAfter = address(_recipient).balance;
        uint cBalAfter = address(crowdFunding).balance;

        (, bool _completed, , , ) = crowdFunding.requests(0);

        assert(_completed);
        assertEq(rBalAfter, rBal + _amount);
        assertEq(cBalAfter, cBal - _amount);
    }

    function test_notGoal() public {
        localSetup();

        // cannot mutate anymore because marked goal as immutable
        // // Set goal to 1,000 ether
        // // vm.store(
        // //     address(crowdFunding),
        // //     bytes32(uint(1)),
        // //     bytes32(uint(1000 ether))
        // // );

        startHoax(owner);
        vm.expectRevert();
        crowdFunding.spendReq(0);
    }

    function test_noVotes() public {
        localSetup();

        // Contribute more to outvote setup voters

        hoax(users[5]);
        crowdFunding.contribute{value: 10 ether}();
        hoax(users[6]);
        crowdFunding.contribute{value: 10 ether}();

        startHoax(owner);
        vm.expectRevert();
        crowdFunding.spendReq(0);
    }

    function test_doubleSpend() public {
        localSetup();

        // fulfill goal
        hoax(dev);
        crowdFunding.contribute{value: 10 ether}();

        startHoax(owner);
        crowdFunding.spendReq(0);

        vm.expectRevert();
        crowdFunding.spendReq(0);
    }

    function test_revertOwner() public {
        localSetup();

        // fulfill goal
        hoax(dev);
        crowdFunding.contribute{value: 10 ether}();

        startHoax(dev);
        vm.expectRevert();
        crowdFunding.spendReq(0);
    }
}
