public class accountctrl {
public list<account> alist{get;set;}
 public accountctrl()
 {
 alist=[select id,name,phone from account where id=:apexpages.currentpage().getparameters().get('id')];
 }
}