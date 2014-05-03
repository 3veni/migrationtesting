public class Job2
{
public list<Job_Applicaton__c> obj {get;set;}

public string s1{get;set;}
public Job2()
{
s1=ApexPages.currentPage().getParameters().get('id');
for(Job_Applicaton__c ob:[select id,name,Cover_Letter__c,Position__c,Status__c from Job_Applicaton__c  where id =:s1])
obj.add(ob);
}
}