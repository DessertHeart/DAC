// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

import "./ERC20.sol";

contract NBBNBB is ERC20 {
    
    constructor(
        string memory _name,
        string memory _symbol
    )
        public
        ERC20(_name, _symbol)
    {
        _mint(msg.sender, 20000000 * 1e6);
    }

}