let CrowdfundingWithDeadline = artifacts.require("./CrowdfundingWithDeadline");

module.exports = function(deployer) {
    deployer.deploy(
        CrowdfundingWithDeadline,
        "Test campaign",
        1,
        200,
        "0x0A34553B4786aD145F1037d14706421a1C8D7e7c"
    )
}