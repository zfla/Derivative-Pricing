//SPDX-License-Identifier: MIT
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
      * @return p Calculated forward price of the commodity
      */
    function getCommodityPrice(
        uint256 c, 
        uint256 t, 
        uint256 r,
        uint256 s,
        uint256 i
        ) 
        external returns (uint256) {
            uint256 p = c * (1 + r * t) + (s * t) + (i * t);
            return p;
        }

    
    /** @dev Calculates the forward price of a stock
      * @param s Price of the stock
      * @param t Time to maturity of the contract
      * @param r Interest rate
      * @param d Dividends accumulated across the duration of the contract
      * @return p Calculated forward price of the stock
      */
    function getStockPrice(
        uint256 s,
        uint256 t,
        uint256 r,
        uint256 d
        )
        external returns (uint256) {
            p = s * (1 + r * t) - d;
            return p;
        }

}