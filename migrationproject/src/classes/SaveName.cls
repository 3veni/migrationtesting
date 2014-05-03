public Class SaveName
{
public Job_Applicaton__c a1{get;set;}
//public string s1{get;set;}
    public SaveName()
    {
    a1=[select id,name,Hello__c from Job_Applicaton__c where id =:apexpages.currentpage().getParameters().get('id')];

    }
    public  void Save()
    {
        update a1;
    }
    
public  string Cancle()
    {
       return null;
    }
    
public  string Edit()
    {
       return null;
    }

}