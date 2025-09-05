// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {AppleToken} from "../src/AppleToken.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {DeployMerkleAirdrop} from "../script/DeployMerkleAirdrop.s.sol";

contract MerkleAirdropTest is Test {
    AppleToken public appleToken;
    MerkleAirdrop public merkleAirdrop;
    bytes32 public ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    address user;
    uint256 userPrivateKey;
    DeployMerkleAirdrop public deployer;

    bytes32[] public PROOF = [
        bytes32(0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a),
        bytes32(0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576)
    ];
    uint256 public AMOUNT_TO_CLAIM = 25 * 1e18;
    uint256 public AMOUNT_TO_SEND = 1000 * 1e18;

    function setUp() public {
        deployer = new DeployMerkleAirdrop();
        (merkleAirdrop, appleToken) = deployer.deployMerkleAirdrop();
        (user, userPrivateKey) = makeAddrAndKey("user");
    }

    function testUserCanClaim() public {
        uint256 startingBalance = appleToken.balanceOf(user);
        vm.startPrank(user);
        merkleAirdrop.claim(user, AMOUNT_TO_CLAIM, PROOF);
        vm.stopPrank();
        uint256 endingBalance = appleToken.balanceOf(user);
        console.log("Ending Balance: ", endingBalance);
        assertEq(endingBalance - startingBalance, AMOUNT_TO_CLAIM);
    }
}
