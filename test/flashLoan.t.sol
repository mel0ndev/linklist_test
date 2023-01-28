// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol"; 
import "../src/Flashloan.sol";
import "../src/aave/ILendingPoolAddressProvider.sol"; 



contract FlashLoan is Test {
	Flashloan public flashLoan; 
	address internal constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48; 

	ILendingPoolAddressesProvider public addressProvider = ILendingPoolAddressesProvider(0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5); 

	address internal user = address(1337); 

	function setUp() public {
		flashLoan = new Flashloan(addressProvider); 	
		
		
		//vm.deal(user, 100e18); 
	}


	function testFlashloan() public {
		address[] memory assets = new address[](1);
		uint256[] memory amounts = new uint256[](1); 
		uint256[] memory modes = new uint256[](1); 

		assets[0] = USDC; 
		amounts[0] = 100e18; 

		flashLoan.flashLoanCall(
			assets, 			
			amounts
		); 
	}

}

