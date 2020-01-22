pragma solidity ^0.5.0;

/*
 * @title Price / numeric Pull Oracle Interface
*/

interface UintOracle {
  function uintResultFor(bytes32 id) external view returns (uint timestamp, uint outcome, uint status);
}
