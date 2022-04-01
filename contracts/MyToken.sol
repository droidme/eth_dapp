// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    uint256 private _unitsCanBuy  = 10;   // units 1ETH can buy
    address private _minter;              // the owner of the token

    constructor(uint256 initialSupply) ERC20("The Fancy Token you must own", "TFT") {
        _minter = msg.sender;
        _mint(_minter, initialSupply * 10**uint(decimals()));
    }

    function mint(uint256 amount) public {
        require(msg.sender == _minter);
        _mint(_minter, amount);
    }

    // this function is called when someone sends ether to the 
    // token contract
    receive() external payable {        
        // msg.value (in Wei) is the ether sent to the 
        // token contract
        // msg.sender is the account that sends the ether to the 
        // token contract

        // amount is the token bought by the sender
        uint256 amount = msg.value * _unitsCanBuy;

        // ensure you have enough tokens to sell
        require(balanceOf(_minter) >= amount, 
            "Not enough tokens");

        // transfer the token to the buyer
        _transfer(_minter, msg.sender, amount);

        // emit an event to inform of the transfer        
        emit Transfer(_minter, msg.sender, amount);
        
        // send the ether earned to the token owner
        payable(_minter).transfer(msg.value);
    }

}