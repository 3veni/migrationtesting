public class TechReportCalender_cntrl{
   /* public List<SVMXC__Service_Group_Members__c> teList{get;set;}
    public List<SVMXC__Service_Group_Members__c> teeveList{get;set;}
    public List<SVMXC__SVMX_Event__c> eveList{get;set;}*/
    public String slectListitems{get;set;}
    public List<Integer> displayd{get;set;}
   // public List<findisplayd> numdis{get;set;}
    public Map<Integer,String> showmonth{get;set;}
    public String mont{get;set;}
    public Integer mon{get;set;}
    public String mon1{get;set;}
    public Date d{get;set;}
    public Date Dates{get;set;}
    public Date Date1{get;set;}
    public Integer Year{get;set;}
    public String Year1{get;set;}
  //  public Map<String, IDdisplayd> mapBind {get;set;}
   // public Map<String, IDdisplayd1> mapBind1 {get;set;}
    public Integer j{get;set;}
    public Integer numberDays{get;set;}
    public Integer noofdays{get;set;}
    public Integer startday{get;set;}
    public Integer monthmon{get;set;}
    public String Rachika{get;set;}
    
    public TechReportCalender_cntrl(){
        Rachika = 'Hai ';
      //  mapBind = new Map<String, IDdisplayd>();
      //  mapBind1 = new Map<String, IDdisplayd1>();
        d = System.today();
        mon = d.month();
        mon1 = String.ValueOf(mon);
        Year = d.Year();
        Year1 = String.ValueOf(Year);
        Dates = Date.newInstance(Year,mon,1);
        numberDays = date.daysInMonth(year,mon);
        Date1 = Date.newInstance(Year,mon,numberDays);    
        displayd = new List<Integer>();
      //  teeveList = [select id,name,(select id,name,SVMXC__StartDateTime__c,SVMXC__EndDateTime__c from SVMXC__SVMX_Event__r ) from SVMXC__Service_Group_Members__c where SVMXC__Service_Group__r.Name=: slectListitems LIMIT 50000];
        showmonth = new Map<Integer,String>();  
        showmonth.put(1,'January');
        showmonth.put(2,'Febuary');
        showmonth.put(3,'March');
        showmonth.put(4,'April');
        showmonth.put(5,'May');
        showmonth.put(6,'June');
        showmonth.put(7,'July');
        showmonth.put(8,'August');    
        showmonth.put(9,'September');
        showmonth.put(10,'Octobar');
        showmonth.put(11,'November');
        showmonth.put(12,'December');
       // returnDate(); 
    }
    public void previous(){
        if(mon == 1){
            mon = 12;
            mon1 = String.ValueOf(mon);
            year = year - 1;
            Year1 = String.ValueOf(Year);
        }else{
            mon = mon-1;
            mon1 = String.ValueOf(mon);
        }
        displayd.clear();
       // returnDate();
    }
    public void next(){
        if(mon == 12){
            mon = 1;
            mon1 = String.ValueOf(mon);
            year = year + 1;
            Year1 = String.ValueOf(Year);
        }else{
            mon = mon+1;
            mon1 = String.ValueOf(mon);
        }
        
        displayd.clear();
       // returnDate();
    }
  /*  public void returnDate(){
        numdis = new List<findisplayd>();
        numberDays = date.daysInMonth(year,mon);
        teeveList = [select id,name,(select id,name,SVMXC__StartDateTime__c,SVMXC__EndDateTime__c from SVMXC__SVMX_Event__r ) from SVMXC__Service_Group_Members__c where SVMXC__Service_Group__r.Name=: slectListitems LIMIT 50000];    
        mont = showmonth.get(mon);
        for(SVMXC__Service_Group_Members__c s : teeveList){
            for(integer i =1 ;i<=numberDays ;i++){
                displayd.add(i);
                //mapBind.put(s.Name+i+mon+Year, false);
                mapBind.put(s.Name+i+mon+Year, new IDdisplayd(null,false,null,null,null));
                mapBind1.put(s.Name+i+mon+Year, new IDdisplayd1(null,false,null));
            }
        }
        for(integer i =1 ;i<=numberdays ;i++){
            numdis.add(new findisplayd(i));
        }
        getlistofeve();
    }
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--None--','--None--'));
        List<SVMXC__Service_Group__c> TeamList = [select id,Name from SVMXC__Service_Group__c];
        for(SVMXC__Service_Group__c wt : TeamList){
            options.add(new SelectOption(wt.Name,wt.Name));
        }
        return options;
    }
    public void dobuttonaction(){
        teeveList = [select id,name,(select id,name,SVMXC__StartDateTime__c,SVMXC__EndDateTime__c from SVMXC__SVMX_Event__r) from SVMXC__Service_Group_Members__c where SVMXC__Service_Group__r.Name=: slectListitems LIMIT 50000];    
        returnDate();
    }
    public List<SVMXC__SVMX_Event__c> listlist{get;set;}
    public List<wrapp> wrapList{get;set;}
    public integer endmon{get;set;}
    public List<wrapp> getlistofeve(){
        wrapList = new List<wrapp>();
        if(teeveList != null)
        for(SVMXC__Service_Group_Members__c gm : teeveList){
            listlist = new List<SVMXC__SVMX_Event__c>();
            for(SVMXC__SVMX_Event__c se : gm.SVMXC__SVMX_Event__r){
                if(se.SVMXC__StartDateTime__c != null && se.SVMXC__EndDateTime__c != null){
                    if(se.SVMXC__StartDateTime__c.month() == se.SVMXC__EndDateTime__c.month()){
                    for(j = se.SVMXC__StartDateTime__c.day(); j <= se.SVMXC__EndDateTime__c.day() ; j++){
                        if(mapBind.containsKey(gm.Name+j+se.SVMXC__StartDateTime__c.month()+se.SVMXC__StartDateTime__c.year())){
                            if(j ==se.SVMXC__StartDateTime__c.day() )
                                mapBind.put(gm.Name+j+se.SVMXC__StartDateTime__c.month()+se.SVMXC__StartDateTime__c.year(),new IDdisplayd(se.Name,true,se.id,j,null)) ;
                            else
                                mapBind1.put(gm.Name+j+se.SVMXC__StartDateTime__c.month()+se.SVMXC__StartDateTime__c.year(),new IDdisplayd1(se.Name,true,j)) ;
                        }
                    }
                }else{
                    noofDays = date.daysInMonth(se.SVMXC__StartDateTime__c.year(),se.SVMXC__StartDateTime__c.month());
                    startday = se.SVMXC__StartDateTime__c.day();
                    monthmon = se.SVMXC__StartDateTime__c.month();
                    endmon = se.SVMXC__EndDateTime__c.month();
                            for(integer i = se.SVMXC__StartDateTime__c.month(); i <= endmon ; i++){
                            for(integer j = startday ; j<= noofDays ; j++){
                                if(j == se.SVMXC__StartDateTime__c.day() && i == se.SVMXC__StartDateTime__c.month())
                                mapBind.put(gm.Name+j+monthmon+se.SVMXC__StartDateTime__c.year(),new IDdisplayd(se.Name,true,se.id,j,i)) ;
                                else
                                mapBind1.put(gm.Name+j+monthmon+se.SVMXC__StartDateTime__c.year(),new IDdisplayd1(se.Name,true,j)) ;
                                if(j == noofdays){
                                    startday = 1;
                                    if(i == endmon-1)
                                    noofdays = se.SVMXC__EndDateTime__c.day();    
                                    monthmon =monthmon + 1;
                                }
                            }
                        }
                    }
                    
               }
                listlist.add(se); 
            }
            wrapList.add(new wrapp(gm,listlist));    
        }
       return wrapList;
    }
    public class wrapp{
        public SVMXC__Service_Group_Members__c tech{get;set;}
        public List<SVMXC__SVMX_Event__c> smEvent{get;set;}
        public wrapp(SVMXC__Service_Group_Members__c t,List<SVMXC__SVMX_Event__c> e){
            tech = t;
            smEvent = e;
        }    
    }
    public Class findisplayd{
        public Integer parDay{get; set;}
        public String parDay1{get; set;}
        public findisplayd(Integer PD){
            this.parDay = PD;
            parDay1 = String.ValueOf(PD);
        }
    }
    public Class IDdisplayd{
        public Boolean flag{get; set;}
        public String SMEventId{get; set;}
        public Id SMId{get; set;}
        public integer start{get;set;}
        public integer startmon{get;set;}
        public IDdisplayd(String sid,Boolean f,Id a,integer sd,integer sm){
            SMEventId = sid;
            flag = f;
            SMId = a;
            start = sd;
            startmon = sm;
        }
    }
    public Class IDdisplayd1{
        public String SMEventId{get; set;}
        public Boolean flag{get; set;}
        public Id SMId{get; set;}
        public integer start{get;set;}
        public IDdisplayd1(String sid,Boolean f,integer sd){
            SMEventId = sid;
            flag = f;
            start = sd;
        }
    }*/
}