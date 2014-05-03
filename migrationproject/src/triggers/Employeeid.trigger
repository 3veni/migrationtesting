trigger Employeeid on Com_Employee__c (after insert) {
for(Com_Employee__c c:trigger.new)
{
    c.Employee_id__c=c.First_Name__c.substring(0,1).touppercase()+c.Com_Last_Name__c.substring(0,1).touppercase()+c.Name.substringafter('-');

}
}