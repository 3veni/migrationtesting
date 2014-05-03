trigger candidateid on Candidate__c (before update) {
    for(Candidate__c c:trigger.new)
    {
        if(c.Date_of_joining__c !=null && c.First_name__c!=null &&c.Last_name__c!=null)
        {
            string cid=c.First_name__c.substring(0,1).toUppercase()+c.Last_name__c.substring(0,1).toUppercase()+string.valueOf(c.Date_of_joining__c.year());
            system.debug('------candidateid-----'+cid);
        }
    }
    

}