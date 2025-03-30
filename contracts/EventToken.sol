// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*

Problem:
- i want to track a which employee gives out which ticket and then see who attends the event. reward should be given to the employee wallet
- we have a contract for THE event 
  - it has different tokens assigend to different employee. 
  - One token = One employee
- Employee trade/or mint token to users
- Users, if attent event, employee is rewarded
- event has time, duration, attendence array/or mapping

Date: 29.05.25

*/

/* quick thinking
an employee with subcribe to the event
an employee can share this event with others,
if others show up, employeee is rewarded.
event needs to be an event, with a dattetime, and duration, to see when attenance is taken
*/

contract EventToken {
    address private owner;

    mapping(address => uint256) public employeeTokens;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "mod: Only Authority");
        _;
    }

    function getOwner() public view onlyOwner returns (address) {
        return owner;
    }

    //subscribe, a user to have a token, to invite others to the event
    function sub() public {
        require(
            employeeTokens[msg.sender] == 0,
            "require: Only 1 wallet, 1 token"
        );
        require(msg.sender != owner, "require: Owner cannot subscribe");
        employeeTokens[msg.sender] = 1;
    }

    function subAdd(address _address) internal onlyOwner {
        require(
            employeeTokens[_address] == 0,
            "require: Only 1 wallet, 1 token"
        );
        require(msg.sender != owner, "require: Owner cannot subscribe");
        employeeTokens[_address] = 1;
    }

    function getToken() external view returns (uint256) {
        return employeeTokens[msg.sender];
    }
    function getTokenOf(address _address) external view returns (uint256) {
        return employeeTokens[_address];
    }
}
