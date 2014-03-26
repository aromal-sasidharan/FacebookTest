//
//  GeolocationServiceSampleViewController.m
//  FacebookTest
//
//  Created by dbgmacmini2 dbg on 25/03/14.
//  Copyright (c) 2014 codebase. All rights reserved.
//

#import "GeolocationServiceSampleViewController.h"

@interface GeolocationServiceSampleViewController ()

@end

@implementation GeolocationServiceSampleViewController
@synthesize facebookRequest;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)openFacebookSession
{
    
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            //@"user_likes",
                            //@"read_stream",
                            @"publish_stream",
                            @"user_events",
                            @"friends_birthday",
                            @"read_friendlists",
                            @"user_birthday",
                            @"email",
                            @"manage_notifications",
                            nil];
    
    [FBSession openActiveSessionWithPermissions:permissions  allowLoginUI:YES
                              completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         NSLog(@"state %d", state);
         [self sessionStateChanged:session state:state error:error];
     }];
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            
            NSLog(@"FBSessionStateOpen");
            [FBSession setActiveSession:session];

            [self FacebookLoginSuccess];
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            
            [FBSession.activeSession closeAndClearTokenInformation];
            [self FacebookLoginFailed];

            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@""
                                  message:@"Could not complete the operation"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


-(void)logoutFromFacebook
{
    [FBSession.activeSession closeAndClearTokenInformation];
//    [self.facebook logout];
    
}
-(void)FacebookLoginSuccess
{
    [self getFacebookFriends];
}
-(void)FacebookLoginFailed
{
    
}
- (IBAction)loginFacebook:(id)sender {
    [self openFacebookSession];
}
-(void)getFacebookFriends
{
    facebookRequest = [[FBRequest alloc]initWithSession:FBSession.activeSession graphPath:@"/me/friends?fields=birthday,name" parameters:nil HTTPMethod:@"GET"];
    
   
    [facebookRequest startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        if(!error)
        {
            NSLog(@"result is %@",result);
        }
        else
        {
            NSLog(@"Errorr is %@",error);
        }
        
    }];
}
@end
