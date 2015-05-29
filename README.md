# ABTextboxToolbarHandler
Often when we are creating application there will always some form in it. And when form have more UITextField or UITextView objects than we face a common  problem - Keyboard overlap fileds!! This code provide very easy solution to that problem.

**ABTextboxToolbarHandler** is the simple and easy to use solution where you can handle the navigation of input textfields and textviews.


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
	
## Delegate : 
When you use this code "handler" (Object of ABTextboxToolbarHandler) become Delegate of all textfields and textviews and it is require. So dont set Delegate of fields manually. If you need to access any delegate method than use ABTextboxToolbarHandlerDelegate.

## Installation :
There are two ways to ways to add the ABTextboxToolbarHandler library to your project. Add it as a regular library or install it through CocoaPods
  
    pod 'ABTextboxToolbarHandler'

## Customization :
This tool can be customize to fit your need:

**Set Scrolling :** If you thisn default scrolling is not proper for your need you can adjust by changing "offset" property.

**Next Previous Option :** If you want to hide Next and Previous button you can set showNextPrevious to NO.
