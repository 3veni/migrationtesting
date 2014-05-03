public with sharing class JobApp {
public list<Job_Applicaton__c> job{get;set;}
public Job_Applicaton__c j1 {get;set;}
public Position__c p2{get;set;}
public boolean b1{get;set;}
public list<Position__c> p1{get;set;}
    public  jobApp()
    {
    job=new list<Job_Applicaton__c>();
    p1=new list<Position__c>();
    p1=[select id,name from Position__c];
    job=[select id,Status__c ,Position__c from Job_Applicaton__c];
    job.add(j1);
    b1=false;
    p1.add(p2);
        if(j1.Position__c==p2.name)
        {
            if(j1.Status__c=='Hired')
            {
                b1=true;
                j1.Status__c='Rejected';
                
             }
            
        }
        
    }
}