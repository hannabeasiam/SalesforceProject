@isTest
public class AppleWatchTest {
    @isTest static void createOpportunitty() {
        Opportunity opp = new Opportunity();
        opp.Name = 'Swift Deal';
        opp.StageName = 'Proospecting';
        opp.CloseDate = Date.today();
        insert opp;
    }
}
