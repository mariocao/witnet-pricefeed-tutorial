pragma solidity ^0.5.0;

/*
 * @title Price / numeric Pull Oracle Interface
*/

interface IntOracle {
  function intResultFor(bytes32 id) external view returns (uint timestamp, int outcome, int status);
}
