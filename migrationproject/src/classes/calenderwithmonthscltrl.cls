public class calenderwithmonthscltrl {
    public list<Job_Applicaton__c> jlist{get;set;}
    public list<Job_Applicaton__c>jilist{get;set;}
    public Map<Integer,String> showmonth{get;set;}
    public integer imonth{get;set;}
    public string smonth{get;set;}
    public integer iyear{get;set;}
    public date d{get;set;}
    public string syear{get;set;}
    public integer days{get;set;}
    public calenderwithmonthscltrl(){
        jlist=[select id,Date_of_Application__c from Job_Applicaton__c];
        d = System.today();
        imonth=d.month();
        smonth=string.valueof(imonth);
        iyear=d.year();
        syear=string.valueof(iyear);
        showmonth = new Map<Integer,String>();  
        showmonth.put(1,'January');
        showmonth.put(2,'Febuary');
        showmonth.put(3,'March');
        showmonth.put(4,'April');
        showmonth.put(5,'May');
        showmonth.put(6,'June');
        showmonth.put(7,'July');
        showmonth.put(8,'August');    
        showmonth.put(9,'September');
        showmonth.put(10,'Octobar');
        showmonth.put(11,'November');
        showmonth.put(12,'December');
        returndate();
    }
    public void returndate(){
        days=date.daysinmonth(iyear,imonth);
        jilist=new list<Job_Applicaton__c>();
        for(Job_Applicaton__c j:jlist)
        {
         if(j.Date_of_Application__c.month()==imonth && j.Date_of_Application__c.year()==iyear)
         {
          jilist.add(j);
         }
        
        }
        smonth=showmonth.get(imonth);
    }
    public void prev(){
        if(imonth==1)
        {
        imonth=12;
        iyear=iyear-1;
        }
        else{
        imonth=imonth-1;
        }
        returndate();
    }
    public void next(){
        if(imonth==12)
            {
            imonth=1;
            iyear=iyear+1;
            }
        else
        {
        imonth=imonth+1;
        }
        returndate();
    }
    
}