// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "./ERC721NonTransferable.sol";

contract SoulBoundToken is ERC721NonTransferable, Ownable {
    constructor(string memory name_, string memory symbol_)
        ERC721(name_, symbol_)
    {}

    function safeMint(address to, uint256 tokenId) external onlyOwner {
        _safeMint(to, tokenId);
    }

    function burn(uint256 tokenId) external onlyOwner {
        _burn(tokenId);
    }
}
