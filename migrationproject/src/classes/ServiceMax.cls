public class ServiceMax{
    Public List<Technician__C> TechList{get;set;}
    Public List<Work_Order__c> WorkList{get;set;}
    public Work_Order_Event__c  woevent {get;set;}
    public Work_Order_Event__c  woevent1 {get;set;}
    public Work_Order__c WO{get;set;}
    public Technician__c Tech{get;set;}
    public contact con{get;set;}
    public map<string,string> mapMonth{get;set;}
    public Boolean includeMyEvents {get;set;}
    public String TechName{get;set;}
    public string WOId{get;set;}
    public String startDate{get;set;}
    public String endDate{get;set;}
    public string extendeddays{get;set;}
    public string weid{get;set;}
    public string woeid{get;set;}
    public string moveddays{get;set;}
    public list<calEvent> events {get;set;}
    Public ServiceMax(){
        TechList= [select id,name From Technician__C  where name != null order by name ];
        WorkList= [select id,name,Technician__c,Start_Date__c,End_Date__c,Technician__r.name  from Work_Order__c order by Id ];
        includeMyEvents = true;
        mapMonth = new Map<string,string>{'Jan'=>'1','Feb'=>'2','Mar'=>'3','Apr'=>'4'};
    }
    public PageReference pageLoad() {
        events = new list<calEvent>();
        //Get Contact's Birthdays
        /* 
        for(Technician__c tech: [select Id,  name from Technician__c ){
            //here we need to replace the birth year with the current year so that it will show up on this years calendar
            DateTime startDT = datetime.newInstance(Date.Today().Year(),tech.DateOfBirth__c.Month(), tech.DateOfBirth__c.Day());
            calEvent bday = new calEvent();
            bday.title = tech.name + '\'s Birthday!';
            bday.allDay = true;
            bday.startString = String.valueof(startDT);
            //Because this is an all day event that only spans one day, we can leave the send date null
            bday.endString = '';
            bday.url = '/' + tech.Id;
            bday.className = 'event-birthday';
            events.add(bday);
        }*/
        //Get my Events if we have selected the correct option
         for(Work_Order_Event__c evnt: [select Id, Start_Date__c, End_Date__c, WhomId__r.name,What_Id__r.name,name from Work_Order_Event__c ]){
                DateTime startDT = evnt.Start_Date__c;
                DateTime endDT = evnt.End_Date__c;
                calEvent myEvent = new calEvent();
                myEvent.title = evnt.name;
                myEvent.allDay = true;
                myEvent.startString = String.valueof(startDT );//(dtFormat);
                myEvent.endString = String.valueof(endDT);    //.format(dtFormat);
                myEvent.url = '/' + evnt.Id;
                myEvent.className = 'event-personal';
                events.add(myEvent);
        }
        return null;
    }
    //Class to hold calendar event data
    public class calEvent{
        public String title {get;set;}
        public Boolean allDay {get;set;}
        public String startString {get;private set;}
        public String endString {get;private set;}
        public String url {get;set;}
        public String className {get;set;}
    }
    public pagereference calfromJQuery(){
        String SubStartDate,SubEndDate,ParseStartDate,ParseEndDate;
        SubStartDate = startDate.subString(4,15);
        SubEndDate = endDate.subString(4,15);
        ParseStartDate = mapMonth.get(SubStartDate .subString(0,3))+'/'+SubStartDate.subString(4,6)+'/'+SubStartDate.subString(7,11);
        ParseEndDate = mapMonth.get(SubEndDate .subString(0,3))+'/'+SubEndDate .subString(4,6)+'/'+SubEndDate .subString(7,11);
      // system.debug('----------start Date--------------'+startDate );
        woevent = new Work_Order_Event__c ();
        try{
             WO = [select id,name,Technician__c ,Start_Date__c,End_Date__c,Technician__r.name From Work_Order__c where Name=:WOId];
             Tech = [select id,name From Technician__c where name =:techName];
             WO.Technician__c = Tech.Id;
            
             system.debug('----------workorder start Date--------------'+  wo.Start_Date__c);
             
              system.debug('----------workorder end Date--------------'+ wo.End_Date__c);
             update WO;
             system.debug('***********work order updated***************'+wo);
             //woevent = [select Id, Start_Date__c, End_Date__c, WhomId__c,What_Id__c from Work_Order_Event__c  where WhomId__c=:Tech.Id and What_Id__c=:WO.Id limit 1];
             woevent.Start_Date__c = date.parse(ParseStartDate);
             woevent.End_Date__c = date.parse(ParseEndDate);
             woevent.WhomId__c = Tech.Id;
             woevent.What_Id__c = WO.Id;
             insert  woevent;
             system.debug('*********workorder event******'+woevent);
           }
            catch(Exception e){
                  system.debug('-------------Exception----------------'+e);
              }
         return null;
    }
    public pagereference resizingevent(){
         PageReference pageRef = ApexPages.currentPage();
         woevent = new Work_Order_Event__c ();
         try{
             woevent = [select Id, Start_Date__c, End_Date__c, WhomId__c,What_Id__c from Work_Order_Event__c  where name=:weid];
             system.debug('***********extendeddays************'+extendeddays);
             woevent.End_Date__c= woevent.End_Date__c.addDays(Integer.valueOf(extendeddays));
             update woevent;
             system.debug('***********extended************'+woevent);
         }
         catch(Exception e){
                  system.debug('-------------Exception----------------'+e);
              }
              return pageRef;
    }
     public PageReference replacingevent() {
          PageReference pageRef = ApexPages.currentPage();
         woevent = new Work_Order_Event__c ();
         try{
             woevent = [select Id, Start_Date__c, End_Date__c, WhomId__c,What_Id__c from Work_Order_Event__c  where name=:woeid];
            // system.debug('***********extendeddays************'+extendeddays);
              woevent.Start_Date__c= woevent.Start_Date__c.addDays(Integer.valueOf(moveddays));
             woevent.End_Date__c= woevent.End_Date__c.addDays(Integer.valueOf(moveddays));
             update woevent;
             system.debug('***********extended************'+woevent);
         }
         catch(Exception e){
                  system.debug('-------------Exception----------------'+e);
              }
              return pageRef;
    
    }
}