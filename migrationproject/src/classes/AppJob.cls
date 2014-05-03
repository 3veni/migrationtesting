public class AppJob
{
public list<Job_Applicaton__c> obj {get;set;}

public string s1{get;set;}

public AppJob()
{
s1=ApexPages.currentPage().getParameters().get('id');

for(Job_Applicaton__c ob:[select id,name,Cover_Letter__c,Position__c,Status__c,Candidate__c from Job_Applicaton__c  where Candidate__c=:s1])
{
obj.add(ob);
}
}
}