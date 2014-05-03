trigger ETAworkforceNotificationCreate<objectTypeLabel> on <objectType> (after insert, before update, after update, before delete)
 {
     if(TOA.ETAworkforceController.fromETAdirect(Trigger.new))
     {
/* //Additional mapping example
       if(Trigger.isBefore && !Trigger.isDelete)
       {
         for(<objectType> <objectTypeLabel>Obj:Trigger.new)
         {
            if(<objectTypeLabel>Obj.Status=='pending')
               <objectTypeLabel>Obj.Status='Not Started';
         }
       }
*/
/* //Delete object example
       if(Trigger.isAfter && Trigger.isUpdate)
       {
         List<<objectType>> objectsForDeleting=new List<<objectType>>();
         for(<objectType> <objectTypeLabel>Obj:Trigger.new)
         {
            if(<objectTypeLabel>Obj.Status=='Cancelled')
                objectsForDeleting.add(new <objectType>(Id=<objectTypeLabel>Obj.Id));
         }
         if(objectsForDeleting.size()!=0)
            delete objectsForDeleting;
       }
*/
       return;
     }
     if(Trigger.isBefore && !Trigger.isDelete) return;

     Map<Id,<objectType>> <objectTypeLabel>Map=(Trigger.isDelete?Trigger.oldMap:Trigger.newMap);
     Set<Id> <objectTypeLabel>Ids=<objectTypeLabel>Map.keySet();
     TOA.ETAworkforceController ctrl=new TOA.ETAworkforceController();
     List<<objectType>> <objectTypeLabel>List = Database.query( 'select '+ctrl.getClientObjectFieldList('<objectType>',
        // Add your fileds set HERE. For example:
        // new Set<String>{'Who.Type','ActivityDate'}
        null
        )+' from <objectType> where Id in :<objectTypeLabel>Ids' );

     List<TOA__ETAworkforceNotification__c> notifs = new List<TOA__ETAworkforceNotification__c>();
     for (<objectType> obj : <objectTypeLabel>List) {
         try{
             <objectType> oldObj;
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
                 <objectTypeLabel>Map.get(obj.Id).addError(exc.getMessage());
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
         <objectTypeLabel>Map.get(notif.TOA__ObjectId__c).addError(result[i].getErrors()[0].getMessage());
         ctrl.setParentObjectMessage(
             notif.TOA__ObjectId__c,notif.Id,notif.LastModifiedById, notif.TOA__ObjectName__c,
             'ETAworkforce error: Can\'t insert notification',result[i].getErrors()[0].getMessage());
     }
     ctrl.putChangedObjects();
 }