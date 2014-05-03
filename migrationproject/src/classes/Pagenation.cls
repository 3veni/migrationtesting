public class Pagenation
{
    public list<Account> lstAcc {get;set;}
    public list<Account> sublstAcc {get;set;}
    public string pageindex1{get;set;}
    public Integer PageIndex{get;set;}
    public list<integer> ilist{get;set;}
    public Integer TotalPages{get;set;}
    public boolean FirstPageFlag{get;set;}
    public boolean LastPageFlag{get;set;}
    public boolean NextPageFlag{get;set;}
    public boolean PrevPageFlag{get;set;}
    public integer Isok{get;set;} 
    public string SelectedAccountId { get; set; }   
    public Pagenation()
    {
         LoadData();
         ilist=new list<integer>();
        Account obj=new Account();
        sublstAcc = new list<Account>();
        
        Pageindex=1;
        FirstPageFlag=true;
        LastPageFlag=true;
        NextPageFlag=true;
        PrevPageFlag=true;
        TotalPages =lstAcc.size()/13;
        if((math.mod(lstAcc.size(),13)>0))
        {
            TotalPages =TotalPages +1;
        }
        for(Integer j=((PageIndex-1)*13);j<=((PageIndex*13)-1);j++)
            {
                 Account obj1= lstAcc [j];   
                 sublstAcc.add(obj1);
            }
            for(integer n=1;n<=TotalPages;n++)
            {  
            ilist.add(n);
            }
    }
    public void  LoadData()
    {
    lstAcc=[select Name,site,Phone,NumberOfEmployees from Account];
    }
    public void  First()
    {
        Pageindex=1;
        ListIndex(); 
             if(Pageindex<TotalPages )
             {
              LastPageFlag=true;
              FirstPageFlag=false;
              NextPageFlag=true;
              PrevPageFlag=false;
             }
             else  {if(pageindex==1)            {
               LastPageFlag=true;
              FirstPageFlag=true;
              NextPageFlag=true;
              PrevPageFlag=true;
         }
         }
        
    }
    
     public void Last()
      {
        PageIndex=TotalPages;
        ListIndex();
        if(PageIndex==TotalPages)
        {
             FirstPageFlag=false;
             NextPageFlag=false;
             PrevPageFlag=false;
             LastPageFlag=false;
        }
      }
      public pagereference lin()
      {
      system.debug('-------pageindex------'+Isok);
      PageIndex=Isok;
      ListIndex();
      return null;
      }
    
    public void Next()
    {
        if(PageIndex<TotalPages)
        {
           PageIndex =PageIndex+1;
           ListIndex();
           FirstPageFlag=false;
           NextPageFlag=true;
           PrevPageFlag=false;
           LastPageFlag=true;
        } 
    
         else if(PageIndex==TotalPages)
           {
             FirstPageFlag=false;
             NextPageFlag=false;
             PrevPageFlag=false;
             LastPageFlag=false;
             
}            
    }
    
    public void Prev()
    {
        if(PageIndex>1)
        {
          Pageindex--;
          ListIndex();
          FirstPageFlag=false;
          NextPageFlag=true;
          PrevPageFlag=false;
          LastPageFlag=true;
        }
      else{ if(Pageindex==1 )
             {
              LastPageFlag=true;
              FirstPageFlag=true;
              NextPageFlag=true;
              PrevPageFlag=true;
                 
                  
             }
                         
             
} 
     }
     
    public void ListIndex()
    {
       sublstAcc = new list<Account>();
         if(PageIndex<TotalPages)
         {
             for(Integer i=((PageIndex-1)*13);i<=((PageIndex*13)-1);i++)
                {
                 Account obj= lstAcc [i];   
                 sublstAcc.add(obj);
                }
          }
          else
          {
              if(PageIndex==TotalPages)
              {
                  for(Integer k=((PageIndex-1)*13);k<=lstAcc.size()-1;k++)
                  {
                      Account obj2=lstAcc[k];
                      sublstAcc.add(obj2);
                  }
              }
          }
    }
    
  
   public void DeleteAccount()
   {
      // if for any reason we are missing the reference 
      if (SelectedAccountId == null) {
      
         return;
      }
     
      // find the account record within the collection
      Account tobeDeleted = null;
      for(Account a :lstAcc )
       if (a.Id == SelectedAccountId) {
          tobeDeleted = a;
          break;
       }
      
      //if account record found delete it
      if (tobeDeleted != null) {
       Delete tobeDeleted;
      }
     
      //refresh the data
      LoadData();
   }    
  
  
    
}