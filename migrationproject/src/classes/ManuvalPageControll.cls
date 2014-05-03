public class ManuvalPageControll { 
  public integer n1{get;set;}
    public integer i1{get;set;}
    public integer n2{get;set;}
    public boolean b1{get;set;}
    public list<Account> lstAcc {get;set;}
    public list<Account> lstAcc1 {get;set;}
    public Account a1{get;set;}
    public Integer currentpage{get;set;}
    public Integer pagenumber{get;set;}
    public Integer PageIndex{get;set;}
    public Integer TotalPages{get;set;}
    public boolean FirstPageFlag{get;set;}
    public boolean LastPageFlag{get;set;}
    public boolean NextPageFlag{get;set;}
    public boolean PrevPageFlag{get;set;}
    public string Isok{get;set;}  
    public string s2{get;set;}
    public string pageinfo{get;set;} 
    public map<id,integer> mappingIndex{get;set;}
    public ManuvalPageControll ()
    {
        lstAcc=new list<Account>();
        lstAcc1 = new list<Account>();
        mappingIndex   =new map<id,integer>();
         a1=new Account();
         FirstPageFlag=true;
         LastPageFlag=true;
         NextPageFlag=true;
         PrevPageFlag=true;
         b1=false;
         n2=0;
         currentpage=0;
         pagenumber=1;
    }
    public void submit()
    {
       try
       {
            
            n2 = 0;
            Pageindex=1;
            FirstPageFlag=true;
            LastPageFlag=true;
            NextPageFlag=true;
            PrevPageFlag=true;
            lstAcc=[select id ,name , site,Phone,NumberOfEmployees from Account]; 
            for(Account acc: lstAcc)
                mappingIndex.put(acc.id,++n2);
                
            n1=Integer.valueOf(a1.num1__c);
            TotalPages=lstAcc.size()/(n1);
            if((math.mod(lstAcc.size(),n1)>0))
            {
            TotalPages =TotalPages +1;
            }
            for(Integer j=((PageIndex-1)*n1);j<=((PageIndex*n1)-1);j++)
                {
                 Account obj1= lstAcc [j];   
                 lstAcc1.add(obj1);
                }
             pageinfo='showing page'+pagenumber+'of'+ (math.mod(lstAcc.size(),n1)==0?TotalPages-1:TotalPages);               
          }
     
        catch (MathException e)
         {
            System.debug(e);
        }
       
       // return null;
    
   }
    public void  First()
    {
        Pageindex=1;
         currentpage=0;
         pagenumber=1;
        ListIndex(); 
             if(Pageindex<TotalPages )
             {
              LastPageFlag=true;
              FirstPageFlag=false;
              NextPageFlag=true;
              PrevPageFlag=false;
             }
             if(Pageindex==1)
             {
              LastPageFlag=true;
              FirstPageFlag=true;
              NextPageFlag=true;
              PrevPageFlag=true;
              }
               pageinfo='showing page'+pagenumber+'of'+ (math.mod(lstAcc.size(),n1)==0?TotalPages-1:TotalPages);      
         }
              public void  Last()
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
                currentPage = (Math.mod(lstAcc.size(), n1) == 0) ? lstAcc.size() - n1 : (lstAcc.size() / n1) * n1;
        pageNumber = (Math.mod(lstAcc.size(), n1) == 0 ? TotalPages-1 : TotalPages );
         pageinfo='showing page'+pagenumber+'of'+ (math.mod(lstAcc.size(),n1)==0?TotalPages-1:TotalPages);      
             }
    
        public void Next()
        {
        currentpage=currentpage+n1;
        pagenumber++;
        if(PageIndex<TotalPages)
        {
           PageIndex =PageIndex+1;
           ListIndex();
           FirstPageFlag=false;
           NextPageFlag=true;
           PrevPageFlag=false;
           LastPageFlag=true;
        } 
         if(PageIndex==TotalPages)
         {
             FirstPageFlag=false;
             NextPageFlag=false;
             PrevPageFlag=false;
             LastPageFlag=false;
         }
         pageinfo='showing page'+pagenumber+'of'+ (math.mod(lstAcc.size(),n1)==0?TotalPages-1:TotalPages);  
    }
    
    public void Prev()
    {
        currentpage=currentpage-n1;
        pagenumber--;
        if(PageIndex>1)
        {
          Pageindex--;
          ListIndex();
          FirstPageFlag=false;
          NextPageFlag=true;
          PrevPageFlag=false;
          LastPageFlag=true;
        }
        if(PageIndex==1)
        {
           LastPageFlag=true;
           FirstPageFlag=true;
           NextPageFlag=true;
           PrevPageFlag=true;
        }
        pageinfo='showing page'+pagenumber+'of'+ (math.mod(lstAcc.size(),n1)==0?TotalPages-1:TotalPages);  
     }
    
    public void ListIndex()
    {     
       lstAcc1 = new list<Account>();
         if(PageIndex<TotalPages)
         {
             for(Integer i=((PageIndex-1)*n1);i<=((PageIndex*n1)-1);i++)
                {
                   
                 Account obj= lstAcc [i];  
                 lstAcc1.add(obj);
                }
          }
          else
          {
              if(PageIndex==TotalPages)
              {
                  for(Integer k=((PageIndex-1)*n1);k<=lstAcc.size()-1;k++)
                  {
                      Account obj2=lstAcc[k];
                      
                      lstAcc1.add(obj2);
                  }
              }
          }
    }
    
}