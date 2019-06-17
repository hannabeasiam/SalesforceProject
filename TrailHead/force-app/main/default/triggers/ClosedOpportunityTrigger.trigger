trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
	// trigger will add a task to any opportnity  with the stage of 'Closed Won' 
	// task 's subject must be 'Follow Up Test Task'
	// to associate the task with the opportunitty fill the WhatId field with the opportunity ID
	List<Task> taskList = new List<Task>();
    
	for (Opportunity opp : [SELECT Id, StageName FROM Opportunity 
                            WHERE Id IN :Trigger.New AND
                            StageName = 'Closed Won']) {
                               
                                taskList.add(new Task(WhatId = opp.Id, 
                                                      Subject = 'Follow Up Test Task'));
                                
                            }
    if(taskList.size() >0) {
        insert taskList;
    }
}