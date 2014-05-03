public class drag_drop_technician_workorderctrl {
public list<Account> alist{get;set;}
public string id{get;set;}
public list<Contact> clist{get;set;}
public string myProperty {get; set;}
public drag_drop_technician_workorderctrl (){
accounts_and_contacts();

 mymethod();
}
public void accounts_and_contacts(){
    alist =[select id,name,(select id,name from contacts) from account];
    clist = [select id,name,accountid from contact];
}
 public void myTest() {
   
  }
  public pagereference mymethod(){
   System.debug('VARIABLE MYPROPERTY------' + id);
  return null;
  }
}