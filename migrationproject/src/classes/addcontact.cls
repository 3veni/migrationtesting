public class addcontact {
public id aid{get;set;}
public boolean flag{get;set;}
public string err{get;set;}
public contact con{get;set;}
public contact co{get;set;}
 public addcontact(){
  aid=apexpages.currentpage().getparameters().get('id');
  con=new contact();
 }
 public pagereference addcon(){
   system.debug(con.phone);                                                    // [a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}'
 //co.phone=con.phone;
   // Boolean flag = false;                                                   //^[7-9]{1}[0-9]{9}
    if(Pattern.matches('[0-9]{10}', con.step1__c))
                {
                    err='valid ';               }
                else
                {
                    err='not valid' ;               }
                  return null;
      }

 
 
}