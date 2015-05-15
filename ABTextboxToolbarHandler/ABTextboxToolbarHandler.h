//
//  ABTextboxToolbarHandler.h
//  ABTextboxToolbarHandler
//
//  Created by Amit on 15/05/15.
//  Copyright (c) 2015 AmitBhavsar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ABTextboxToolbarHandlerDelegate <NSObject>

@optional
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
- (void)textViewDidBeginEditing:(UITextView *)textView;
- (BOOL)textViewShouldEndEditing:(UITextView *)textView;

- (void)textFieldEndWithDoneButtonwithView:(UIView *)txtBox;

@end

@interface ABTextboxToolbarHandler : NSObject
@property (nonatomic) NSInteger offset;

@property (nonatomic) BOOL showNextPrevious;

@property (nonatomic, assign) CGFloat heightForScrollContent;

@property (nonatomic, strong) id<ABTextboxToolbarHandlerDelegate> delegate;

- (instancetype)initWithTextboxs:(NSArray *)textBoxs andScroll:(UIScrollView *)scroll NS_DESIGNATED_INITIALIZER;

- (void) btnDoneTap;

@end
