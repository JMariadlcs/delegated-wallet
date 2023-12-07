# <h1 align="center"> Delegated ERC721 wallet </h1>

## Execution example
The objective of this chapter is to demonstrate the functionality of the designed protocol on a deployed blockchain (Mumbai).

Here are the wallet addresses utilized:

- Cold Wallet (containing the ERC721 token and delegating it to the Hot Wallet): `0xe371cDd686341baDbE337D21c53fA51Db505e361`.
- Hot Wallet (does not contain any tokens and can claim the airdrop only if the cold wallet delegates the ERC721 to it): `0x3768a0c3d522125f828a3E9F5cA225E4F63fFDb8`.

Execution steps:
1. The Cold Wallet mints the ERC721 token with ID 0 from the MockERC721 contract previously deployed. [See tx](https://mumbai.polygonscan.com/tx/0x80ece190a62439e6831a14753b7f49e888efca93b72f78bc1d20e3a785aa024b)
2. Subsequently, the Cold Wallet delegates the ERC721 token to the Hot Wallet, thereby enabling the Hot Wallet to act on behalf of the Cold Wallet. This delegation of the ERC721 token involves the execution of a transaction by the Cold Wallet, calling the ERC721Delegation function within the `DelegationIndexer.sol` contract. [See tx](https://mumbai.polygonscan.com/tx/0x128f5b0b0c3a719154dcc7e9e91e256cdc2f2afab812646b9576cbc2f29b8af6)
3. Following the delegation, the Hot Wallet gains the capability to act on behalf of the Cold Wallet and claim the airdrop. [See tx](https://mumbai.polygonscan.com/tx/0xe130dac5c9b86eae4df864ce255a95fed13b0cd7a3a5ee77e1fc74686c3a931f)

## Contract addresses
All the contracts have been deployed to Mumbai network (polygon testnet):

- MockERC721.sol: `0x77d4F25Cebf15472a7d0f68c8448C04DD095e44C` [MumbaiScan](https://mumbai.polygonscan.com/address/0x77d4F25Cebf15472a7d0f68c8448C04DD095e44C).
- DelegationIndexer.sol: `0x3D1733E1927aaAcA3711f8e3428767F4a2B71A6f` [MumbaiScan](https://mumbai.polygonscan.com/address/0x3D1733E1927aaAcA3711f8e3428767F4a2B71A6f).
- AirdropApp.sol: `0x2302A8D72e2A98cE8e730d15C6c3582F8b318C0a` [MumbaiScan](https://mumbai.polygonscan.com/address/0x2302A8D72e2A98cE8e730d15C6c3582F8b318C0a).