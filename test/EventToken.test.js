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

    describe("Deployment within owner", function () {
        it("Should set the right owner", async function () {
            const contractOwner = await eventContract.getOwner();
            expect(contractOwner).to.equal(await owner.getAddress());
        });

        it("Should reject non-owner from calling getOwner", async function () {
            const eventContractAsAddr1 = eventContract.connect(addr1);

            await expect(eventContractAsAddr1.getOwner())
                .to.be.rejectedWith("mod: Only Authority");
        });
    });
});
