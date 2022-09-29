//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/** @author zfla */
/** @title Derivative Pricer */
contract DerivativesPricer {

    /** @dev      Calculates the forward price of a physical commodity
      * @param _c  Price of the commodity
      * @param _t  Time to maturity of the contract
      * @param _r  Interest rate 
      * @param _s  Annual storage costs per commodity unit
      * @param _i  Annual insurance costs per commodity unit
      * @return p Calculated forward price of the commodity
      */
    function getCommodityPrice(
        uint256 _c, 
        uint256 _t, 
        uint256 _r,
        uint256 _s,
        uint256 _i
        ) 
        external returns (uint256) {
            uint256 p = _c * (1 + _r * _t) + (_s * _t) + (_i * _t);
            return p;
        }

    
    /** @dev        Calculates the forward price of a stock
      * @param _s    Price of the stock
      * @param _t    Time to maturity of the contract
      * @param _r    Interest rate
      * @param _d    Dividend payment per quarter
      * @param _t_n Time until the next dividend payment
      * @param _f_r Forward rate
      * @return p   Calculated forward price of the stock
      */
    function getStockPrice(
        uint256 _s,
        uint256 _t,
        uint256 _r,
        uint256 _d,
        uint256 _t_n,
        uint256 _f_r
        )
        external returns (uint256) {
            uint256 p = _s * (1 + _r * _t) - getQuarterlyDividend(_t, _t_n, _d, _f_r);
            return p;
        }

    /** @dev         Calculates the _total dividend for the above function
      * @param _t    Time to maturity of the contract
      * @param _t_n  Time until the next dividend payment
      * @param _d    Dividend payment per quarter
      * @param _f_r  Forward rate
      * @return tot The total dividend payment
      */
    function getQuarterlyDividend(
        uint256 _t,
        uint256 _t_n,
        uint256 _d,
        uint256 _f_r
    ) external returns (uint256) {
        uint256[] times = [];
        uint256 counter = _t;
        if (_t_n <= _t) {
            counter -= _t_n;
            times.push(counter);
        } else {
            return 0;
        }

        while (true) {
            counter -= 3;
            if (counter > 0) {
                times.push(counter);
            } else {
                break;
            }
        }
        uint256 tot = 0;
        for (uint i=0; i < counter.length; i++) {
            tot += _d * (1 + times[i]/12 * _f_r);
        }

        return tot;
    }


    /** @dev        Calculates the forward price of a bond
      * @param _b   Price of the bond
      * @param _t   Time to maturity of the contract
      * @param _r   Interest rate
      * @param _c   Coupon payment per quarter
      * @param _t_n Time until the next dividend payment
      * @param _f_r Forward rate
      * @return p   Calculated forward price of the bond
      */
    function getBondPrice(
        uint256 _b,
        uint256 _t,
        uint256 _r,
        uint256 _c,
        uint256 _t_n,
        uint256 _f_r
        )
        external returns (uint256) {
            uint256 p = _b * (1 + _r * _t) - getQuarterlyCouponPayment(_t, _t_n, _c, _f_r);
            return p;
        }

    /** @dev         Calculates the _total coupon payment for the above function
      * @param _t    Time to maturity of the contract
      * @param _t_n  Time until the next coupon payment
      * @param _c    Coupon payment per quarter
      * @param _f_r  Forward rate
      * @return tot  The total coupon payment
      */
    function getQuarterlyCouponPayment(
        uint256 _t,
        uint256 _t_n,
        uint256 _c,
        uint256 _f_r
    ) external returns (uint256) {
        uint256[] times = [];
        uint256 counter = _t;
        if (_t_n <= _t) {
            counter -= _t_n;
            times.push(counter);
        } else {
            return 0;
        }

        while (true) {
            counter -= 3;
            if (counter > 0) {
                times.push(counter);
            } else {
                break;
            }
        }
        uint256 tot = 0;
        for (uint i=0; i < counter.length; i++) {
            tot += _c * (1 + times[i]/12 * _f_r);
        }

        return tot;
    }
    
    /** @dev        Calculates the call price of an option
      * @param _e_p Exercise price
      * @param _t   Time to expiration
      * @param _n   CDF of the normal distribution
      * @param _s_t Spot price of the asset
      * @param _k   Strike price
      * @return c   Call option price 
      */
    function blackScholes(
        uint256 _e_p,
        uint256 _t,
        uint256 _n,
        uint256 _s_t,
        uint256 _k
    ) external returns (uint256) {
        return 0;        
    }

    /** @dev        Calculates the daily volatility for an option
     *  @param _vol Annualised volatility
     */
    function getDailyVolatility(uint256 _vol) external returns (uint256) {
        return 1/(365**(1/2)) * _vol;
    }

    /** @dev        Calculates the weekly volatility for an option
     *  @param _vol Annualised volatility
     */
    function getWeeklyVolatility(uint256 _vol) external returns (uint256) {
        return 1/(52**(1/2)) * _vol;
    }
}