// SPDX-License-Identifier: MIT
// We use a floating point pragma here so it can be used within other projects that interact with the ZKsync ecosystem without using our exact pragma version.
pragma solidity ^0.8.0;

/// @dev The type id of ZKsync's EIP-712-signed transaction.
uint8 constant EIP_712_TX_TYPE = 0x71;

/// @dev The type id of legacy transactions.
uint8 constant LEGACY_TX_TYPE = 0x0;
/// @dev The type id of legacy transactions.
uint8 constant EIP_2930_TX_TYPE = 0x01;
/// @dev The type id of EIP1559 transactions.
uint8 constant EIP_1559_TX_TYPE = 0x02;
/// @dev The type id of L1 to L2 transactions.
uint8 constant L1_TO_L2_TX_TYPE = 0xFF;

/// @notice Structure used to represent a ZKsync transaction.
struct Transaction {
    // The type of the transaction.
    uint256 txType;
    // The caller.
    uint256 from;
    // The callee.
    uint256 to;
    // The gasLimit to pass with the transaction.
    // It has the same meaning as Ethereum's gasLimit.
    uint256 gasLimit;
    // The maximum amount of gas the user is willing to pay for a byte of pubdata.
    uint256 gasPerPubdataByteLimit;
    // The maximum fee per gas that the user is willing to pay.
    // It is akin to EIP1559's maxFeePerGas.
    uint256 maxFeePerGas;
    // The maximum priority fee per gas that the user is willing to pay.
    // It is akin to EIP1559's maxPriorityFeePerGas.
    uint256 maxPriorityFeePerGas;
    // The transaction's paymaster. If there is no paymaster, it is equal to 0.
    uint256 paymaster;
    // The nonce of the transaction.
    uint256 nonce;
    // The value to pass with the transaction.
    uint256 value;
    // In the future, we might want to add some
    // new fields to the struct. The `txData` struct
    // is to be passed to account and any changes to its structure
    // would mean a breaking change to these accounts. In order to prevent this,
    // we should keep some fields as "reserved".
    // It is also recommended that their length is fixed, since
    // it would allow easier proof integration (in case we will need
    // some special circuit for preprocessing transactions).
    uint256[4] reserved;
    // The transaction's calldata.
    bytes data;
    // The signature of the transaction.
    bytes signature;
    // The properly formatted hashes of bytecodes that must be published on L1
    // with the inclusion of this transaction. Note, that a bytecode has been published
    // before, the user won't pay fees for its republishing.
    bytes32[] factoryDeps;
    // The input to the paymaster.
    bytes paymasterInput;
    // Reserved dynamic type for the future use-case. Using it should be avoided,
    // But it is still here, just in case we want to enable some additional functionality.
    bytes reservedDynamic;
}
