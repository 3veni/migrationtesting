public class applyleavectrl {
    public string eid{get;set;}
    public boolean showapply{get;set;}
    public list<Employee__c>elist{get;set;}
    public string selectpick{get;set;}
    public Com_Leave_info__c leave{get;set;}
    public Com_Leave_info__c leavelist{get;set;}
    public list<Com_Leave_info__c> leavelist1{get;set;}
    public Employee__c emp{get;set;}
    public integer count{get;set;}
    public string ermsg{get;set;}
    public decimal countofleaves{get;set;}
    public applyleavectrl()
    {
        elist=new list<Employee__C>();
        elist=[select id,Com_Employee_id__c from Employee__c];
        showapply=false;
        count=0;
        leave=new Com_Leave_info__c();
        
    }
     public void ok()
    {
        system.debug('employeeid'+eid);
            for(Employee__c e:elist)
            {
                if(e.Com_Employee_id__c==eid)
                {                   
                   count=1; 
                }                           
            }
            if(count!=1)
            {
           ermsg='Please enter valid id';            }
            else{
                showapply=true;
                emp=[select id,Com_First_Name__c,Com_Last_Name__c,Com_Balance_Leaves__c,Com_Employee_id__c,Com_LOP_leaves__c from Employee__c where Com_Employee_id__c=:eid];
                countofleaves=emp.Com_LOP_leaves__c;
            }
            system.debug('to date'+countofleaves);

    }
    

    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        if(emp.Com_Balance_Leaves__c!=null)
        {
        options.add(new SelectOption('Paid Leave','Paid leave'));
        }
        options.add(new SelectOption('Loss Of Pay leave','Loss Of Pay leave'));
                       return options;
               
    }
    public pagereference addleave()
    {
         list<Com_Leave_info__c> leavelist2=new list<Com_Leave_info__c>();
        for(integer i=1;i<10;i++){
          Com_Leave_info__c leavelist = new Com_Leave_info__c();
            leavelist.Com_From_Date__c=leave.Com_From_Date__c;
            leavelist.Com_To_Date__c=leave.Com_To_Date__c;
            leavelist.Com_Employee_id__c=eid;
            leavelist.Com_Leave_Type__c=selectpick;
            if(selectpick=='Loss Of Pay leave')
            {
           countofleaves++;
            }
            system.debug('from date'+leave.Com_From_Date__c);
           system.debug('to date'+leave.Com_To_Date__c);
            
             system.debug('leave type'+selectpick);
            emp.Com_LOP_leaves__c=countofleaves;
            leavelist2.add(leavelist);
        }
        insert leavelist2;
       // update emp;
        leavelist1=new list<Com_Leave_info__c>();
        leavelist1=[select id,Com_To_Date__c,Com_From_Date__c,Com_Leave_Type__c,Com_Employee_id__c from Com_Leave_info__c where com_Employee_id__c=:eid];
        return null;
    
    }
   }