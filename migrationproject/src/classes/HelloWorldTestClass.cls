@isTest
public class HelloWorldTestClass {
    
    static testMethod void helloWorldTest(){
        List<Position__c> positions = new List<Position__c>();
        for (Integer i=0; i < 20; i++){
            Position__c p = new Position__c();
//          p.Name = 'testName' + i;
            p.Job_Description__c = 'testDescription' + i;
            positions.add(p);
        }
        
        try{
            System.debug('Attempting to insert positions');
            insert positions;
            System.debug('Insert complete');
            // refresh the Position list to include the Hello__c field after the insert
            Map<ID,Position__c> positionMap = new Map<ID,Position__c>(positions);
            positions = [select id,name,Hello__c from Position__c where id IN :positionMap.keySet()];
            for (Position__c position:positions){
                System.assertNotEquals(position.id,null);
                System.assertEquals(position.Hello__c, 'World');
                System.debug('position.id=' + position.id);
                System.debug('position.name=' + position.name);
                System.debug('position.Hello__c=' + position.Hello__c);
            }
        } catch (System.DmlException e){
            System.debug('We caught a DML exception: ' + e.getDmlMessage(0));   
        }
        
    }
    
}