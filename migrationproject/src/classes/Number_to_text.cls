//Apex code for converting number to text for example 234 sholud be converted to Twohundred thirty four rupees
public with sharing class Number_to_text{
public list<Account> alist{get;set;}
public Map<integer,string> lessthan20 =  new Map<integer,string>{1=>'One',2=>'Two',3=>'Three',4=>'Four',5=>'Five',6=>'Six',7=>'Seven',8=>'Eight',9=>'Nine',11=>'Eleven',12=>'Twelve',13=>'Thirteen',14=>'Fourteen',15=>'Fifteen',16=>'Sixteen',17=>'Seventeen',18=>'Eighteen',19=>'Ninteen'};
public Map<integer,string> tens = new Map<integer,string>{20=>'Twenty',30=>'Thirty',40=>'Fourty',50=>'Fifty',60=>'Sixty',70=>'Seventy',80=>'Eighty',90=>'Ninenty'};
public set<id> aid{get;set;}
public Number_to_text( ){
}
public  void accountrevenue(account[] acc){
 for(account a:acc){
  string word =' ';
  integer dec = integer.valueOf(a.AnnualRevenue);
  integer Rem;
  integer rem100;
  integer modval;
     if(a.AnnualRevenue!=null){
         if(lessthan20.containsKey(integer.valueOf(a.Annualrevenue))){
          a.AnnualRevenue_In_Words__c= lessthan20.get(integer.valueOf(a.Annualrevenue))+'Rupees';
         }
         else{
           if(a.AnnualRevenue >=20){
              rem = dec/10*10;
              modval=math.mod(dec,10);
              if(a.AnnualRevenue >100 && a.AnnualRevenue<1000){
                  a.AnnualRevenue_In_Words__c =threedigits(integer.valueOf(a.AnnualRevenue))+'Rupees';
              }
              else if(a.AnnualRevenue >1000 && a.AnnualRevenue<1000000){
                   rem =dec/1000;
                   modval = math.mod(dec,1000);
                   if(rem >99)
                   a.AnnualRevenue_In_Words__c= threedigits(rem)+ 'thousand'+threedigits(modval)+'rupees';
                   else
                   a.AnnualRevenue_In_Words__c= twodigits(rem)+ 'thousand'+threedigits(modval)+'rupees';
               }
               else{
                   if(a.AnnualRevenue >1000000 && a.AnnualRevenue<1000000000){
                       rem =dec/1000000;
                       modval = math.mod(dec,1000000);
                       integer modval1 =modval/1000;
                       integer rem1 =math.mod(modval,1000);
                       if(rem >99)
                       a.AnnualRevenue_In_Words__c= threedigits(rem)+ 'million'+threedigits(modval1)+'thousand'+threedigits(rem1)+'rupees';
                       else
                       a.AnnualRevenue_In_Words__c= twodigits(rem)+ 'million'+threedigits(modval1)+'thousand'+threedigits(rem1)+'rupees';
                   }
                  else{
                  a.AnnualRevenue_In_Words__c =tens.get(rem)+lessthan20.get(modval)+'Rupees';
                  }
              }
           }  
         }
      }
   }
}
//function used for converting two digits number into word
 public string twodigits( integer i){
 integer rem;
 integer modval;
 string twodig =' ';
  rem = i/10*10;
  modval=math.mod(i,10);
  if(i>19){
     twodig =tens.get(rem)+lessthan20.get(modval);
  }
  else{
     twodig =lessthan20.get(i);
  }
 return twodig;
 }
 //Function used for converting three digits number into word
 public string threedigits(integer j){
 integer rem;
 integer modval;
 string threedig =' ';
 string two =' ';
 rem = j/100;
  modval=math.mod(j,100);
 if(modval >=20)
 {
     two =twodigits(modval);
 }
 else{
     two =lessthan20.get(modval);
 }
 system.debug('******remainder****'+rem);
 threedig =lessthan20.get(rem)+'Hundred'+two;
 return threedig;
 }

}