trigger WarrantySummary on Case (before insert) {
    String endingStatement      = 'Have a nice Day!';

    for (Case myCase : Trigger.new) {
        // Debug  NullPointerException : run only if warranty fields are not null
        if(myCase.Product_Purchase_Date__c != null && 
            myCase.Product_Total_Warranty_Days__c != null && 
            myCase.Product_Has_Extended_Warranty__c != null) {
            
            String purchaseDate = myCase.Product_Purchase_Date__c.format();
            String createdDate = DateTime.now().format();
            // Illegal assignment from Decimal to Integer (5:17)ApexTrigger
            Integer warrantyDays        = myCase.Product_Total_Warranty_Days__c.intValue();
            Decimal warrantyPercentage  = (100 * (myCase.Product_Purchase_Date__c.daysBetween(Date.today()) / myCase.Product_Total_Warranty_Days__c)).setScale(2);
            Boolean hasExtendedWarranty = myCase.Product_Has_Extended_Warranty__c;
            
            // Populate summary field
            myCase.Warranty_Summary__c = 'Product purchased on ' + purchaseDate + ' '
                                    + 'and case created on ' + createdDate + '.\n'
                                    + 'Warranty is for ' + warrantyDays + ' ' 
                                    + 'days and is ' + warrantyPercentage + '% through its warranty period.\n'
                                    + 'Extended warranty: ' + hasExtendedWarranty + '\n'
                                    + endingStatement;
            }
    }
}