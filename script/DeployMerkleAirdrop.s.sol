// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {AppleToken} from "../src/AppleToken.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 public constant s_merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 public constant amountToTransfer = 4 * 25 * 1e18; // 4 users, 25 tokens each, 18 decimals

    function deployMerkleAirdrop() public returns (MerkleAirdrop, AppleToken) {
        vm.startBroadcast();
        AppleToken appleToken = new AppleToken();
        MerkleAirdrop merkleAirdrop = new MerkleAirdrop(s_merkleRoot, IERC20(address(appleToken)));
        appleToken.mint(appleToken.owner(), amountToTransfer);
        appleToken.transfer(address(merkleAirdrop), amountToTransfer);
        vm.stopBroadcast();
        return (merkleAirdrop, appleToken);
    }

    function run() external returns (MerkleAirdrop, AppleToken) {
        return deployMerkleAirdrop();
    }
}
