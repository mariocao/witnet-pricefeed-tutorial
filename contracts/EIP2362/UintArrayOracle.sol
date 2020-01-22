pragma solidity ^0.5.0;

/*
 * @title Price / numeric Pull Oracle Interface
*/

interface UintArrayOracle {
  function uintArrayResultFor(bytes32 id) external view returns (uint timestamp, uint[] memory outcome, uint[] memory status);
}
