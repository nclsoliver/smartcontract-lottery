from brownie import Lottery, accounts, config, network
from web3 import Web3


def test_get_entrace_fee():
    account = accounts[0]
    lottery = Lottery.deploy(
        config['networks'][network.show_active()]['eth_usd_price_feed'],
        {'from': account},
    )
    
    #assert lottery.getEntraceFee() > Web3.toWei(0.018, 'ether')
    #assert lottery.getEntraceFee() < Web3.toWei(0.022, 'ether')