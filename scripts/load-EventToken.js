[owner, a1, a2, a3, a4] = await ethers.getSigners();
const provider = ethers.provider;
const getC = await ethers.getContractFactory("EventToken");
const c = await getC.deploy()
await c.waitForDeployment();
const address = await c.getAddress();

const c1 = await c.connect(a1);
const c2 = await c.connect(a2);
const c3 = await c.connect(a3);

await c2.sub();
await c2.invite(a3.address);
await c3.entryEvent();