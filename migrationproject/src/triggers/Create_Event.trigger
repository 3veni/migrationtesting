trigger Create_Event on Work_Order__c (after insert,after update) {
      Work_Order_Event__c wo = new   Work_Order_Event__c();
    for(Work_Order__c w:trigger.new){
       
        if(w.Technician__c != null){
            wo.What_Id__c =w.id;
            wo.Whomid__c = w.Technician__c ;
            wo.Start_Date__c =w.Start_Date__c;
            wo.End_Date__c = w.End_Date__c;
        }
    }
    insert wo;
}