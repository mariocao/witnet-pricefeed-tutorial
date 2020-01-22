pragma solidity ^0.5.0;

/*
 * @title Price / numeric Pull Oracle Interface
*/

interface BytesOracle {
  function bytesResultFor(bytes32 id) external view returns (uint timestamp, bytes32 outcome, uint status);
}
