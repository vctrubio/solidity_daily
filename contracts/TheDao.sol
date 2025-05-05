// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/*
- there is a local treasure
- a group of users belong to the dao
- each user puts money into the treasury ...
- map user address to voting power, ... based on money sent (msg.value) to the dao
 
-- USERS
- getShares (contribution), by depositing eth
- swap shares by other users
- redeemShares, by withdrawing if shares
-- we asume 1 share = 1 wei;

-- Proposals are like EVENTS
- created by contract owner,
- cast of vote for each proposal
- execute proposaﬁ
*/
contract DAO {
    uint256 public sum; // treasury
    mapping(address => uint256) public shares; // map user address to shares
    address[] private investors; //list of all users. aka investors

    struct DaoConfig {
        uint256 contributionTimeEnd;
        uint256 voteTime;
        uint256 quorum;
        bool isInitialized;
    }
    DaoConfig public myDao;

    //Holi Festival?
    function initializeDAO(
        uint256 _contributionTimeEnd, // since the initiañizer, in s
        uint256 _voteTime, //set the sduration in s
        uint256 _quorum //percentage of minimal vote weight neeeded // (e.g., 51 for 51%)
    ) public {
        require(myDao.isInitialized == false, "my already have a dao.");
        require(
            _contributionTimeEnd > 0,
            "Must be atleast a 0 seconds of contribution time"
        );
        require(_voteTime > 0, "Must be atleast a 0 seconds of voting time");
        require(
            _quorum > 0 && _quorum <= 100,
            "not a valid percentage for percentage quorum"
        );

        myDao = DaoConfig({
            contributionTimeEnd: block.timestamp + _contributionTimeEnd,
            voteTime: _voteTime,
            quorum: _quorum,
            isInitialized: true
        });
    }

    function addUserShare(address user, uint256 value) internal {
        if (shares[user] == 0) investors.push(user);
        shares[user] += value;
    }

    function exchange(
        address user,
        uint256 value,
        bool moneyForShares
    ) internal {
        if (moneyForShares) {
            sum += value;
            addUserShare(user, value);
        } else {
            sum -= value;
            shares[user] -= value;
        }
    }

    function contribution() public payable {
        require(
            block.timestamp <= myDao.contributionTimeEnd,
            "contribution period ended"
        );
        require(msg.value != 0, "contribution must be > 0");
        exchange(msg.sender, msg.value, true);
    }

    function reedemShare(uint256 amount) public {
        require(amount <= sum, "Not enough amount in treasury");
        require(shares[msg.sender] >= amount, "You don't have enough shares");
        exchange(msg.sender, amount, false);
        payable(msg.sender).transfer(amount);
    }

    function transferShare(uint256 amount, address to) public {
        require(
            amount <= shares[msg.sender],
            "You dont have enough shares to do this"
        );
        require(
            amount <= sum,
            "There is a problem. tresurary doesn't have the funds, but you do?"
        );
        shares[msg.sender] -= amount;
        addUserShare(to, amount);
    }

    function createProposal(
        string calldata description,
        uint256 amount,
        address payable receipient
    ) public {}

    function voteProposal(uint256 proposalId) public {}

    function executeProposal(uint256 proposalId) public {}

    function proposalList()
        public
        returns (string[] memory, uint[] memory, address[] memory)
    {}

    function allInvestorList() public view returns (address[] memory) {
        return investors;
    }
}
