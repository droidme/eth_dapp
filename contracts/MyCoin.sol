// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract MyCoin {

    uint private _initialSupply = 1000;

    address public minter;
    string public name = "Reinis Simple Coin";
    string public symbol = "RSC";

    mapping (address => uint256) private _balance;

    constructor() {
        minter = msg.sender;
        mint(_initialSupply);
    }

    // IERC20 - balanceOf
    function balanceOf(address account) public view returns (uint256) {
        return _balance[account];
    }

    // Minting some coins
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        _balance[receiver] += amount;
    }

    function mint(uint amount) public {
        mint(minter, amount);
    }

    // Errors allow you to provide information about
    // why an operation failed. They are returned
    // to the caller of the function.
    error InsufficientBalance(uint requested, uint available);

    // Events allow clients to react to specific
    // contract changes you declare
    event Sent(address from, address to, uint amount);

    // Sends an amount of existing coins
    // from any caller to an address
    function transfer(address receiver, uint256 amount) external returns (bool) {
        
        if (amount > _balance[msg.sender])
            revert InsufficientBalance({
                requested: amount,
                available: _balance[msg.sender]
            });

        _balance[msg.sender] -= amount;
        _balance[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
        return true;
    }
        
}