// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC777/ERC777.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract Real is ERC777, AccessControl, Pausable {
    // Access Control Roles
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    constructor(uint256 initialSupply, address[] memory defaultOperators) ERC777("Real", "REAL", defaultOperators)
    {
        // Grant All Access Control Roles to Contract Deployer
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);

        // Mint initial batch of 1 million REAL to owner
        _mint(msg.sender, initialSupply, "", "");
    }

    // Token Minting
    function mint(address account, uint256 amount)
        public
        onlyRole(MINTER_ROLE)
    {
        _mint(account, amount, "", "");
    }

    // Pausing/Unpausing All Transfers
    function pause()
        public
        onlyRole(PAUSER_ROLE)
    {
        _pause();
    }

    function unpause()
        public
        onlyRole(PAUSER_ROLE)
    {
        _unpause();
    }

    // Override default _beforeTokenTransfer hook to only allow when not paused
    function _beforeTokenTransfer(address operator, address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(operator, from, to, amount);
    }
}