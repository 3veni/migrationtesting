trigger ContactTrigger on Contact (after update) {
    Set<Id> accIds = new Set<Id>();
    Map<ID,String> mphones = new Map<ID,String>();
    List<Account> accList = new List<Account>();
    for(Contact c : Trigger.New){
        Contact beforeUpdatePhone = System.Trigger.oldMap.get(c.Id);
        if(beforeUpdatePhone.Phone != c.Phone){
        System.debug('===beforeUpdatePhone====='+beforeUpdatePhone);
        System.debug('===== before AccId======='+c.AccountId);
       accIds.add(c.AccountId); 
        System.debug('===== after AccId======='+accIds.size());
        system.debug('====phone==='+c.Phone);
       mphones.put(c.AccountId,c.Phone); 
        system.debug('===mapsize====='+mphones.size());
    }
    
    accList = [select Id,Phone from Account where Id =: accIds];
    System.debug('===acclist===='+accList.size());
    if(accList.size()>0){
        for(Account a : accList){
            System.debug('===before update===='+a.Phone);
            a.Phone = mphones.get(a.Id);
            System.debug('===after update===='+a.Phone);
        }
        update accList;
    }
    }
}