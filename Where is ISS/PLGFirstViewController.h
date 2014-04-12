//
//  PLGFirstViewController.h
//  Where is ISS
//
//  Created by Patrik Lindborg on 09/04/14.
//  Copyright (c) 2014 Patrik Lindborg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface PLGFirstViewController : UIViewController
- (IBAction)onGetCurrentLocation:(id)sender;
-(CLLocationCoordinate2D)getCoordinates;


@property (weak, nonatomic) IBOutlet UILabel *label;

@end
