from brownie import Lottery, accounts, config, network
from scripts.deploy_lottery import deploy_lottery
from web3 import Web3


def test_get_entrace_fee():
    # Arrange
    lottery = deploy_lottery()
    # Act
    # 2,000 eth / usd
    # usdEntryFee is 50
    # 2000/1 == 50/x == 0.025
    expected_entrace_fee = Web3.toWei(0.025, 'ether')
    entrance_fee = lottery.getEntranceFee()
    # Assert
    assert expected_entrace_fee == entrance_fee
    
    
    

    #assert lottery.getEntraceFee() > Web3.toWei(0.018, 'ether')
    #assert lottery.getEntraceFee() < Web3.toWei(0.022, 'ether')