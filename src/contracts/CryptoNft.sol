// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract CryptoNft is ERC721Connector {
   
    string[] public cryptoNftInfo;
    mapping(string => bool) _cryptoNftExists;

    constructor() ERC721Connector("CryptoNft", "CNFT") {
    
    }

    function mint(string memory _nft) public {
        require(!_cryptoNftExists[_nft], "Error ! This nft already existed");
        cryptoNftInfo.push(_nft);
        uint _id = cryptoNftInfo.length - 1;
        _mint(msg.sender, _id);
        _cryptoNftExists[_nft] = true;
    }
}