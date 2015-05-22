//
//  ViewController.h
//  ABTextboxToolbarHandler
//
//  Created by Amit on 15/05/15.
//  Copyright (c) 2015 AmitBhavsar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABTextboxToolbarHandler.h"

@interface ViewController : UIViewController<ABTextboxToolbarHandlerDelegate>
{
	IBOutlet UITextField *txtfield1;
	IBOutlet UITextField *txtfield2;
	IBOutlet UITextField *txtfield3;
	
	IBOutlet UITextView *txtview1;
	
	IBOutlet UITextField *txtfield4;
	IBOutlet UITextField *txtfield5;
    IBOutlet UITextField *txtfield6;
    
	IBOutlet UIScrollView *scrlView;
	
	ABTextboxToolbarHandler *handler;
}

@end

