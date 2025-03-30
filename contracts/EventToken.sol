// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Problem:
- Track which employee gives out which ticket and see who attends the event. Reward given to employee wallet.
- Contract for THE event with unique tokens assigned to each employee (one token = one employee).
- Employee invites others to the event.
- If invitees attend, employee is rewarded.
- Event has time, duration, and attendance array.

Date: 29.05.25
*/

contract EventToken {
    struct Event {
        uint256 startTime;
        uint256 duration;
        address[] attendees; // Array of attendees
    }

    Event private eventDetails;
    address private owner;
    uint256 private tokenCounter;

    mapping(address => uint256) public employeeTokens;
    mapping(uint256 => address) public tokenToEmployee;
    mapping(address => uint256) public invitedBy;
    mapping(address => uint256) public employeeRewardCount;

    constructor() {
        owner = msg.sender;
        tokenCounter = 1;
        // eventDetails.startTime = _startTime; // e.g., 1743379200 for May 29, 2025
        // eventDetails.duration = _duration; // e.g., 3600 for 1 hour
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner allowed");
        _;
    }

    // Subscribe to the event
    // get a token, invite others, and get rewards
    function sub() public {
        require(employeeTokens[msg.sender] == 0, "Already subscribed");
        require(msg.sender != owner, "Owner cannot subscribe");
        employeeTokens[msg.sender] = tokenCounter;
        tokenToEmployee[tokenCounter] = msg.sender;
        tokenCounter += 1;
    }

    function invite(address _invitee) public {
        require(employeeTokens[msg.sender] > 0, "Must be subscribed to invite");
        require(_invitee != msg.sender, "Cannot invite yourself");
        require(invitedBy[_invitee] == 0, "Invitee already invited");
        invitedBy[_invitee] = employeeTokens[msg.sender];
    }

    // Attendence for the event
    function entryEvent() public {
        require(invitedBy[msg.sender] > 0, "Not invited to the event");
        // require(
        //     block.timestamp >= eventDetails.startTime,
        //     "Event hasnt started"
        // );
        // require(
        //     block.timestamp <= eventDetails.startTime + eventDetails.duration,
        //     "Event has ended"
        // );

        eventDetails.attendees.push(msg.sender);

        // Credit the employee who invited this attendee
        address employee = tokenToEmployee[invitedBy[msg.sender]];
        employeeRewardCount[employee] += 1;
    }

    function payout() public onlyOwner {
        // to implement payout logic
    }

    function getOwner() public view onlyOwner returns (address) {
        return owner;
    }

    function getToken() external view returns (uint256) {
        return employeeTokens[msg.sender];
    }

    function getTokenOf(address _address) external view returns (uint256) {
        return employeeTokens[_address];
    }

    function getInviteeEmployee(
        address _invitee
    ) external view returns (address) {
        return tokenToEmployee[invitedBy[_invitee]];
    }

    function getAttendees() external view returns (address[] memory) {
        return eventDetails.attendees;
    }
}
