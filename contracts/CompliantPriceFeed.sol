pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

// Import the UsingWitnet library that enables interacting with Witnet
import "witnet-ethereum-bridge/contracts/UsingWitnet.sol";
// Import the EIP-2362 unsigned integer pull oracle interface
import "./EIP2362/UintOracle.sol";
// Import the Witnet request factory
import "./requests/BitcoinPrice.sol";

/*
* This is a BTC price feed contract that is compliant with EIP-2362.
* It therefore needs to inherit from `UintOracle` and `UsingWitnet`.
*/
contract CompliantPriceFeed is UintOracle, UsingWitnet {
  Request request; // The Witnet request object, is set in the constructor

  constructor (address _wbi) UsingWitnet(_wbi) public {
    request = new BitcoinPriceRequest();
  }

  function requestUpdate() public payable returns (bytes32) {
    // Amount to pay to the bridge node relaying this request from Ethereum to Witnet
    uint256 _witnetRequestReward = 100 szabo;
    // Amount of wei to pay to the bridge node relaying the result from Witnet to Ethereum
    uint256 _witnetResultReward = 100 szabo;

    // Send the request to Witnet
    // The `witnetPostRequest` method comes with `UsingWitnet`
    uint256 id = witnetPostRequest(request, _witnetRequestReward, _witnetResultReward);

    // return the ID for later retrieval of the result
    return bytes32(id);
  }

  function uintResultFor(bytes32 id) external view returns (uint, uint, uint) {
    uint256 witnetRequestId = uint256(id);
    Witnet.Result memory result = witnetReadResult(witnetRequestId);

    // If the Witnet request succeeded, decode the result and update the price point
    // If it failed, revert the transaction with a pretty printed error message
    if (result.isError()) {
      (, string memory errorMessage) = result.asErrorMessage();
      revert(errorMessage);
    }

    return(now, result.asUint64(), 0);
  }
}
