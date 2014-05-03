trigger ETAworkforceNotificationCreateCase on Case (after insert, before update, after update, before delete)
 {
     if(TOA.ETAworkforceController.fromETAdirect(Trigger.new))
     {
/* //Additional mapping example
       if(Trigger.isBefore && !Trigger.isDelete)
       {
         for(Case CaseObj:Trigger.new)
         {
            if(CaseObj.Status=='pending')
               CaseObj.Status='Not Started';
         }
       }
*/
/* //Delete object example
       if(Trigger.isAfter && Trigger.isUpdate)
       {
         List<Case> objectsForDeleting=new List<Case>();
         for(Case CaseObj:Trigger.new)
         {
            if(CaseObj.Status=='Cancelled')
                objectsForDeleting.add(new Case(Id=CaseObj.Id));
         }
         if(objectsForDeleting.size()!=0)
            delete objectsForDeleting;
       }
*/
       return;
     }
     if(Trigger.isBefore && !Trigger.isDelete) return;

     Map<Id,Case> CaseMap=(Trigger.isDelete?Trigger.oldMap:Trigger.newMap);
     Set<Id> CaseIds=CaseMap.keySet();
     TOA.ETAworkforceController ctrl=new TOA.ETAworkforceController();
     List<Case> CaseList = Database.query( 'select '+ctrl.getClientObjectFieldList('Case',
        // Add your fileds set HERE. For example:
        // new Set<String>{'Who.Type','ActivityDate'}
        null
        )+' from Case where Id in :CaseIds' );

     List<TOA__ETAworkforceNotification__c> notifs = new List<TOA__ETAworkforceNotification__c>();
     for (Case obj : CaseList) {
         try{
             Case oldObj;
             if(Trigger.oldMap!=null)
                 oldObj=Trigger.oldMap.get(obj.Id);
             TOA__ETAworkforceNotification__c newNotif= new TOA__ETAworkforceNotification__c();
             if(ctrl.mapSimpleFieldsOut(obj,oldObj,newNotif))
             {
                 if(newNotif.TOA__command_type__c==null && Trigger.isDelete)
                    newNotif.TOA__command_type__c = 'delete_activity';

                 if(System.isBatch())
                     newNotif.TOA__NotificationMethod__c='Disable';

                 // Add your fields mapping HERE

                 notifs.add(newNotif);
             }
             }
             catch(Exception exc)
             {
                 CaseMap.get(obj.Id).addError(exc.getMessage());
                 ctrl.setParentObjectMessage(obj.Id,null,obj.LastModifiedById,obj.Id,
                    'ETAworkforce error: Can\'t create notification',exc.getMessage());
             }
         }
     Database.SaveResult[] result=Database.insert(notifs,false);
     System.assertEquals(result.size(),notifs.size());
     for(Integer i=0,size=result.size();i<size;++i)
     {
         if(result[i].isSuccess()) continue;
         TOA__ETAworkforceNotification__c notif=notifs[i];
         CaseMap.get(notif.TOA__ObjectId__c).addError(result[i].getErrors()[0].getMessage());
         ctrl.setParentObjectMessage(
             notif.TOA__ObjectId__c,notif.Id,notif.LastModifiedById, notif.TOA__ObjectName__c,
             'ETAworkforce error: Can\'t insert notification',result[i].getErrors()[0].getMessage());
     }
     ctrl.putChangedObjects();
 }