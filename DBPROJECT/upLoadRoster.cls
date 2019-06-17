global class upLoadRoster {
	global Blob csvFileBody{get;set;}
    global string csvAsString{get;set;}
    global String[] csvFileLines{get;set;}
    global List<Transaction_Data__c> rolist{get;set;}
    
     global upLoadRoster(){
        csvFileLines = new String[]{};
        rolist= New List<Transaction_Data__c>(); 
        
    }
    
    
  global void importCSVFile(){
       		
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n'); 
           Contact c = new Contact();
      	   
           for(Integer i=1;i<csvFileLines.size();i++){
               Transaction_Data__c roObj = new Transaction_Data__c() ; 
               string[] csvRecordData = csvFileLines[i].split(',');
               
               //concatenate the value contains a comma
               for(Integer j=0; j<csvRecordData.size(); j++){
               if(csvRecordData[j].startsWith('"')){
                   csvRecordData[j] = csvRecordData[j].remove('"')+', ' +csvRecordData[j+1].remove('"');
                   csvRecordData.remove(j+1);
                   //system.debug(csvRecordData[j]);
               	}
               }
               
               
               //fix empty date columns
               if(String.isBlank(csvRecordData[8])){
                   csvRecordData[8]='01/01/1970';
               }
               
               roObj.Contact_Master_Transaction_Data__c = csvRecordData[0] ;
               roObj.Course__c = csvRecordData[4] ;
               roObj.Payment_Method_Roster__c = csvRecordData[5] ;
               roObj.Course_Start_Date__c = Date.parse(csvRecordData[6]);
               roObj.Retakes__c  = csvRecordData[7] ; //from picklist to text type modified
               roObj.Exam_Date__c = Date.parse(csvRecordData[8]);   //00:33:37:166 VARIABLE_ASSIGNMENT [35]|this.Exam_Date__c|"2017-10-03T00:00:00.000Z"|0xa75a969         
               roObj.Instructor_Last_Name__c = csvRecordData[9]; 
               roObj.Instructor_Email__c = csvRecordData[10] ;
               roObj.Proctor_Name__c = csvRecordData[11];
               roObj.Proctor_Contact__c = csvRecordData[12];
               roObj.Onsite_Remote_Proctoring__c = csvRecordData[13];
               roObj.Note_from_Roster__c = csvRecordData[14];
           
               roObj.Duplication_Filter_TD__c = roObj.Contact_Master_Transaction_Data__c+ roObj.Course__c + 'Retake'+roObj.Retakes__c;
               rolist.add(roObj);
               system.debug(rolist);
               
               

           }
         try{
         	
         	upsert rolist;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Roster records have uploaded successfully.'));
 
         }
        catch (Exception e)
        {
         
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured. These Roster records may have existed. Please check or try again later');
            ApexPages.addMessage(errormsg);
        }    
        
  }
  
    public void error(string message){ 
        system.debug(message); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message)); 
    }

}