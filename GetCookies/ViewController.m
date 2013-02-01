//
//  ViewController.m
//  GetCookies
//
//  Created by svp on 30.01.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize userName;
@synthesize passWord;
@synthesize cookiesText;



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    passWord.secureTextEntry=YES;
    [userName setDelegate:self];
    [passWord setDelegate:self];
   // userName.keyboardType=UIKeyboardTypeDefault;

	// Do any additional setup after loading the view, typically from a nib.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    NSURL *url=[NSURL URLWithString:@"http:/github.com/login"];
    
    NSLog(@"%@",userName.text);
    
    
   NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
    NSString *param=[NSString stringWithFormat:@"email=%@&password=%@",userName.text,passWord.text];
    NSData *postParam = [param dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]; 
    NSString *postLength = [NSString stringWithFormat:@"%d", [postParam length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"]; 
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postParam];
    
    NSURLConnection *connection=[NSURLConnection connectionWithRequest:request delegate:self];
    if (!connection) [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
    //[connection release];
    [userName resignFirstResponder];
    [passWord resignFirstResponder];
    
 return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse  *httpResponse = [(NSHTTPURLResponse*)response retain];
	// Check the status code and respond appropriately.
	switch ([httpResponse statusCode]) {
		case 200: {
			// Got a response so extract any cookies.  The array will be empty if there are none.
			NSDictionary *theHeaders = [httpResponse allHeaderFields];
		    NSArray	*theCookies = [NSHTTPCookie cookiesWithResponseHeaderFields:theHeaders forURL:[NSURL URLWithString:@"http:/github.com/login"]]; 
           // NSLog(@"%@",theCookies);
            if (theCookies) {
                NSDictionary * headers = [NSHTTPCookie requestHeaderFieldsWithCookies:theCookies];
                 NSLog(@"%@",headers );
                NSMutableString *s=[NSMutableString stringWithCapacity:0];
                NSString *sStr=@"";
                
                
                if (theCookies) {
                    NSEnumerator *enumerator = [headers objectEnumerator];
                    id cookie;
                    
                    while (cookie = [enumerator nextObject]) {
                        sStr=cookie;
                        [s appendString:sStr];
                        sStr=@"";
                        //NSLog(@"%@",cookie);
                        //[request setValue:cookie  forHTTPHeaderField:@"Cookies"];
                    }
                    cookiesText.text=s;
                                    }
                else self.cookiesText.text=@"no cookies";
            }
        default:
			break;
        }
    }
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
    [connection cancel];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}





- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [userName release];
    [passWord release];
    [cookiesText release];
    [cookiesText release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setCookiesText:nil];
    [self setCookiesText:nil];
    [super viewDidUnload];
}
@end
