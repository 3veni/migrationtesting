public class numbertotextcls {
public string num{get;set;}
public string numtext{get;set;}
public integer numsize{get;set;}
public list<string> numlist{get;set;}
    public numbertotextcls(){
    }
    public pagereference ok(){
    string[] numlist = new List<string>();
     numsize =num.length();
     if(numsize == 0)
     {
      ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Invalid Input.');
            ApexPages.addMessage(myMsg);
     }
     system.debug('*************'+numsize);
     for(integer i=0;i<numsize;i++)
     {
      numlist.add(num.substring(i,i+1));
       system.debug('******numlist*******'+numlist[i]);   
     }
         return null;
    }
 }