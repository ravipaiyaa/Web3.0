// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery{
    string public message;
    //variable to store manager address
    address public manager;
    //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

    //we are storing address of the participants
    address[] public participants;
     
    constructor () public{
        manager=msg.sender;

    }
    function enterlottery() public payable{
        require(msg.value>0.01 ether);
        participants.push(msg.sender);
    }
    function pickwinner() public {

        require(msg.sender==manager);

        uint index = random()%participants.length;
        
        payable(participants[index]).transfer(address(this).balance);

        participants= new address[](0);
    }

    function random() private view returns(uint256){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp, participants)));
    }
}