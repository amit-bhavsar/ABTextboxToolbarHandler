//
//  TKTextboxToolbarHandeler.m
//  Trukit
//
//  Created by Chintan Dave on 06/05/14.
//  Copyright (c) 2014 AB. All rights reserved.
//

#define spaceWidthOnlyDone 250

#import "ABTextboxToolbarHandler.h"

@interface ABTextboxToolbarHandler () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) UIScrollView *scrvParent;

@property (strong, nonatomic) NSArray *textBoxes;

@property (strong, nonatomic) UIToolbar *toolBar;

@property (strong, nonatomic) UIBarButtonItem *btnPrevious;
@property (strong, nonatomic) UIBarButtonItem *btnNext;

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

#pragma mark - Init Methods
- (instancetype)initWithTextboxs:(NSArray *)textBoxs andScroll:(UIScrollView *)scroll
{
	self = [super init];
	
	if(self)
	{
        textBoxes  = textBoxs;
        scrvParent = scroll;

		defaultContentSize = scrvParent.contentSize;
		
		offset = 50;
		
		spaceWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 180;
		
		[self makeToolbar];
	}
	
	return self;
}

#pragma mark - Helper Methods
- (void) makeToolbar
{
	toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
	
    btnNext     = [[UIBarButtonItem alloc] initWithTitle:@"Next"	 style:UIBarButtonItemStyleBordered target:self action:@selector(btnNextTap)];
    btnPrevious = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(btnPreviousTap)];
    btnDone     = [[UIBarButtonItem alloc] initWithTitle:@"Done"	 style:UIBarButtonItemStyleBordered target:self action:@selector(btnDoneTap:)];
	
	fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	
	[fixedSpace setWidth:spaceWidth];
	
	[toolBar setItems:@[btnPrevious, btnNext, fixedSpace, btnDone]];
	
	for(UITextField *txtBox in textBoxes)
	{
		[txtBox setDelegate:self];
		[txtBox setInputAccessoryView:toolBar];
	}
}

- (void)setOffset:(NSInteger)offSet
{
    offset = offSet;
}

- (void)setShowNextPrevious:(BOOL)show
{
	showNextPrevious = show;
	
	if(showNextPrevious)
	{
		spaceWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 180;
		
		[fixedSpace setWidth:spaceWidth];
		
		[toolBar setItems:@[btnPrevious, btnNext, fixedSpace, btnDone]];
	}
	else
	{
		spaceWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 85;
		
		[fixedSpace setWidth:spaceWidth];
		
		[toolBar setItems:@[fixedSpace, btnDone]];
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
		[self btnDoneTap];
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
    
    UIView *txtBox = textBoxes[firstResponderIndex];
    
    [scrvParent	setContentSize:defaultContentSize];
    [scrvParent	setContentOffset:CGPointMake(0,0) animated:YES];
	
    if ([delegate respondsToSelector:@selector(textboxHandlerButtonDoneTap:)])
    {
        [delegate textboxHandlerButtonDoneTap:txtBox];
    }
}

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	firstResponderIndex = [textBoxes indexOfObject:textField];
	
    if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
    {
        [delegate textFieldShouldBeginEditing:textField];
    }
    
	[scrvParent setContentSize:CGSizeMake(defaultContentSize.width, defaultContentSize.height + 256 + 44)];
	[scrvParent setContentOffset:CGPointMake(0, [scrvParent convertPoint:CGPointZero fromView:textField].y - offset) animated:YES];
	
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
    {
        [delegate textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)])
    {
        [delegate textFieldDidEndEditing:textField];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)])
    {
       return [delegate textFieldShouldReturn:textField];
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
	
    if([delegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
	{
		[delegate textViewShouldBeginEditing:textView];
	}
    
	[scrvParent setContentSize:CGSizeMake(defaultContentSize.width, defaultContentSize.height + 256 + 44)];
	[scrvParent setContentOffset:CGPointMake(0, [scrvParent convertPoint:CGPointZero fromView:textView].y - offset) animated:YES];
	
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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	if([delegate respondsToSelector:@selector(textViewDidBeginEditing:)])
	{
		[delegate textViewDidBeginEditing:textView];
	}
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	if([delegate respondsToSelector:@selector(textViewDidEndEditing:)])
	{
		[delegate textViewDidEndEditing:textView];
	}
}
@end