// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol"; 
import "../src/LinkedList.sol";

contract LinkedListTest is Test {
    LinkedList public linkedList;
	address user1 = address(1000); 
	address user2 = address(2000); 
	address user3 = address(3000); 
	address user4 = address(4000); 
	address user5 = address(5000); 
	address user6 = address(6000); 
	address user7 = address(7000); 
	address user8 = address(8000); 
	address user9 = address(9000); 

	address head; 
	address tail; 


    function setUp() public {
		linkedList = new LinkedList(); 
    }

    function testAddNode() public {
		vm.prank(user1); 
			address user = linkedList.addNode(17); 
		console.log(user); 
		(uint256 data, address next, address prev) = linkedList.getData(user1); 



		console.log("data:", data); 
		console.log("next node:", next); 
		console.log("prev node:", prev); 

		head = linkedList.head(); 	
		tail = linkedList.tail(); 
		console.log("head:", head); 
		console.log("tail", tail); 
	}

	//i know this is ugly -- is just for quick test
	function testAddMultiNode() public {
		vm.prank(user1); 	
			linkedList.addNode(17); 

		vm.prank(user2); 
			linkedList.addNode(23); 

		vm.prank(user3); 
			linkedList.addNode(75); 

		vm.prank(user4); 
			linkedList.addNode(33); 
			
		vm.prank(user5); 
			linkedList.addNode(99); 
		
		head = linkedList.head(); 	
		tail = linkedList.tail(); 


		address current = head; 
		while (current != address(0)) {
			(uint256 data, address next, address prev) = linkedList.getData(current); 
			console.log("data:", data); 
			console.log("next node:", next); 
			console.log("prev node:", prev); 
			current = next; 
		}
	}

	function testRemove() public {
		vm.prank(user1); 	
			linkedList.addNode(17); 

		vm.prank(user2); 
			linkedList.addNode(23); 

		vm.prank(user3); 
			linkedList.addNode(75); 

		head = linkedList.head(); 
		tail = linkedList.tail(); 

		
		console.log("user1", user1); 
		console.log("user2", user2); 
		console.log("user3", user3); 

		(uint256 data1, address next1, address prev1) = linkedList.getData(user1); 
		(uint256 data2, address next2, address prev2) = linkedList.getData(user3); 

		//before removal
		
		console.log("user1 link"); 
		console.log("data:", data1); 
		console.log("next node:", next1); 
		console.log("prev node:", prev1); 
		
		console.log("user3 link"); 
		console.log("data:", data2); 
		console.log("next node:", next2); 
		console.log("prev node:", prev2); 
		
		//remove user2
		linkedList.removeNode(user2); 
		//check that user1 is now linked to user3 in next, and user3 is linked to user1 in prev
		(uint256 data3, address next3, address prev3) = linkedList.getData(user1); 
		(uint256 data4, address next4, address prev4) = linkedList.getData(user3); 


		console.log("user1 link"); 
		console.log("data:", data3); 
		console.log("next node:", next3); 
		console.log("prev node:", prev3); 

		console.log("user3 link"); 
		console.log("data:", data4); 
		console.log("next node:", next4); 
		console.log("prev node:", prev4); 
	}
}
