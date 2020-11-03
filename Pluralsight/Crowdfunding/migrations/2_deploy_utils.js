let Utils = artifacts.require("./Utils.sol");
let CrowdfundingWithDeadline = artifacts.require("./CrowdfundingWithDeadline");
let TestCrowdfundingWithDeadline = artifacts.require("./TestCrowdfundingWithDeadline");

module.exports = async function(deployer) {
    await deployer.deploy(Utils);
    deployer.link(Utils, CrowdfundingWithDeadline);
    deployer.link(Utils, TestCrowdfundingWithDeadline);
};