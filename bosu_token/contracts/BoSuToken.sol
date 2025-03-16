// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BoSuToken is ERC20, ERC20Burnable, Ownable {
    uint256 public constant MAX_SUPPLY = 1_000_000_000 * 10**18; // Maximum supply: 1 Billion BOSU
    bool public mintingDisabled = false; // Minting disable flag

    constructor() ERC20("Bo Su", "BOSU") Ownable(msg.sender) {
        _mint(msg.sender, 1_000_000_000 * 10**18); // Initial supply: 1 Billion BOSU
    }

    /**
     * @dev Allows the owner to mint new tokens, as long as minting is not disabled
     * and the total supply does not exceed MAX_SUPPLY.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        require(!mintingDisabled, "Minting has been disabled");
        require(totalSupply() + amount <= MAX_SUPPLY, "Exceeds max supply");
        _mint(to, amount);
    }

    /**
     * @dev Permanently disables the minting function.
     * This function can only be executed once and cannot be reversed.
     */
    function disableMinting() external onlyOwner {
        mintingDisabled = true;
    }

    /**
     * @dev Renounces ownership, making the contract fully decentralized.
     * Once executed, no one will have control over the contract.
     */
    function renounceOwnership() public override onlyOwner {
        _transferOwnership(address(0));
    }
}
