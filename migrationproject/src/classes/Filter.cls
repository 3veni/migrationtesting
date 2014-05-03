public class Filter
{
public list<Account> obj {get;set;}

public string s1{get;set;}
public Filter()
{
obj=new list<Account>();
}
public pagereference Go()
{
if(s1!=null)
{
obj=[select id,name from Account where name like:s1+'%'];
}
return null;
}
}