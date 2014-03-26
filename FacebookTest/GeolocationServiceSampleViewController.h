//
//  GeolocationServiceSampleViewController.h
//  FacebookTest
//
//  Created by dbgmacmini2 dbg on 25/03/14.
//  Copyright (c) 2014 codebase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface GeolocationServiceSampleViewController : UIViewController
@property(strong,nonatomic)FBRequest* facebookRequest;
- (IBAction)loginFacebook:(id)sender;


@end
