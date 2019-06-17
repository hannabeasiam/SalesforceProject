# SalesforceProject
This repository includes SF99 , trailhead code challenge.

### Check Secret Information [Trigger](https://github.com/hannabeasiam/SalesforceProject/blob/develop/SFDEVELOPER/force-app/main/default/triggers/CheckSecretInformation.trigger) / [TestClass](https://github.com/hannabeasiam/SalesforceProject/blob/develop/SFDEVELOPER/force-app/main/default/classes/CheckSecretInformationTest.cls)
Check if Case Object Description field includs any secret keyword, 
if case contains a secret keyword, create a child case. Chile case subject 
must includs secret keyword.


### Warranty Summary [Trigger](https://github.com/hannabeasiam/SalesforceProject/blob/develop/SFDEVELOPER/force-app/main/default/triggers/WarrantySummary.trigger) / [TestClass](https://github.com/hannabeasiam/SalesforceProject/blob/develop/SFDEVELOPER/force-app/main/default/classes/WarrantySummaryTest.cls)
On Case creation, if product has warranty days, poppulate warranty summary field that includes Product purchase date, created date, warranty days, warranty percentage, hasExtended warranty. 


### Leading Competitor [Trigger](https://github.com/hannabeasiam/SalesforceProject/blob/develop/SFDEVELOPER/force-app/main/default/triggers/LeadingCompetitor.trigger) / [TestClass](https://github.com/hannabeasiam/SalesforceProject/blob/develop/SFDEVELOPER/force-app/main/default/classes/LeadingCompetitorTest.cls)
On opportunity creation or update, find competition company who offer lowest price, and display the leading competitor company's name & price  


### DBPROJECT [Link](https://github.com/hannabeasiam/SalesforceProject/blob/develop/DBPROJECT)
SCM project csv upload class - 2017


### TrailHead [Link](https://github.com/hannabeasiam/SalesforceProject/blob/develop/TrailHead)
Salesforce Trailhead playground