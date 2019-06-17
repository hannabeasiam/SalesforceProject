trigger CheckSecretInformation on Case (after insert, before update) {

    String childCaseSubject = 'Warning: Parent case may contain secret info';

    // Create a collection containing each of our secret keywords
    Set<String> secreateKeywords = new Set<String>();
    secreateKeywords.add('Credit Card');
    secreateKeywords.add('Social Security');
    secreateKeywords.add('SSN');
    secreateKeywords.add('Passport');
    secreateKeywords.add('Bodyweight');

    // Check to see if our case contains any of the secret keywords
    List<Case> caseWithSecretInfo = new List<Case>();   
 // get exact word that matched with secret keywords
    Set<String> whichKey = new Set<String>();
    
    for (Case myCase : Trigger.new) {
        if (myCase.Subject != childCaseSubject) {
            Boolean newCase = true;
            for (String keyword : secreateKeywords) {
                if (myCase.Description != null && myCase.Description.containsIgnoreCase(keyword)) {
                    if ( newCase == true) {
                        caseWithSecretInfo.add(myCase);
                        System.debug('Case ' + myCase.Id + ' include secret keyword ' + keyword);
                        whichKey.add(keyword);
                        newCase = false;
                    } else {
                        System.debug('Case ' + myCase.Id + ' include secret keyword ' + keyword);
                        whichKey.add(keyword);
                    }
                }
            }
        }
    }
    // If the case contains a secret keyword, create a child case
    List<Case> casesToCreate = new List<Case>();
    for (Case caseWithSecretInfo : caseWithSecretInfo) {
        Case childCase       = new Case();
        childCase.subject    = childCaseSubject;
        childCase.ParentId   = caseWithSecretInfo.Id;
        childCase.IsEscalated= true;
        childCase.Priority   = 'High';
        childCase.Description= 'Following keywords were found ' + whichKey;
        casesToCreate.add(childCase);
    }
    insert casesToCreate; 
}