@isTest
public class TestContactMergingonDuplication {
	static testMethod void unitTesting()
	{
		test.startTest();
		Date d = Date.Today();
		Contact c1 = new Contact(FirstName = 'demo1' ,LastName = 'sirname',Email = 'demo@demo.com',Phone = '123456',
		Birthdate = d,Department= 'Computer',Description = 'this is first contact',
		Fax = 'this is fax',Title = 'this is title');
		
		insert c1;
		
		Contact c2 = new Contact(FirstName = 'demo1' ,LastName = 'sirname',Email = 'demo@demo.com',Phone = '123456',
		Birthdate = d,Department= 'Computer',Description = 'this is first contact',
		Fax = 'this is fax',Title = 'this is title');
		
		insert c2;
		
		ContactMergingonDuplication c = new ContactMergingonDuplication();
		Database.executeBatch(c);
		
		test.stopTest();
	}
    
}