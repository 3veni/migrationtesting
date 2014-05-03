trigger HelloWorld1 on Position__c (before insert, before update) {
Position__c[] positions = Trigger.new;

HelloWorldClass.helloWorld(positions);

}