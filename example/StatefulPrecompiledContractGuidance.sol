// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Example Simple Storage with Stateful Precompiled Contract.
/// @author https://github.com/MASDXI

interface ISimpleStorageStateful {
    function get() external view returns (uint256);
    function set(uint256) external;
}

contract StatefulTest {
    // Common implementation not recommended.
    // reserve address is a unique address that is not meaningful and hard to remember.
    // address public statefulPrecompiled = <STATEFUL_PRECOMPILE_ADDRESS>;
    
    // Preferred implementation recommended.
    // purpose reserve address is generated from the hash of services:<name>.
    // @dev declaration address type.
    // address public simpleStorageAddress = address((bytes20(keccak256("simplestorage"))));
    // @dev declaration interface type.
    // ISimpleStorageStateful public ISimpleStorage = ISimpleStorageStateful(address(bytes20(keccak256("simplestorage"))));

    // [SUGGESTION] reserve address determind guidance.
    // name space for stateful pre-compiled contract.
    // pattern: 
    //   <CATAGORY_TYPES>:<PRE_COMPIED_CONTRACT_NAME>
    //   <CATAGORY_TYPES>:<PRE_COMPIED_CONTRACT_NAME>:<VERSION> or <TYPE> optional.
    //
    // example:
    //   FINANCIAL:CORE_BANKING
    //   FINANCIAL:CORE_BANKING:V2
    //   FINANCIAL:SETTELMENT:GRIDLOCK
    //   FINANCIAL:SETTELMENT:NETTING
    //   UTILITY:HASH:CRC-32
    //   UTILITY:PRNG
    //   UTILITY:PRNG:OP-TEE
    //   DID:W3C:V1
    //   IP:1234 (IP:Improvement Proposal)

    // @dev constructor declaration.
    // constructor (string memory statefulPrecompiledName_) {
    //     simpleStorageAddress = 
    //         address((bytes20(keccak256(abi.encodePacked(statefulPrecompiledName_)))));
    //     ISimpleStorage = 
    //         ISimpleStorageStateful(address(bytes20(keccak256((abi.encodePacked(statefulPrecompiledName_))))));
    // }

    ISimpleStorageStateful public statefulPrecompiled;
    address public statefulPrecompiledAddress;

    event StorageUpdated(uint256 value);

    constructor(address precomplied) {
        statefulPrecompiled = ISimpleStorageStateful(precomplied);
        statefulPrecompiledAddress = precomplied;
    }

    /// @dev helper function convert bytes into uint256
    function _convertBytesToUint256(bytes memory input) private pure returns (uint256 response) {
        uint256 lenght = input.length;
        for(uint256 i = 0; i < lenght; i++){
            response = response + uint(uint8(input[i])) * (2**(8*(lenght-(i+1))));
        }
    }

    function testSet(uint256 value) public {
        statefulPrecompiled.set(value);
    }

    function testGet() public view returns (uint256) {
        return statefulPrecompiled.get();
    }

    /// @dev encode the setter function signature manaully.
    function testSetWithEncodeCall(uint256 value) public {
        (bool status, bytes memory response) = statefulPrecompiledAddress.call(
            abi.encodeWithSignature("set(uint256)",value));
        require(status,"ERROR:SET");

        emit StorageUpdated(_convertBytesToUint256(response));
    }

    /// @dev encode the getter function signature manaully.
    function testGetWithEncodeCall() public view returns (uint256) {
        (bool status, bytes memory response) = statefulPrecompiledAddress.staticcall(
            abi.encodeWithSignature("get()"));
        require(status,"ERROR:GET");

        return _convertBytesToUint256(response);
    }
}