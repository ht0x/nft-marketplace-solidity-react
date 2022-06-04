// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {
    /* 
    TODO: 
    1 - Implement mint function 
    2 - Implement balanceOf function
    3 - Implement ownerOf function
    */

    //Keep track of the token ids to token owner addresses
    mapping(uint => address) private _tokenOwner;

    //Keep track of how many token an owner address has
    mapping(address => uint) private _ownedTokensCount;

    //An event to show minting data
    event Transfer(
        address indexed from, 
        address indexed to, 
        uint indexed tokenId);

    function doesNftExist(uint tokenId) internal view returns (bool) {
        return (_tokenOwner[tokenId] != address(0));
    }

    function balanceOf(address _owner) external view returns (uint){
        require(_owner != address(0), "Error! NFTs assigned to zero address are considered invalid.");
        return _ownedTokensCount[_owner];
    }

    function ownerOf(uint _tokenId) external view returns(address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "Error! Token id query for non-existent owner.");
        return owner;
    }

    function _mint(address to, uint tokenId) internal virtual {
        //Require that the address is not 0
        require(to != address(0), "Error! Invalid input address!"); 

        //Require that the token hasn't already been minted
        require(_tokenOwner[tokenId] == address(0), "Error! The token has already been minted."); 

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to]++;

        emit Transfer(address(0), to, tokenId);
    }
}