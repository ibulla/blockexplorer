// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

/// @title Szabo Machine - a simple blockchain jukebox
/// @notice Sends blocks of time depending on the amount of Ether provided
contract SzaboMachine {
    /// @notice Block number until the machine is unlocked
    uint256 public unlockBlock;

    /// @dev Emitted whenever a user inserts coins (Ether)
    event CoinInserted(address indexed from, uint256 amount, uint256 blocksAdded, uint256 newUnlockBlock);

    /// @notice Insert coins and extend the running time of the machine
    /// @dev Each 1 szabo (1e12 wei) equals 0.001 blocks, i.e. 1000 szabo = 1 block
    /// @return The block number until which the machine will run
    function insertCoin() external payable returns (uint256) {
        require(msg.value >= 1e12, "minimum 1 szabo");
        uint256 blocksToAdd = (msg.value / 1e12) / 1000;
        uint256 start = unlockBlock > block.number ? unlockBlock : block.number;
        unlockBlock = start + blocksToAdd;
        emit CoinInserted(msg.sender, msg.value, blocksToAdd, unlockBlock);
        return unlockBlock;
    }

    /// @notice Get current block number
    function getCurrBlock() external view returns (uint256) {
        return block.number;
    }

    /// @notice Calculate how many blocks a given amount of wei will add
    function freeBlocksForAmount(uint256 amount) external pure returns (uint256) {
        return (amount / 1e12) / 1000;
    }
}
