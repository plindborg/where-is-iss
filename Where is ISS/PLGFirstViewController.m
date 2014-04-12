//
//  PLGFirstViewController.m
//  Where is ISS
//
//  Created by Patrik Lindborg on 09/04/14.
//  Copyright (c) 2014 Patrik Lindborg. All rights reserved.
//

#import "PLGFirstViewController.h"

@interface PLGFirstViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation PLGFirstViewController

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

- (IBAction)onGetCurrentLocation:(id)sender {
    self.label.text = @"pressed";
    CLLocationCoordinate2D coord = self.getCoordinates;

    
    
    NSString *coordStr = [NSString stringWithFormat:@"Lat: %.5f%@ Long: %.5f", coord.latitude, @" ", coord.longitude];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coord];
    [annotation setTitle:@"International Space Station"];
    [annotation setSubtitle:coordStr/*@"International Space Station"*/];
    [self.mapView addAnnotation:annotation];
    
    
    self.label.text = coordStr;
    
}

-(CLLocationCoordinate2D)getCoordinates {
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://api.open-notify.org/iss-now.json"]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSError *error;
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *latitude;
    NSString *longitude;
    
    if(NSClassFromString(@"NSJSONSerialization"))
    {
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:data
                     options:0
                     error:&error];
        
        if(error) { NSLog(@"%@", @"error in jason");}
        
        if([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *position = [object objectForKey:@"iss_position"];
            latitude = [position objectForKey:@"latitude"];
            longitude = [position objectForKey:@"longitude"];
            
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
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    
    return coord;
}

@end
