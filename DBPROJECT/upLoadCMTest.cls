global class upLoadCMTest {
    public PageReference upLoadCM() {
        PageReference pageRef = new PageReference('/apex/upLoadCM');
        return null;
    }

    global Blob csvFileBody{get;set;}
    global string csvAsString{get;set;}
    global String[] csvFileLines{get;set;}
    global List<Transaction_Data__c> updatelist{get;set;}
    global List<Transaction_Data__c> insertlist{get;set;}
    global upLoadCMTest(){
        csvFileLines = new String[]{};
        updatelist = New List<Transaction_Data__c>(); 
        insertlist = New List<Transaction_Data__c>();
    }

    global void importCSVFile(){
       
        csvAsString = csvFileBody.toString();
        csvFileLines = csvAsString.split('\n'); 
        Contact c = new Contact();

        for(Integer i=1;i<csvFileLines.size();i++){
            Transaction_Data__c cmObj = new Transaction_Data__c() ; 
            string[] csvRecordData = csvFileLines[i].split(',');
            cmObj.Contact_Master_Transaction_Data__c = csvRecordData[0];
            cmObj.CM_User_ID__c = csvRecordData[2] ;
            cmObj.CM_Terms_Agreed__c = Integer.valueOf(csvRecordData[3]);
            cmObj.CM_Order_Date__c  = Date.parse(csvRecordData[4]) ;
            cmObj.CM_Voucher_Code__c = csvRecordData[6] ;             
            cmObj.CM_Status__c = csvRecordData[7]; 
            cmObj.CM_Voucher_Discount__c = Decimal.valueOf(csvRecordData[8]) ;
            cmObj.CM_Net_Total__c = Decimal.valueOf(csvRecordData[9]);
            cmObj.CM_Tax__c = Decimal.valueOf(csvRecordData[10]); //dev version tax is currency so added decimal.
            cmObj.CM_Grosstotal__c = Decimal.valueOf(csvRecordData[11]);
            cmObj.CM_Payment_Source__c = csvRecordData[12];
            cmObj.CM_Payment_ID__c = csvRecordData[13];
            cmObj.CM_Status__c = csvRecordData[15];
            cmObj.CM_Product_Line_Name1__c = csvRecordData[37];
            cmObj.CM_Product_Line_Code1__c = csvRecordData[38];
            //after product_line_code1 and name1 have not yet coded
               
           //generate course name according to product line code 1
            if( cmObj.CM_Product_Line_Code1__c.contains('Inventory-Management')||cmObj.CM_Product_Line_Code1__c.contains('IM')){
                cmObj.Course__c = 'Inventory Management';   
            } 
            if (cmObj.CM_Product_Line_Code1__c.contains('Supply-Management-and-Procurement')||cmObj.CM_Product_Line_Code1__c.contains('SMP')){
                cmObj.Course__c = 'Supply Management & Procurement';
            } 
            if (cmObj.CM_Product_Line_Code1__c.contains('Transportation-Operations')||cmObj.CM_Product_Line_Code1__c.contains('TO')){
                cmObj.Course__c = 'Transportation Operations';
            } 
            if (cmObj.CM_Product_Line_Code1__c.contains('Manufacturing-and-Service-Operations')||cmObj.CM_Product_Line_Code1__c.contains('MSO')){
                cmObj.Course__c = 'Manufacturing & Service Operations';
            } 
            if (cmObj.CM_Product_Line_Code1__c.contains('Customer-Service-Operations')||cmObj.CM_Product_Line_Code1__c.contains('CSO')){
                cmObj.Course__c = 'Customer Service Operations';
            } 
            if (cmObj.CM_Product_Line_Code1__c.contains('Demand-Planning')||cmObj.CM_Product_Line_Code1__c.contains('DP')){
                cmObj.Course__c = 'Demand Planning';
            } 
            if (cmObj.CM_Product_Line_Code1__c.contains('Manufacturing-Operations')||cmObj.CM_Product_Line_Code1__c.contains('MO')){
                cmObj.Course__c = 'Manufacturing Operations';
            }
            if (cmObj.CM_Product_Line_Code1__c.contains('Supply-Chain-Management-Principles')||cmObj.CM_Product_Line_Code1__c.contains('SCMP')){
                cmObj.Course__c = 'Supply Chain Management Principles';
            }
            if (cmObj.CM_Product_Line_Code1__c.contains('Warehousing-Operations-Hosmer')||cmObj.CM_Product_Line_Code1__c.contains('WO')){
                cmObj.Course__c = 'Warehousing Operations Hosmer';            
            } 
            if (cmObj.CM_Product_Line_Code1__c.contains('Demo')){
                cmObj.Course__c = 'Demo';
            } 
            if (cmObj.CM_Product_Line_Code1__c.contains('First-Retake')){
                cmObj.Retake__c = '1';
            }
            if (cmObj.CM_Product_Line_Code1__c.contains('Second-Retake')){
                cmObj.Retake__c = '2';
            }
            if (cmObj.CM_Product_Line_Code1__c.contains('Third-Retake')){
                cmObj.Retake__c = '3';
            }
            // add No
            if (cmObj.Retake__c == NULL){
                cmObj.Retake__c = 'No';
            }
               
               
            // generate duplication key
            cmObj.Duplication_Filter_TD__c = String.valueOf(cmObj.Contact_Master_Transaction_Data__c + cmObj.Course__c +'Retake'+ cmObj.Retake__c);  //modifield from retake__c
          	   
            //Pull record that has same contact id and duplication key       
            List<Transaction_Data__c> existingTransaction = [SELECT Duplication_Filter_TD__c, Name, Id, CM_Grosstotal__c, CM_Net_Total__c, CM_Order_Date__c, CM_Order_Number__c, CM_Payment_ID__c,CM_Payment_Source__c, CM_Payment_Status__c, CM_Product_Line_Code1__c, CM_Product_Line_Name1__c, CM_Status__c, CM_Subtotal__c, CM_Terms_Agreed__c, CM_Tax__c, CM_User_ID__c, CM_Voucher_Code__c, CM_Voucher_Discount__c                                                               		 
													   			FROM Transaction_Data__c WHERE Contact_Master_Transaction_Data__c =: csvRecordData[0] AND Duplication_Filter_TD__c =:  cmObj.Duplication_Filter_TD__c ];
              
               if(existingTransaction.isEmpty()){
                   insertlist.add(cmObj);    
               } else{
                   for(Transaction_Data__c oldRecord : existingTransaction ){
                       if(oldRecord.CM_Order_Date__c == null){
                       oldRecord.Name = oldRecord.Name;
                       oldRecord.CM_Order_Number__c = cmObj.CM_Order_Number__c;
                       oldRecord.CM_Grosstotal__c = cmObj.CM_Grosstotal__c;
                       oldRecord.CM_Net_Total__c = cmObj.CM_Net_Total__c;
                       oldRecord.CM_Order_Date__c = cmObj.CM_Order_Date__c;
                       oldRecord.CM_Payment_ID__c = cmObj.CM_Payment_ID__c;
                       oldRecord.CM_Payment_Source__c = cmObj.CM_Payment_Source__c;
                       oldRecord.CM_Payment_Status__c = cmObj.CM_Payment_Status__c;
                       oldRecord.CM_Product_Line_Code1__c = cmObj.CM_Product_Line_Code1__c;
                       oldRecord.CM_Product_Line_Name1__c = cmObj.CM_Product_Line_Name1__c;
                       oldRecord.CM_Status__c = cmObj.CM_Status__c;
                       oldRecord.CM_Subtotal__c = cmObj.CM_Subtotal__c;
                       oldRecord.CM_Terms_Agreed__c = cmObj.CM_Terms_Agreed__c;
                       oldRecord.CM_User_ID__c = cmObj.CM_User_ID__c;
                       oldRecord.CM_Voucher_Code__c = cmObj.CM_Voucher_Code__c;
                       oldRecord.CM_Voucher_Discount__c = cmObj.CM_Voucher_Discount__c;
                       updatelist.add(oldRecord);
              
                       }//end of if(oldRecord.CM_Order_Date__c == null)
               		} // end of  for(Transaction_Data__c oldRecord : existingTransaction )
               }//end of else
               
        }//End of for(Integer i=1;i<csvFileLines.size();i++)  
          //system.debug(updatelist); 
      	  //system.debug(insertlist); 
         
        try{
            update updatelist;
            insert insertlist;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'CM orders records have uploaded successfully.'));
            }
        catch (Exception e)
            {
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured. Please check the template or try again later');
            ApexPages.addMessage(errormsg);
            }    
   
    } // end for importCSVFile()     
    
    public void error(string message){ 
    system.debug(message); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message)); 
  	}  // end error

} // end for upLoadCMTest