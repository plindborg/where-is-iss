//
//  PLGSecondViewController.m
//  Where is ISS
//
//  Created by Patrik Lindborg on 09/04/14.
//  Copyright (c) 2014 Patrik Lindborg. All rights reserved.
//

#import "PLGSecondViewController.h"

@interface PLGSecondViewController ()
- (IBAction)onPassbutton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *passTimes;

@end

@implementation PLGSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    self.passTimes.text = [NSString stringWithFormat:@"Lat: %.5f%@ Long: %.5f", newLocation.coordinate.latitude, @" ", newLocation.coordinate.longitude];
    [self getCoordinates:newLocation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)getCoordinates:(CLLocation*) coords {
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://api.open-notify.org/iss-pass.json?lat=56.663056&lon=16.363056"]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSError *error;
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(NSClassFromString(@"NSJSONSerialization"))
    {
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:data
                     options:0
                     error:&error];
        
        if(error) { NSLog(@"%@", @"error in jason");}
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init] ;
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH    :mm:ss"];

        
        if([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *position = [object objectForKey:@"response"];
            for (NSDictionary *pos in position) {
                NSString * timeStampString = pos[@"risetime"];
                NSTimeInterval _interval=[timeStampString doubleValue];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
                NSString *labelData = [dateFormatter stringFromDate:date];
                self.passTimes.text = labelData;
                NSLog(@"%@ %@", date, pos[@"duration"] );
            }
            [locationManager stopUpdatingLocation];
        }
        else
        {
            NSLog(@"%@", @"something else");
        }

    }
    else
    {
        NSLog(@"%@", @"WTF");
    }
    return @"";
}



- (IBAction)onPassbutton:(id)sender {
    NSLog(@"button");
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}
@end
