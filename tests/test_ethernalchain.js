const EthernalChain = artifacts.require("EthernalChain");

contract("EthernalChain", accounts => {
  it("should set and get records correctly", async () => {
    const instance = await EthernalChain.deployed();
    await instance.setRecord("0x1234", { from: accounts[0] });
    const records = await instance.getRecords();
    assert.equal(records[0], "0x1234");
  });
});