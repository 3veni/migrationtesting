public with sharing class AccountWrapperList {

    public list<Wrap> lstWrap {get;set;} //declaration of wraper list
    
    //constructor for Wrapper data preparation
    public AccountWrapperList(){
        list<Account > lstAcc = [select id,name from Account ];
        lstWrap = new list<Wrap>();
        for(Account objAccount : lstAcc ){
            Wrap objwrap = new Wrap();
            objwrap.index = lstWrap.size();
            objWrap.objAcc = objAccount;
            objWrap.isEdit = false;
            lstWrap.add(objWrap);
        }
    }
    
    
    public integer editIndex{get;set;} //identifies which record is edited
    public void DoEdit(){
        system.debug('editIndex::'+editIndex);
        Wrap objWrapEdit = lstWrap[editIndex];
        objWrapEdit.isEdit = true;
    }
    
    public void Save(){
         Wrap objWrapEdit2 = lstWrap[editIndex];
         objWrapEdit2.isEdit = false;
         update objWrapEdit2.objAcc;             
    
    }
    
    
    public void Cancel(){
        
         Wrap objWrapEdit1 = lstWrap[editIndex];
         objWrapEdit1.isEdit = false;
    }
    
    //declaration of wraper
    public class Wrap{
        public integer index{get;set;}
        public Account objAcc{get;set;}
        public boolean isEdit{get;set;}

    }
}