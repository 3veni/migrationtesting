//trigger for displaying Accounts Annual Revenue in words
trigger Annual_Revenue_In_Words on Account (before insert,before update) {
Number_to_text n = new Number_to_text();
Account[] acc= trigger.new;
     n.accountrevenue(acc);
}