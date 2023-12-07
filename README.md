# <h1 align="center"> Delegated ERC721 wallet </h1>

This repository encompasses a 'delegation system protocol'. This implies that the implemented protocol enables wallets to delegate their assets to other wallets, allowing them to act on their behalf without the delegated addresses possessing the assets. In simpler terms, this system operates without necessitating the transfer of assets from the initial addresses.

This system is highly advantageous for claiming airdrops or conducting various acts that demand ownership of a specific asset, all while mitigating risks. A clear example would be a Cold Wallet holding an ERC721 token necessary for claiming a particular airdrop. Rather than directly initiating the airdrop claim with the Cold Wallet, which might pose inherent risks, the Cold Wallet delegates the ERC721 token to the Hot Wallet without transferring ownership. Consequently, the Hot Wallet gains the capability to claim the airdrop on behalf of the Cold Wallet.

Please be aware that this repository specifically showcases the implementation of the delegation mechanism for an ERC721 token. However, it is adaptable and can be easily extended to encompass any quantity of ERC20 tokens, a designated Smart Contract, or even an entire wallet.

## How it works

The protocol has been implemented using three main contracts:

1. [MockERC721](https://github.com/JMariadlcs/delegated-wallet/blob/main/src/MockERC721.sol): This ERC721 token contract serves as the criterion for claiming the airdrop. Only the owner of the ERC721 token with ID 0, or the address delegated by the owner, is eligible to claim the airdrop, and this claim can be made only once.
2. [DelegationIndexer](https://github.com/JMariadlcs/delegated-wallet/blob/main/src/DelegationIndexer.sol): This contract facilitates the delegation of an ERC721 token from one wallet to another.
3. [AirdropApp](https://github.com/JMariadlcs/delegated-wallet/blob/main/src/AirdropApp.sol): This contract serves as the airdropper. It implements the DelegateIndexer interface to verify whether the claimer is the ERC721 owner or a wallet that has been delegated by the owner of the ERC721 token.

## Technical docs

The protocol enables the execution of two types of actions: delegating ERC721 tokens and verifying if an ERC721 token has been delegated.

1. Delegate ERC721: for delegating ERC721 the `ERC721Delegation` function must be called. [Check interface](https://github.com/JMariadlcs/delegated-wallet/blob/main/src/interfaces/IDelegationIndexer.sol#L6-L14)

```bash
    /** 
     * @notice function for delegating an ERC721 token
     * @param to HotWallet address to be delegated
     * @param contractAddress address of the ERC721 delegated
     * @param tokenId Id of the ERC721 token delegated
     * @param activeDelegation trigger for active/revoke delegation
     * @dev function returns the delegation hash generated (bytes32 type)
     */
    function ERC721Delegation(address to, address contractAddress, uint256 tokenId, bool activeDelegation) external returns (bytes32);
```

2. Verify ERC721 delegation: for verifying if a specific ERC721 token has been delegated to a certain address the `checkERC721Delegation` function much be called. [Check interface](https://github.com/JMariadlcs/delegated-wallet/blob/main/src/interfaces/IDelegationIndexer.sol#_16-L24)

```bash
    /** 
     * @notice function for checking if an ERC721 token delegation is active
     * @param from ColdWallet address of the wallet that contains the ERC721 token
     * @param to HotWallet address to be delegated
     * @param contractAddress address of the ERC721 delegated
     * @param tokenId Id of the ERC721 token delegated
     * @dev function returns a boolean indicating if the delegation is active or not
     */
    function checkERC721Delegation(address from, address to, address contractAddress, uint256 tokenId) external view returns(bool);
```

## Execution example
The objective of this chapter is to demonstrate the functionality of the designed protocol on a deployed blockchain (Mumbai).

Here are the wallet addresses utilized:

- Cold Wallet (containing the ERC721 token and delegating it to the Hot Wallet): `0xe371cDd686341baDbE337D21c53fA51Db505e361`.
- Hot Wallet (does not contain any tokens and can claim the airdrop only if the cold wallet delegates the ERC721 to it): `0x3768a0c3d522125f828a3E9F5cA225E4F63fFDb8`.

Execution steps:
1. The Cold Wallet mints the ERC721 token with ID 0 from the MockERC721 contract previously deployed. [See tx](https://mumbai.polygonscan.com/tx/0x80ece190a62439e6831a14753b7f49e888efca93b72f78bc1d20e3a785aa024b)
2. Subsequently, the Cold Wallet delegates the ERC721 token to the Hot Wallet, thereby enabling the Hot Wallet to act on behalf of the Cold Wallet. This delegation of the ERC721 token involves the execution of a transaction by the Cold Wallet, calling the ERC721Delegation function within the `DelegationIndexer.sol` contract. [See tx](https://mumbai.polygonscan.com/tx/0x128f5b0b0c3a719154dcc7e9e91e256cdc2f2afab812646b9576cbc2f29b8af6)
3. Following the delegation, the Hot Wallet gains the capability to act on behalf of the Cold Wallet and claim the airdrop. [See tx](https://mumbai.polygonscan.com/tx/0xe130dac5c9b86eae4df864ce255a95fed13b0cd7a3a5ee77e1fc74686c3a931f)

## Testing
All functions in the protocol have tests implemented. To execute these tests:

```bash
forge test
```

The code has a 100% test coverage, you can check it by executing:

```bash
forge coverage
```

```bash
| src/AirdropApp.sol                   | 100.00% (8/8)  | 100.00% (10/10) | 100.00% (4/4) | 100.00% (1/1) |
| src/DelegationIndexer.sol            | 100.00% (5/5)  | 100.00% (6/6)   | 100.00% (2/2) | 100.00% (2/2) |
| src/MockERC721.sol                   | 100.00% (3/3)  | 100.00% (3/3)   | 100.00% (0/0) | 100.00% (1/1) |
```

## Contract addresses
All contracts have been deployed on the Mumbai network (Polygon testnet). It's important to note that the addresses provided here differ from those used in the 'Execution example'. This distinction is due to the eligibility criteria for the airdrop, which applies exclusively to the ERC721 token with ID 0 and is limited to a single use. Consequently, these newly deployed contracts are intended for a one-time testing of the functionality.

- MockERC721.sol: `0x9Fd12DfDe6eF24fa793C699941363d8E61E4c983` [MumbaiScan](https://mumbai.polygonscan.com/address/0x9Fd12DfDe6eF24fa793C699941363d8E61E4c983).
- DelegationIndexer.sol: `0x03FfF50ef7C829B1aF69dcaAd257bD9426897f41` [MumbaiScan](https://mumbai.polygonscan.com/address/0x03FfF50ef7C829B1aF69dcaAd257bD9426897f41).
- AirdropApp.sol: `0x17e5cc63d3ecfFdf1b82a04687a6f7E3552cDb15` [MumbaiScan](https://mumbai.polygonscan.com/address/0x17e5cc63d3ecfFdf1b82a04687a6f7E3552cDb15).