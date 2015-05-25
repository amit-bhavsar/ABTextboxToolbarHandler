//
//  ViewController.m
//  ABTextboxToolbarHandler
//
//  Created by Amit on 15/05/15.
//  Copyright (c) 2015 AmitBhavsar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
    //Content size must be set befor ABTextboxToolbarHandler creation.
	[scrlView setContentSize:CGSizeMake(320, 410)];
	
	//The sequence of the textfields are very important
	handler = [[ABTextboxToolbarHandler alloc] initWithTextboxs:@[txtfield1,txtfield2,txtfield3,txtview1,txtfield4,txtfield5,txtfield6] andScroll:scrlView];
}

- (void)textFieldEndWithDoneButtonwithView:(UIView *)txtBox
{
	//done button tap
}

@end