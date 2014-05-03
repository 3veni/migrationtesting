//class for displaying contacts with edit and delete button ,when edit clicked perticular record should be displayed in input mode with save and cancel buttons
public class Editing_contacs_and_savingctrl {
public list<Account> alist{get;set;}
public string accid{get;set;}
public string acid{get;set;}
public Editing_contacs_and_savingctrl() {
acc();
}
public void acc(){
 alist =[select id,name from account limit 20];
}
public pagereference editacc(){
system.debug('account id***********'+accid);
acid =accid;
return null;
}

}