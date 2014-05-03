public class DynamicAccountFieldsLister {
public boolean show{get;set;}
public account a{get;set;}
    public DynamicAccountFieldsLister(ApexPages.StandardController controller) { 
        controller.addFields(editableFields);
        show=false;
    }

    public List<String> editableFields {
        get {
            if (editableFields == null) {
                editableFields = new List<String>();
                
            }
            return editableFields ;
        }
        private set;
    }
    public pagereference re()
    {
    show=true;
       editableFields.add('BillingCity'); 
       editableFields.add('Phone');
            return null;
    }
}