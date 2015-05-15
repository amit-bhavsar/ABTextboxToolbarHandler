# ABTextboxToolbarHandler
Often when we are creating application there will always some form in it. 
ABTextboxToolbarHandler is the simple and easy to use solution where you can handle the navigation of 
input textfields and textviews.


	//in .h file
	IBOutlet UITextField *txtfield1;
	IBOutlet UITextField *txtfield2;
	IBOutlet UITextField *txtfield3;
	
	IBOutlet UITextView *txtview1;
	
	IBOutlet UITextField *txtfield4;
	
	IBOutlet UIScrollView *scrlView;
	
	ABTextboxToolbarHandler *handler;


	//in .m file
	handler = [[ABTextboxToolbarHandler alloc]initWithTextboxs:@[txtfield1,txtfield2,txtfield3,txtview1,txtfield4] andScroll	:scrlView];
	
	
Thats it.
