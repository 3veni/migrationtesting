public with sharing class Pagination_Controller 
{
    public List<Account> lstAccounts    {get;set;}
    
    // for pagination
    public Integer pageSize {get;set;}
    public Integer currentPage  {get;set;}
    public String currentPageInfo   {get;set;}
    
    // for disabling pagination links
    public Boolean showPrevious {get;set;}
    public Boolean showNext {get;set;}
    
    private Integer totalRecords;
    private Integer pageNumber;
    
    public Pagination_Controller()
    {
        lstAccounts = [Select Name, Phone From Account limit 23];
        currentPage = 0;
        pageSize = 5;
        pageNumber = 1;
        showPrevious = false;
        totalRecords = lstAccounts.size();
        if(totalRecords > pageSize)
            showNext = true;
        else
            showNext = false;
       // currentPageInfo = 'Showing Page ' + pageNumber +   ' of ' + (Math.mod(totalRecords, pageSize) == 0 ? totalRecords/pageSize : (totalRecords/pageSize) + 1); 
    }
    
    public void showPrevious()
    {
        currentPage = currentPage - pageSize;
        pageNumber--;
        enableDisablePaginationLinks();     
    }
    
    public void showNext()
    {
        currentPage = currentPage + pageSize;
        pageNumber++;
        enableDisablePaginationLinks();
    }
    
    public void showFirst()
    {
        currentPage = 0;
        pageNumber = 1;
        enableDisablePaginationLinks();
    }
    
    public void showLast()
    {
        currentPage = (Math.mod(totalRecords, pageSize) == 0) ? totalRecords - pageSize : (totalRecords / pageSize) * pageSize;
        pageNumber = (Math.mod(totalRecords, pageSize) == 0 ? totalRecords/pageSize : (totalRecords/pageSize) + 1);
        enableDisablePaginationLinks();
    }
    
    private void enableDisablePaginationLinks()
    {
        if(currentPage == 0)
            showPrevious = false;
        else
            showPrevious = true;
        
        if((totalRecords - pageSize) <= currentPage)
            showNext = false;
        else
            showNext = true;
        
       // currentPageInfo = 'Showing Page ' + pageNumber +   ' of ' + (Math.mod(totalRecords, pageSize) == 0 ? totalRecords/pageSize : (totalRecords/pageSize) + 1);
    }
}