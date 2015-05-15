//
//  ABTextboxToolbarHandler.m
//  ABTextboxToolbarHandler
//
//  Created by Amit on 15/05/15.
//  Copyright (c) 2015 AmitBhavsar. All rights reserved.
//

#import "ABTextboxToolbarHandler.h"

#define spaceWidthOnlyDone 250

@interface ABTextboxToolbarHandler () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) UIScrollView *scrvParent;

@property (strong, nonatomic) NSArray *textBoxes;

@property (strong, nonatomic) UIToolbar *toolBar;

@property (strong, nonatomic) UIBarButtonItem *btnPrevious;
@property (strong, nonatomic) UIBarButtonItem *btnNext;
@property (strong, nonatomic) UIBarButtonItem *btnDone;
@property (strong, nonatomic) UIBarButtonItem *fixedSpace;

@property CGSize defaultContentSize;

@property CGFloat spaceWidth;

@property NSUInteger firstResponderIndex;

@end

@implementation ABTextboxToolbarHandler

@synthesize textBoxes;
@synthesize toolBar, btnDone, btnNext, btnPrevious, fixedSpace;
@synthesize scrvParent, defaultContentSize;
@synthesize offset, firstResponderIndex, showNextPrevious, spaceWidth;
@synthesize delegate;
/**
 Initalize method
 */
#pragma mark - Init Methods
- (instancetype)initWithTextboxs:(NSArray *)textBoxs andScroll:(UIScrollView *)scroll
{
	self = [super init];
	
	if(self)
	{
		textBoxes  = textBoxs;
		scrvParent = scroll  ;
		
		defaultContentSize = scrvParent.contentSize;
		
		offset = 10;
		
		spaceWidth = 140;
		
		[self makeToolbar];
		
	}
	
	return self;
}

#pragma mark - Helper Methods
- (void) makeToolbar
{
	toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	
	btnNext     = [[UIBarButtonItem alloc] initWithTitle:@"Next"	 style:UIBarButtonItemStylePlain target:self action:@selector(btnNextTap)];
	btnPrevious = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:self action:@selector(btnPreviousTap)];
	btnDone     = [[UIBarButtonItem alloc] initWithTitle:@"Done"	 style:UIBarButtonItemStylePlain target:self action:@selector(btnDoneTap:)];
	
	fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	
	[fixedSpace setWidth:spaceWidth];
	
	[toolBar setItems:@[btnPrevious, btnNext, fixedSpace, btnDone]];
	
	for(UITextField *txtBox in textBoxes)
	{
		[txtBox setDelegate:self];
		[txtBox setInputAccessoryView:toolBar];
	}
}

#pragma mark - UIToolBar Methods
- (void) btnNextTap
{
	if(firstResponderIndex < (textBoxes.count - 1))
	{
		UIView *txtView = (UIView*)textBoxes[firstResponderIndex + 1];
		BOOL canUserInteraction = txtView.userInteractionEnabled;
		
		if (canUserInteraction == YES)
		{
			BOOL canBecome = [textBoxes[firstResponderIndex + 1] becomeFirstResponder];
			
			if(!canBecome)
			{
				firstResponderIndex++;
				
				[self btnNextTap];
			}
		}
		else
		{
			firstResponderIndex++;
			
			[self btnNextTap];
		}
	}
	else
	{
		[self btnDoneTap:nil];
	}
}

- (void) btnPreviousTap
{
	if(firstResponderIndex > 0)
	{
		UIView *txtView = (UIView*)textBoxes[firstResponderIndex - 1];
		BOOL canUserInteraction = txtView.userInteractionEnabled;
		
		if (canUserInteraction == YES)
		{
			BOOL canBecome = [textBoxes[firstResponderIndex - 1] becomeFirstResponder];
			
			if(!canBecome)
			{
				firstResponderIndex--;
				
				[self btnPreviousTap];
			}
		}
		else
		{
			firstResponderIndex--;
			
			[self btnPreviousTap];
		}
	}
	else
	{
		[self btnDoneTap];
	}
}

- (void) btnDoneTap
{
	[[[UIApplication sharedApplication] keyWindow] endEditing:YES];
	
	[scrvParent	setContentSize:defaultContentSize];
	[scrvParent	setContentOffset:CGPointMake(0,0) animated:YES];
}

- (void) btnDoneTap:(id)sender
{
	[[[UIApplication sharedApplication] keyWindow] endEditing:YES];
	
	[scrvParent	setContentSize:defaultContentSize];
	[scrvParent	setContentOffset:CGPointMake(0,0) animated:YES];
	
	UIView *txtBox = textBoxes[firstResponderIndex];
	
	if ([delegate respondsToSelector:@selector(textFieldEndWithDoneButtonwithView:)])
	{
		[delegate textFieldEndWithDoneButtonwithView:txtBox];
	}
}


#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	firstResponderIndex = [textBoxes indexOfObject:textField];
	
	[scrvParent setContentSize:CGSizeMake(defaultContentSize.width, defaultContentSize.height + 256 + 44)];
	[scrvParent setContentOffset:CGPointMake(0, [scrvParent convertPoint:CGPointZero fromView:textField].y - offset) animated:YES];
	
	if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
	{
		[delegate textFieldShouldBeginEditing:textField];
	}
	
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
	{
		[delegate textFieldDidBeginEditing:textField];
	}
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
	{
		return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
	}
	else
	{
		return YES;
	}
}


#pragma mark - UITextViewDelegate Methods
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	firstResponderIndex = [textBoxes indexOfObject:textView];
	
	[scrvParent setContentSize:CGSizeMake(defaultContentSize.width, defaultContentSize.height + 256 + 44)];
	[scrvParent setContentOffset:CGPointMake(0, [scrvParent convertPoint:CGPointZero fromView:textView].y - offset) animated:YES];
	
	if([delegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
	{
		[delegate textViewShouldBeginEditing:textView];
	}
	
	return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if([delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
	{
		return [delegate textView:textView shouldChangeTextInRange:range replacementText:text];
	}
	else
	{
		return YES;
	}
	
}


@end
