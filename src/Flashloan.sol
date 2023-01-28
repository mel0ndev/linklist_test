// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import {FlashLoanReceiverBase} from "./aave/FlashLoanReceiverBase.sol"; 
import {ILendingPoolAddressesProvider} from "./aave/ILendingPoolAddressProvider.sol"; 
import {IERC20} from "forge-std/interfaces/IERC20.sol"; 


contract Flashloan is FlashLoanReceiverBase {
	
	
	constructor(ILendingPoolAddressesProvider _addressProvider) FlashLoanReceiverBase(_addressProvider) {}		
	
	

	//checkUpkeep --> performUpkeep --> flashloanCall --> executeOperation
	function executeOperation(
  	  address[] calldata assets,
  	  uint[] calldata amounts,
  	  uint[] calldata premiums,
  	  address initiator,
  	  bytes calldata params
  	) external override returns (bool) {

	//custom logic goes here
	//check if borrowed asset is already the one we need	
	 
	for (uint i = 0; i < assets.length; i++) {
		uint amountOwing = amounts[i] + premiums[i];
		IERC20(assets[i]).approve(address(LENDING_POOL), amountOwing);
	}


	return true; 
  }

  function flashLoanCall(address[] memory assets, uint256[] memory amounts) public {
	uint256[] memory modes = new uint256[](1); 
	modes[0] = 0; 
	bytes memory params = ""; 

	LENDING_POOL.flashLoan(
		address(this), //receiver
		assets,
		amounts, 
		modes,	
		address(this), //onBehalfOf
		params, 
		0
	); 
  }

}
