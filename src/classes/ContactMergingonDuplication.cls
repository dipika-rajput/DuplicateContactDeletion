//------------------------------------------------------------------------------------------//
//This batch is used for merging duplicate contact records with recent contact by deleting 	//
//previous records																			//
																							//
//Author :- Dipika Rajput                                 Date :- 24/1/2017 				//
//--------------------------------------------------------------------------------------------
global class ContactMergingonDuplication implements Database.Batchable<sObject> { 

  String query;
  global Database.querylocator start(Database.BatchableContext BC)
     {
       //System.debug('inside start');
       
        query = 'Select id,Name,Email,Phone,Birthdate,Department,Description,Fax,Title,LastModifiedDate from Contact ORDER BY LastModifiedDate Desc';
        
        return Database.getQueryLocator( query);
     }
     global void execute(Database.BatchableContext BC, List<Contact>scope) 
     {
     	//System.debug('conList:-'+conList);
     	contactMerging(scope);
     	
     }
          
     global void finish(Database.BatchableContext BC)
     {
         
     }   
     //Method for performing merge on duplicate records
     // and delete previous record by keeping recent record
	public void contactMerging(List<Contact>conList)
	{
		List<DateTime>lastModifiedDateLst = new List<DateTime>();
     	Integer ListSize = conList.size();
     	DateTime LastRec;
     	System.debug('0th record'+conList[0]);
     	Contact firstConrec = conList[0];
     	System.debug('Last rec:-'+conList[ListSize-1]);
     	contact contoDel = new Contact();
     	for(Contact c : conList)
     	{
     		if(c.id != firstConrec.id)
     		if((firstConrec.Name == c.Name) && (firstConrec.Email == c.Email) && (firstConrec.Phone == c.Phone))
     		{
     			if(firstConrec.Birthdate == Null)
     			{
     				firstConrec.Birthdate = c.Birthdate; 
     			}
     			else if(firstConrec.Department == Null)
     			{
     				firstConrec.Department = c.Department;
     			}
     			else if(firstConrec.Description == Null)
     			{
     				firstConrec.Description = c.Description;
     			}
     			else if(firstConrec.fax == Null)
     			{
     				firstConrec.fax = c.fax;
     			}
     			else if(firstConrec.Title == Null)
     			{
     				firstConrec.Title = c.Title;
     			}
     			contoDel = c;
     			System.debug('contact c after copying to contodel :-'+contoDel);
     		}
     	
     			System.debug('final record after merging is ::-'+firstConrec);	
     	}
     		System.debug('contact to delete is :-'+contoDel);
     		delete contoDel;
     		update firstConrec;
    		
		
	}
    
}