//
//  ViewController.h
//  GetCookies
//
//  Created by svp on 30.01.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (retain, nonatomic) IBOutlet UITextField *userName;
@property (retain, nonatomic) IBOutlet UITextField *passWord;
@property (retain, nonatomic) IBOutlet UITextView *cookiesText;


- (BOOL)textFieldShouldReturn:(UITextField *)textField; 
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

@end
