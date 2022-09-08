//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract DerivativesPricer {
    
    function getCommodityPrice(
        uint256 c, 
        uint256 t, 
        uint256 r,
        uint256 s,
        uint256 i) 
        external view returns (uint256) {
            uint256 p = c * (1 + r * t) + (s * t) + (i * t);
            return p;
        }

}