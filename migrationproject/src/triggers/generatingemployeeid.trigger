trigger generatingemployeeid on Employee__c (before update) {
for(Employee__c c:trigger.new)
{
    c.Com_Employee_id__c=c.Com_First_Name__c.substring(0,1).touppercase()+c.Com_Last_Name__c.substring(0,1).touppercase()+c.Name.substringafter('-');

}
}