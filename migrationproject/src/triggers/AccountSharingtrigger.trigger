trigger AccountSharingtrigger on Account (after insert,after update,after delete) {
     if(trigger.isinsert)
    {
        list<AccountShare> accshare=new list<AccountShare>();
        AccountShare MarketingManager;
        for(Account a:trigger.new)
        {
            MarketingManager=new AccountShare();
            MarketingManager.AccountId=a.id;
            MarketingManager.UserOrGroupId=a.MarketingManager__c;
            MarketingManager.AccountAccessLevel='read';
            MarketingManager.OpportunityAccessLevel='read';
            accshare.add(MarketingManager);
        }
        insert accshare;
    }
    if(trigger.isupdate)
    {
     for(Account a:trigger.new)
     {
         list<AccountShare> acc;
         for(Account c:trigger.old)
         {
            
           list<AccountShare> accshare=new list<AccountShare>();
           AccountShare MarketingManager;
            if(a.MarketingManager__c!=c.MarketingManager__c)
             {
              acc=[select id,Accountid from AccountShare where Accountid=:c.id];   
             MarketingManager=new AccountShare();
            MarketingManager.AccountId=a.id;
            MarketingManager.UserOrGroupId=a.MarketingManager__c;
            MarketingManager.AccountAccessLevel='read';
            MarketingManager.OpportunityAccessLevel='read';
            accshare.add(MarketingManager);
             }
             delete acc;
             insert accshare;
             
         }
     }
   }
    if(trigger.isdelete)
    {
        list<Account> a=[select id from account where id=:trigger.new];
        delete a;
    }
    

}