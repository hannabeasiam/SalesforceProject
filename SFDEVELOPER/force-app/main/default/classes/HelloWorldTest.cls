@isTest
private class HelloWorldTest {
    
    @isTest static void updateLead() {
        Lead myLead = new Lead();
        myLead.FirstName = 'Hanna';
        myLead.LastName = 'Lee';
        myLead.Company = 'Asan';
        insert myLead;

        myLead.Company = 'Pluralsignt';
        update myLead;
    }

}
