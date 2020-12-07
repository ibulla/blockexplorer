// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.5.0;

contract SzaboMachine {
    
    uint256 unlockBlock;
    uint256 freeBlocks;
    
    function () external payable {
        uint256 currBlock = block.number;
        uint256 freeBlocks = msg.value / 1000000000000000;
        if(unlockBlock > currBlock){
            unlockBlock = unlockBlock + freeBlocks;
        }else{
            unlockBlock = currBlock + freeBlocks;
        }
    }
    
    function getFreeBlocks() public view returns (uint256){
        return freeBlocks;
    }    
    
    function getUnlockBlock() public view returns (uint256){
        return unlockBlock;
    }
}
