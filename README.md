# Besu Stateful Precompiled Template

> 🚧 This repository still under development.

This repository provide you a template to create a stateful pre-compiled contract into [hyperledger besu](https://github.com/hyperledger/besu) client.

## Prerequisite
- [Git]()
- [Java OpenJDK 21]()
- [Docker engine]() `**required if build an docker image`  

## Testing

``` shell
./gradlew test
```

## Building 

``` shell
./gradlew build 
```

## Security Consideration  
- Stateful Pre-compiled excluding from the `EVM` but it's cause the problem directly to the node such as  
  - [Memory leak](https://www.niit.com/india/Java-Memory-Leaks-How-to-Find-and-Fix-Them) you pre-compiled logic consume memory more that Xmx configure of JVM.
  - Database Corrupted and Data Integrity problem can be occurs cause you can directly accessing to storage of each account. this vulnerabilities same as in Smart Contract level [write to arbitrary storage location](https://docs.guardrails.io/docs/vulnerabilities/solidity/write_to_arbitrary_storage_location)
  - Execution time exceeds the maximum configured duration (block period).
  - Calls to external system and `/POST` something to external system database `SHOULD` be avoid due to if the transaction reverted external system can't know that the actual status of transaction was successful or not (reverted).


### TODO List Task
- Create `StatefulPrecompiledContract` class.
- Create extended `StatefulPrecompiledContract` class for supported `Enclave` for secure execution environment.  
- Testing `StatefulPrecompiledContract` class.
- Example implementation form `StatefulPrecompiledContract` class. 
- `./gradlew build` task for building a `hyperledger/besu` with a stateful precompiled contract.
