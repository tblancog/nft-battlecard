// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol';
import '@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol';

contract Token is ERC20Capped, ERC20Burnable {
  address payable public owner;
  uint256 public blockReward;

  constructor(uint256 cap, uint256 reward) ERC20('OpticPower', 'OPTC') ERC20Capped(cap * (10 ** decimals())) {
    owner = msg.sender;
    _mint(owner, 1000000 * (10 ** decimals()));
    blockReward = reward * (10 ** decimals());
  }

  function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override(ERC20, ERC20Capped) {
    super._beforeTokenTransfer(from, to, amount);
  }
  
  function setBlockreward(uint256 reward) public onlyOwner {
    blockReward = reward * (10 ** decimals());
  }

  modifier onlyOwner() {
    require(msg.sender == owner, 'only owner');
    _;
  }
}
