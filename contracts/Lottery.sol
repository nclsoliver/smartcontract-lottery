// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract lottery is Ownable {
    address payable[] public players;
    uint256 public usdEntryFee;
    AggregatorV3Interface internal ethUsdPriceFeed;
    enum LOTTERY_STATE {
        OPEN,
        CLOSED,
        CALCULATING_WINNER
    }
    LOTTERY_STATE public lottery_state;


    constructor(address _priceFeedAddress) public {
        usdEntryFee = 50 * (10**18);
        ethUsdPriceFeed = AggregatorV3Interface(_priceFeedAddress);
        lottery_state = LOTTERY_STATE.CLOSED;
    }

    function enter() public payable {
        // $50 minimum
        require(lottery_state == LOTTERY_STATE.OPEN);
        require(msg.value >= getEntraceFee(), "Not enough ETH!");
        players.push(msg.sender);
    }

    function getEntraceFee() public view returns (uint256) {
        (, int256 price, , , ) = ethUsdPriceFeed.latestRoundData();
        uint256 adjustedPrice = uint256(price) * 10**10;
        uint256 costEnter = (usdEntryFee * 10**18) / adjustedPrice;
        return costEnter;
    }

    function startLottery() public onlyOwner {
        require(lottery_state ==LOTTERY_STATE.CLOSED,
        "Can't start a new lottery yet!"
        );
        lottery_state = LOTTERY_STATE.OPEN;
    }


    function endLottery() public {}
}
