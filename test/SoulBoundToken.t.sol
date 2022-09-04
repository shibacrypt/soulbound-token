// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SoulBoundToken.sol";

contract SoulBoundTokenTest is Test {
    SoulBoundToken internal token;
    address sender = vm.addr(0xA11CE);
    address receiver = vm.addr(0xB0B);

    function setUp() public {
        token = new SoulBoundToken("SoulBound Token", "SBT");
    }

    function test_Mint() public {
        token.safeMint(sender, 1);
        token.safeMint(receiver, 2);
        assertEq(token.ownerOf(1), sender);
        assertEq(token.ownerOf(2), receiver);
        assertEq(token.balanceOf(sender), 1);
        assertEq(token.balanceOf(receiver), 1);
    }

    function testRevert_Mint() public {
        vm.prank(sender);
        vm.expectRevert("Ownable: caller is not the owner");
        token.safeMint(sender, 1);
    }

    function test_Burn() public {
        token.safeMint(sender, 1);
        token.safeMint(receiver, 2);
        token.burn(1);
        assertEq(token.balanceOf(sender), 0);
        assertEq(token.balanceOf(receiver), 1);
    }

    function testRevert_Burn() public {
        token.safeMint(sender, 1);
        token.burn(1);
        vm.expectRevert("ERC721: invalid token ID");
        token.ownerOf(1);

        vm.prank(sender);
        vm.expectRevert("Ownable: caller is not the owner");
        token.burn(1);
    }

    function test_Transfer() public {
        uint256 tokenId = 1;
        token.safeMint(sender, tokenId);
        assertEq(token.ownerOf(tokenId), sender);

        vm.startPrank(sender);
        vm.expectRevert("ERC721NonTransferable: transfer disabled");
        token.transferFrom(sender, receiver, tokenId);
        vm.expectRevert("ERC721NonTransferable: transfer disabled");
        token.safeTransferFrom(sender, receiver, tokenId);
        vm.expectRevert("ERC721NonTransferable: transfer disabled");
        token.safeTransferFrom(sender, receiver, tokenId, "");
        vm.stopPrank();
    }
}
