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

    constructor() {
        owner = msg.sender;
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
