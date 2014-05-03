trigger Counttrigger on Contact(after insert,after update,before delete)
{
   
    set<id> accid=new set<id>();
   
    for(Contact c:trigger.new)
      {
          contact co =system.trigger.oldMap.get(c.accountid);
          if(c.accountid !=co.id)
             {
        accid.add(c.accountid);
             }
       }
    list<account> acclst=[select id,Number_of_contacts__c, (select contact.id from contacts) from account where id=:accid];
    for(account a:acclst)
       {
       a.Number_of_contacts__c  =a.contacts.size();
        }
    update acclst;
}