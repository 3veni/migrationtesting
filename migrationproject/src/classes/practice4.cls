public class practice4 {
    public String objname { get; set; }
    public List<myclass> innervar{get;set;}
    public boolean show{get;set;}
    public practice4 (){
        show=true;
        innervar=new List<myclass>();
    }
    public class myclass{
        public Id str1{get;set;}
        public String str2{get;set;}
        public myclass(ID id,String name){
            str1=id;
            str2=name;
        }
    }
    public void search() {
        try{
            Schema.SObjectType t  = Schema.getGlobalDescribe().get(objname);
            if(t!=null){
                show=true;
                String SOQL = 'SELECT id,Name FROM ' + t;
                for (List<SObject> sobjs : Database.query(SOQL)) {
                    for (SObject sobj : sobjs) {
                        innervar.add(new myclass(sobj.id,String.valueOf(sobj.get('name'))));
                    }
                }
            }
            else{
                show=false;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,' Please Enter Existing Object Name!'));
            }
        }
        catch(Exception e){
        }
    }
}