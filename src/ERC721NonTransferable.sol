// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

/**
 * @dev ERC721 token with token transfers disabled.
 *
 * A non-fungible token bounded to an address.
 */
abstract contract ERC721NonTransferable is ERC721 {
    /**
     * @dev See {ERC721-_transfer}.
     *
     * Reverts on token transfer
     */
    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        revert("ERC721NonTransferable: transfer disabled");
    }
}
