// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Travel is ERC721 {
    //////////////////////////////////////////////////////////////////////////////////////////////////
    // State
    //////////////////////////////////////////////////////////////////////////////////////////////////

    uint256 constant REF_BOOKING_OFFSET = 192; // 64 Bits
    uint256 constant PRICE_BOOKING_OFFSET = 80; // 112 Bits
    uint256 constant TIMESTAMP_END_OFFSET = 40; // 40 Bits
    uint256 constant TIMESTAMP_START_OFFSET = 0; // 40 Bits

    //////////////////////////////////////////////////////////////////////////////////////////////////
    // Constructor
    //////////////////////////////////////////////////////////////////////////////////////////////////

    constructor() ERC721("TravelToken", "TTK") {}

    //////////////////////////////////////////////////////////////////////////////////////////////////
    // Public functions
    ////////////////////////////////////////////////////////////////////////////////////////////////// 

    // => Set functions

    function safeMintNft(address p_to, uint256 p_ref, uint256 p_price, uint256 p_end, uint256 p_start) public {
        require(
            p_ref <= 18446744073709551615,
            "Error: Reference"
        );

        require(
            p_price <= 5192296858534827628530496329220095,
            "Error: Price"
        );

        require(
            p_end <= 1099511627775 && p_start <= 1099511627775 && p_end > p_start,
            "Error: Times"
        );

        uint256 _ref =  p_ref << REF_BOOKING_OFFSET;
        uint256 _price =  p_price << PRICE_BOOKING_OFFSET;
        uint256 _end =  p_end << TIMESTAMP_END_OFFSET;
        uint256 tokenId = _ref + _price + _end + p_start;

        _safeMint(p_to, tokenId);
    }

    // => View functions

    function getRef(uint256 p_tokenId) public pure returns(uint256) {
        uint256 refMask =  0xFFFFFFFFFFFFFFFF << REF_BOOKING_OFFSET;
        uint256 ref = ((p_tokenId & refMask) >> REF_BOOKING_OFFSET);
        
        return ref;
    }

    function getPrice(uint256 p_tokenId) public pure returns(uint256) {
        uint256 priceMask = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF << PRICE_BOOKING_OFFSET;
        uint256 price = ((p_tokenId & priceMask) >> PRICE_BOOKING_OFFSET);
        
        return price;
    }

    function getEnd(uint256 p_tokenId) public pure returns(uint256) {
        uint256 timeMask =  0xFFFFFFFFFF << TIMESTAMP_END_OFFSET;
        uint256 time = ((p_tokenId & timeMask) >> TIMESTAMP_END_OFFSET);
        
        return time;
    }

    function getStart(uint256 p_tokenId) public pure returns(uint256) {
        uint256 timeMask =  0xFFFFFFFFFF << TIMESTAMP_START_OFFSET;
        uint256 time = ((p_tokenId & timeMask) >> TIMESTAMP_START_OFFSET);
        
        return time;
    }
}