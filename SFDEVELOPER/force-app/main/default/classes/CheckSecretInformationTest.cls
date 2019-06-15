/* Test Class requirements:
    1. crate or update a case
    2. case subject can't begin with "Warning"
    3. case description can't be null
    4. case description contains secret keyword

*/
@isTest
public class CheckSecretInformationTest {
    @isTest static void cretaeCaseWithSecretInfo() {
        Case myCase = new Case();
        myCase.Subject = 'HELP';
        myCase.Description = 'my SSN is 123-15-1321';
        insert myCase;
        System.debug('Case ' + myCase.Id + 'created with ' + myCase.Description);
    }
}
