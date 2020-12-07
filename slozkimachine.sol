// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.5.0;

contract SzaboMachine {
    
    uint256 unlockBlock;
    uint256 currBlocks = block.number;
    uint256 freeBlocks = msg.value / 1000000000000000;
    
    function () external payable {
        if(unlockBlock > currBlocks){
            unlockBlock = unlockBlock + freeBlocks;
        }else{
            unlockBlock = currBlocks + freeBlocks;
        }
    }
    
    function getCurrBlocks() public view returns (uint256){
        return currBlocks;
    }  
    
    function getFreeBlocks() public view returns (uint256){
        return freeBlocks;
    }    
    
    function getUnlockBlock() public view returns (uint256){
        return unlockBlock;
    }
}
