public class Pagination3 {

    public List<Account> accs { get; set; }
    public list<Account> sublstAcc {get;set;}
    public Integer PageIndex{get;set;}
    public Integer TotalPages{get;set;}
    public boolean FirstPageFlag{get;set;}
    public boolean LastPageFlag{get;set;}
    public boolean NextPageFlag{get;set;}
    public boolean PrevPageFlag{get;set;}
    public string Isok{get;set;}    
    public string SelectedAccountId { get; set; }
  
    public Pagination3()
     {
        LoadData();
        Account obj=new Account();
        sublstAcc = new list<Account>();
        
        Pageindex=1;
        FirstPageFlag=false;
        LastPageFlag=true;
        NextPageFlag=true;
        PrevPageFlag=false;
        TotalPages =accs.size()/10;
        if((math.mod(accs.size(),10)>0))
        {
            TotalPages =TotalPages +1;
        }
        for(Integer j=((PageIndex-1)*10);j<=((PageIndex*10)-1);j++)
            {
                 Account obj1= accs [j];   
                 sublstAcc.add(obj1);
            }
    
       //load account data into our DataTable
      
    }
    private void LoadData() 
    {
       accs = [Select id, name, BillingStreet, BillingCity, BillingPostalCode, BillingCountry from Account ];
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
     }
    
   public void  Last()
    {
        PageIndex=TotalPages;
        ListIndex();
        if(PageIndex==TotalPages)
        {
             FirstPageFlag=true;
             NextPageFlag=false;
             PrevPageFlag=true;
             LastPageFlag=false;
        }
    }
    
    public void Next()
    {
        if(PageIndex<TotalPages)
        {
           PageIndex =PageIndex+1;
           ListIndex();
           FirstPageFlag=true;
           NextPageFlag=true;
           PrevPageFlag=true;
           LastPageFlag=true;
        } 
    
         else if(PageIndex==TotalPages)
           {
             FirstPageFlag=true;
             NextPageFlag=false;
             PrevPageFlag=true;
             LastPageFlag=false;
           }            
    }
    
    public void Prev()
    {
        if(PageIndex>1)
        {
          Pageindex--;
          ListIndex();
          FirstPageFlag=true;
          NextPageFlag=true;
          PrevPageFlag=true;
          LastPageFlag=true;
        }
      else{ if(Pageindex==1 )
             {
              LastPageFlag=true;
              FirstPageFlag=false;
              NextPageFlag=true;
              PrevPageFlag=false;
             }
          } 
     }
     
    public void ListIndex()
    {
       sublstAcc = new list<Account>();
         if(PageIndex<TotalPages)
         {
             for(Integer i=((PageIndex-1)*10);i<=((PageIndex*10)-1);i++)
                {
                 Account obj= accs [i];   
                 sublstAcc.add(obj);
                }
          }
          else
          {
              if(PageIndex==TotalPages)
              {
                  for(Integer k=((PageIndex-1)*10);k<=accs.size()-1;k++)
                  {
                      Account obj2=accs[k];
                      sublstAcc.add(obj2);
                  }
              }
          }
    }
  
  
   //used to get a hold of the account record selected for deletion
  public void DeleteAccount()
   {
      // if for any reason we are missing the reference 
      if (SelectedAccountId == null) {
      
         return;
      }
     
      // find the account record within the collection
      Account tobeDeleted = null;
      for(Account a : accs)
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