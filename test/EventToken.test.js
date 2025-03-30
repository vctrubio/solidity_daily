const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Event Contract", function () {
    let eventContract;
    let owner;
    let addr1;
    let addr2;

    beforeEach(async function () {
        [owner, addr1, addr2] = await ethers.getSigners();

        const EventTokenFactory = await ethers.getContractFactory("EventToken");
        eventContract = await EventTokenFactory.deploy();
        await eventContract.waitForDeployment();
    });

    describe("Deployment", function () {
        it("Should set the right owner", async function () {
            // Use ethers to read thecontract
            const contractOwner = await eventContract.getOwner();
            expect(contractOwner).to.equal(await owner.getAddress());
        });
    });
});
