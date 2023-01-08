// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


//idea is that by using address we can easily access the nodes via a mapping, and also use them to link
contract LinkedList {
	
	//can be packed
	//wraps UserData 
	struct UserAccount {
		uint256 data; //dummy data, can store anything
		address next; 
		address prev; 
	}
	
	//maps a uint to a struct 
	mapping(address => UserAccount) public users; 

	address public head; 
	address public tail; 
	

	function addNode(uint256 data) external returns (address) {
		users[msg.sender].data = data; 

		if (head != address(0)) {
			users[msg.sender].prev = tail; 
			users[tail].next = msg.sender; 
			tail = msg.sender; 	
		} else {
			head = msg.sender; 
			tail = msg.sender; 
		}

		return msg.sender; 
	}
	
	//addr1 -> addr2 -> addr3
	//becomes:
	//addr1 -> addr3
	//TODO: does not account for removing head or tail right now, just quick and dirty design before we get too deep
	function removeNode(address id) external returns (address, address) {
		//id = addr2
		//id.prev = addr1
		//id.next = addr3
		
		//newNext = addr3
		//newPrev = addr1
		address newNext = users[id].next; 
		address newPrev = users[id].prev; 
		
		//addr1.next = addr3
		users[newPrev].next = newNext; 
		//addr3.next = addr1
		users[newNext].prev = newPrev; 

		//remove id from list
		users[id].next = address(0); 
		users[id].prev = address(0); 
	}


	function getData(address id) external returns (uint256, address, address) {
		return (users[id].data, users[id].next, users[id].prev); 
	}
	
}
