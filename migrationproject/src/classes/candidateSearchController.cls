public class candidateSearchController {

    String searchText;
    public integer ssize{get;set;}
    List<Candidate__c> results;

    public String getSearchText(){
        return searchText;
    }

    public void setSearchText(String s) {
        searchText = s;
    }

    public List<Candidate__c> getResults() {
        return results;
    }

    public PageReference doSearch() {
   if(searchText=='')
   {
   results=[select Mail_id__c,First_Name__c, Last_Name__c from Candidate__c where First_Name__c=:null  ];
   
   }
   else{
      results =(list<candidate__c>) [FIND :searchText  
                                  RETURNING 
                                     Candidate__c( Mail_id__c,First_Name__c, Last_Name__c)][0];
                                     ssize=results.size();
        system.debug('*************list size*************'+ssize);
      }  
     return null;
    }

}