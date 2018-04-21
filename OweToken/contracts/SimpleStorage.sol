pragma solidity ^0.4.18;

import '../node_modules/zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol';

contract SimpleStorage {
  uint storedData;

  function set(uint x) public {
    storedData = x;
  }

  function get() public view returns (uint) {
    return storedData;
  }
}
