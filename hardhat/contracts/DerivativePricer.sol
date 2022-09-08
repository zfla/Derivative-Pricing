//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

/** @author zfla */
/** @title Derivative Pricer */
contract DerivativesPricer {

    /** @dev Calculates the forward price of a physical commodity
      * @param c Price of the commodity
      * @param t Time to maturity of the contract
      * @param r Interest rate 
      * @param s Annual storage costs per commodity unit
      * @param i Annual insurance costs per commodity unit
      * @return p The calculated forward price of the commodity
      */
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