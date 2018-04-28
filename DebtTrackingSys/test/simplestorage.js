var Debtor = [];
Debtor.push(artifacts.require("./Debtor0.sol"));
Debtor.push(artifacts.require("./Debtor1.sol"));
Debtor.push(artifacts.require("./Debtor2.sol"));
Debtor.push(artifacts.require("./Debtor3.sol"));
var Creditor = [];
Creditor.push(artifacts.require("./Creditor0.sol"));
Creditor.push(artifacts.require("./Creditor1.sol"));

/*
    Test that Debtor0 can "send" 1000 wei to Crditor0
*/
contract('Debtor0', function(accounts) {
    it("should send 1000 to Creditor0...", function() {
        return Debtor[0].deployed().then(function(debtorInstance) {
            debtor0 = debtorInstance;
            return Creditor[0].deployed().then((creditorInstance) => {
                creditor0 = creditorInstance;
                return debtor0.thisBalance.call();
            }).then((balance) =>{
                b = balance.toNumber()
                assert.equal(b, 1000000000000000000, "Should have balance 1000000000000000000");
                return debtor0.addCreditor(Creditor[0].address, 1000);
            }).then(()=> {
                return creditor0.thisBalance.call();
            }).then((balance)=>{
                b = balance.toNumber()
                assert.equal(b, 0, "Should have balance 0");
                return creditor0.claimNextDebt();
            }).then(()=>{
                return creditor0.thisBalance.call();
            }).then((balance)=>{
                b = balance.toNumber()
                assert.equal(b, 1000, "Should have balance 0");
            });
        });
    });
});

contract('All Debtors 0 - 3', function(accounts) {
    it("should send 1000 to Creditor0...", function() {
        return Debtor[0].deployed().then(function(debtor0Instance) {
            debtor = [];
            creditor = [];
            debtor.push(debtor0Instance);
            return Debtor[1].deployed().then((debtor1Instance) => {
                debtor.push(debtor1Instance);
                return Debtor[2].deployed().then((debtor2Instance) => {
                    debtor.push(debtor2Instance);
                    return Debtor[3].deployed().then((debtor3Instance) => {
                        debtor.push(debtor3Instance);
                        return Creditor[0].deployed().then((creditor0Instace) => {
                            creditor.push(creditor0Instace);
                            return debtor[0].thisBalance.call();
                        })
                    })
                })
            }).then((balance) =>{
                b = balance.toNumber()
                assert.equal(b, 1000000000000000000, "Should have balance 1000000000000000000");
                return debtor[0].addCreditor(Creditor[0].address, 1000);
            }).then(()=> {
                return debtor[1].addCreditor(Creditor[0].address, 1000);
            }).then(()=> {
                return debtor[2].addCreditor(Creditor[0].address, 1000);
            }).then(()=> {
                return debtor[3].addCreditor(Creditor[0].address, 1000);
            }).then(()=> {
                return creditor[0].thisBalance.call();
            }).then((balance)=>{
                b = balance.toNumber()
                assert.equal(b, 0, "Should have balance 0");
                return creditor[0].claimNextDebt();
            }).then(()=>{
                return creditor[0].claimNextDebt();
            }).then(()=>{
                return creditor[0].claimNextDebt();
            }).then(()=>{
                return creditor[0].claimNextDebt();
            }).then(()=>{
                return creditor[0].thisBalance.call();
            }).then((balance)=>{
                b = balance.toNumber()
                assert.equal(b, 4000, "Should have balance 4000");
            });
        });
    });
});
