[owner, a1, a2, a3, a4] = await ethers.getSigners();
const provider = ethers.provider;
const getC = await ethers.getContractFactory("EventToken");
const c = await getC.deploy(1743379200, 3600); // May 29, 2025, 1-hour duration
await c.waitForDeployment();
const address = await c.getAddress();

const c1 = await c.connect(a1);
const c2 = await c.connect(a2);
const c3 = await c.connect(a3);

// a2 subscribes
await c2.sub();

// a2 invites a3
await c2.invite(a3.address);

// a3 attends the event (during the event time window)
await c3.entryEvent();