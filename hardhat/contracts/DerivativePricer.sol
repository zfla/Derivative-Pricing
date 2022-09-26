//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/** @author zfla */
/** @title Derivative Pricer */
contract DerivativesPricer {

    /** @dev      Calculates the forward price of a physical commodity
      * @param c  Price of the commodity
      * @param t  Time to maturity of the contract
      * @param r  Interest rate 
      * @param s  Annual storage costs per commodity unit
      * @param i  Annual insurance costs per commodity unit
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

    
    /** @dev       Calculates the forward price of a stock
      * @param s   Price of the stock
      * @param t   Time to maturity of the contract
      * @param r   Interest rate
      * @param d   Dividend payment per quarter
      * @param t_n Time until the next dividend payment
      * @param f_r Forward rate
      * @return p  Calculated forward price of the stock
      */
    function getStockPrice(
        uint256 s,
        uint256 t,
        uint256 r,
        uint256 d,
        uint256 t_n,
        uint256 f_r
        )
        external returns (uint256) {
            p = s * (1 + r * t) - getQuarterlyDividend(t, t_n, d, f_r);
            return p;
        }

    /** @dev        Calculates the total dividend for the above function
      * @param t    Time to maturity of the contract
      * @param t_n  Time until the next dividend payment
      * @param d    Dividend payment per quarter
      * @param f_r  Forward rate
      * @return tot The total dividend payment
      */
    function getQuarterlyDividend(
        uint256 t,
        uint256 t_n,
        uint256 d,
        uint256 f_r
    ) external returns (uint256) {
        uint256[] times = []
        uint256 counter = t;
        if t_n <= t {
            counter -= t_n;
            times.push(counter);
        } else {
            return 0;
        }

        while true {
            counter -= 3;
            if counter > 0 {
                times.push(counter);
            } else {
                break
            }
        }
        uint256 tot = 0;
        for (uint i=0; i < counter.length; i++) {
            tot += d * (1 + times[i]/12 * f_r);
        }

        return tot;
    }


    /** @dev       Calculates the forward price of a bond
      * @param s   Price of the bond
      * @param t   Time to maturity of the contract
      * @param r   Interest rate
      * @param d   Dividend payment per quarter
      * @param t_n Time until the next dividend payment
      * @param f_r Forward rate
      * @return p  Calculated forward price of the bond
      */
    function getBondPrice(
        uint256 b,
        uint256 t,
        uint256 r,
        uint256 c,
        uint256 t_n,
        uint256 f_r
        )
        external returns (uint256) {
            p = s * (1 + r * t) - getQuarterlyDividend(t, t_n, d, f_r);
            return p;
        }

    /** @dev        Calculates the total coupon payment for the above function
      * @param t    Time to maturity of the contract
      * @param t_n  Time until the next coupon payment
      * @param d    Coupon payment per quarter
      * @param f_r  Forward rate
      * @return tot The total coupon payment
      */
    function getQuarterlyCouponPayment(
        uint256 t,
        uint256 t_n,
        uint256 c,
        uint256 f_r
    ) external returns (uint256) {
        uint256[] times = []
        uint256 counter = t;
        if t_n <= t {
            counter -= t_n;
            times.push(counter);
        } else {
            return 0;
        }

        while true {
            counter -= 3;
            if counter > 0 {
                times.push(counter);
            } else {
                break
            }
        }
        uint256 tot = 0;
        for (uint i=0; i < counter.length; i++) {
            tot += c * (1 + times[i]/12 * f_r);
        }

        return tot;
    }
    
    function blackScholes(
        uint256 e_p,
        uint256 t,
        uint256 c_p,
        uint256 i,
        uint256 v
    ) external returns (uint256) {
        return 0;        
    }

    function blackScholes() {}
}