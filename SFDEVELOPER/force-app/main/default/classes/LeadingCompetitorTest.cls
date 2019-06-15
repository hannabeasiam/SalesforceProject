@isTest
private class LeadingCompetitorTest {
    @isTest static void createOppWithCompetitors() {
    // create an opportunity with required fiedl
    Opportunity opp = new Opportunity();
    opp.Name      = 'Competitor Deal';
    opp.CloseDate = Date.today();
    opp.StageName = 'Prospecting';

    // populate all 3 competitor price fields
    opp.Competitor_1_Price__c = 100;
    opp.Competitor_2_Price__c = 200;
    opp.Competitor_3_Price__c = 300;

    // populate all 3 competitor fields
    opp.Competitor_1__c = 'A_Company';
    opp.Competitor_2__c = 'B_Company';
    opp.Competitor_3__c = 'C_Company';
    }
}
