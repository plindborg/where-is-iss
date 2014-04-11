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
            
            NSLog(@"Iss_position:%@",[object objectForKey:@"iss_position"]);
            NSLog(@"%@", @"We have a dictionary");
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
    
    NSString *coord = [NSString stringWithFormat:@"%@%@%@", latitude, @"\n", longitude];
    
    
    
    
    
    self.label.text = coord;
    
    NSLog(@"Button");
}
@end
