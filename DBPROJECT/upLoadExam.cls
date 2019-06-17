global class upLoadExam {
	global Blob csvFileBody{get;set;}
    global string csvAsString{get;set;}
    global String[] csvFileLines{get;set;}
    global List<Exam_Result__c> exlist{get;set;}
     global upLoadExam(){
        csvFileLines = new String[]{};
        exlist = New List<Exam_Result__c>(); 
    }
    
    
  global void importCSVFile(){
       
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n'); 
           Contact c = new Contact();
      
			                
    		for(Integer i=1;i<csvFileLines.size();i++){
               Exam_Result__c exObj = new Exam_Result__c(); 
               string[] csvRecordData = csvFileLines[i].split(',');
                
                //delete "%" sign
               String percentage = csvRecordData[6].left(5);
               
                //fill out empty columns
                /*for(Integer j=17; j<=21; j++){
                 if(String.isBlank(csvRecordData[17])){
                    csvRecordData[17]='none';
                    }
                if(String.isBlank(csvRecordData[18])){
                    csvRecordData[18]='none';
                    }
                if(String.isBlank(csvRecordData[19])){
                    csvRecordData[19]='none';
                    }
                if(String.isBlank(csvRecordData[20])){
                    csvRecordData[20]='none';
                    }
                if(String.isBlank(csvRecordData[21])){
                    csvRecordData[21]='none';
                    }*/
                for(Integer j=17; j<21; j++){
                    if(String.isBlank(csvRecordData[j])){
                    csvRecordData[j]='none';
                }
    
                
                //concatenate the value contains a comma
               for(Integer k=0; k<csvRecordData.size(); k++){
               if(csvRecordData[k].startsWith('"')){
                   csvRecordData[k] = csvRecordData[k].remove('"')+', ' +csvRecordData[k+1].remove('"');
                   csvRecordData.remove(k+1);
                   //system.debug(csvRecordData[j]);
               	}
               }    
				
               
               exObj.Contact_Master_Exam_Result__c = csvRecordData[0] ;
               //exObj.Affiliation__c = csvRecordData[1] ;
               exObj.Track__c= csvRecordData[2] ;
               exObj.Percentage__c = Decimal.valueOf(percentage);
               exObj.Points_Received__c= Decimal.valueOf(csvRecordData[7]);
               exObj.Points_Available__c = Decimal.valueOf(csvRecordData[8]);//Date.parse(csvRecordData[8]) ;             
               exObj.Minutes__c = Decimal.valueOf(csvRecordData[9]); 
               exObj.Seconds__c = Decimal.valueOf(csvRecordData[10]);
               exObj.Date_Started__c = csvRecordData[11];
               exObj.Date_Finished__c = csvRecordData[12];
               exObj.Requires_Grading__c = csvRecordData[13];
               exObj.Access_code__c = csvRecordData[15];
               // system.debug(exObj);
               exlist.add(exObj);            
               // system.debug(exlist);
              
           }
         try{
         	// system.debug(exlist);
         	insert exlist;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Exam Result records have uploaded successfully.'));
         }
        catch (Exception e)
        {
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured. Please check the template or try again later');
            ApexPages.addMessage(errormsg);
        }    
        
  }//for loop end
 }
  
    public void error(string message){ 
        system.debug(message); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message)); 
    }

}