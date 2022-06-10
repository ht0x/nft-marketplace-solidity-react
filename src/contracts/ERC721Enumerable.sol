// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {

    //keep track of all tokens
    uint[] private _allTokens;

    //mapping of a token id to position in all token array
    mapping(uint => uint) private _allTokenIndex;
    
    //mapping of a owner to the list of all owner tokenId 
    mapping(address => uint[]) private _ownerTokens;

    //mapping of token id to token index of owner tokens
    mapping(uint => uint) private _ownerTokensIndex;

    function totalSupply() external view returns (uint256){
        return _allTokens.length;
    }

    function tokenByIndex(uint256 _index) external view returns (uint256){
        require(_index >= 0 && _index < _allTokens.length, "Error! Invalid token index!");
        return _allTokens[_index];
    }

    // function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256){

    // }

    function _mint(address to, uint tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        _addTokenToAllTokenEnumerable(tokenId);
        _addTokenToOwnerTokensEnumerable(tokenId, to);
    }

    function _addTokenToAllTokenEnumerable(uint tokenId) private {
        _allTokenIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokenToOwnerTokensEnumerable(uint tokenId, address to) private {
        _ownerTokensIndex[tokenId] = _ownerTokens[to].length; 
        _ownerTokens[to].push(tokenId);
    }
}