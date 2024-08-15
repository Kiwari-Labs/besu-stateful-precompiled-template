pragma solidity >=0.5.0 <0.8.0;

import "@statefulprecompiled/auth/IAuth.sol";

// precompiel INterface == external public
// BinarySearch
// LinkedList
// UTXO

contract Authentication {

    IAuth private Target;

    constructor () {
        // Target = IAuth(address((bytes20(keccak256(abi.encodePacked("SERVICE:AUTHENTICATION")))));
        Target = IUniswapV2(address((bytes20(keccak256(abi.encodePacked("SERVICE:DEX:USDT/WETH")))));
    }

    // function register(address account) public {
    //     // Strong types <-> saft
    //     (bool status) = Target.register(account);  // can't not evm trace.
    //     require(status,"Register fail"); 
    //     // ... some action

    //     // line 32 revert.
    //     Target.finalized(status); // => emit event to kafka. fa;se no submit. // no opcodes
    // }

}

