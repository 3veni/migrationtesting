trigger Accounttrigger on Account (after update) {
    set<ID> accId = new Set<ID>();
    Map<ID,String> m = new Map<ID,String>();
    List<Contact> contactslist = new List<Contact>();
    for(Account a:Trigger.new)
    {
      accId.add(a.Id);  
      m.put(a.Id,a.Phone);
    }
    contactslist = [select Id,Phone,Account.Id from Contact where Account.Id =:accId ];
    if(contactslist.size()>0){
        for(Contact c : contactslist){
            //String phone = c.Phone;
         
            c.Phone = m.get(c.Account.Id);
            
        }
        update contactslist;
    } 
    
    

}