public class NewCaseListController {
    
    public List<Case> getNewCases() {
        List<Case> caseResults = Database.query(
            'SELECT Id, CaseNumber, Status ' +
            'FROM Case ' +
            'WHERE Status = \'New\''
        );
        return caseResults;
    }
}