//
//  PLGSecondViewController.h
//  Where is ISS
//
//  Created by Patrik Lindborg on 09/04/14.
//  Copyright (c) 2014 Patrik Lindborg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PLGSecondViewController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}


@end
