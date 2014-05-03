public class Examplet_Cntrl {

    public String row { get; set; }

    public Account Acc{get;set;}
    public String AccId{get;set;}
    public List<Account> Table{get;set;}
    public Boolean flag{get;set;}
    public String AccountID{get;set;}
    public String AcId{get;set;}
    
    public Examplet_Cntrl(){
        flag = false;
        AccId = ApexPages.currentPage().getParameters().get('Id');
        System.debug('***Acc ID***'+AccId);
        if(AccID != null){
            Acc = [select id,Name,Rating  from Account where id =: Accid];
                if(Acc.Rating == 'Warm'){
                    flag = true;
                }
        }
        Table = [select id,Name,site,AnnualRevenue,Industry from Account];
    }
    public void ActionPollar(){
        Table = [select id,Name,site,AnnualRevenue,Industry from Account];
    }
    
    public PageReference saveAccount(){
        update Acc;
        //return null;
        return new Pagereference('/'+Accid);
    }
    
}