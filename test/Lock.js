const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Lock", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployOneYearLockFixture() {
    const [owner, otherAccount] = await ethers.getSigners();
    const tokenAdr = '0xed5C99A58bC4549EC185bc7b4F027FF529d67DFF';
    const vrfAdr =  '0xf1bCDeD879Fd1A837a9Ce03916cd8726Db55ee1F';
    const Lot = await ethers.getContractFactory("Lotery");
    const lot = await Lot.deploy(tokenAdr, vrfAdr);

    return { lot,  owner, otherAccount, tokenAdr};
  }
    it('Should be deploy', async function(){
      const { lot,  owner, otherAccount, tokenAdr } = await loadFixture(deployOneYearLockFixture);
      expect(await lot.a()).to.eq(tokenAdr);
    })
  });
