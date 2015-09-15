//
//  MapViewController.m
//  AnimatTabbarSample
//
//  Created by 牛威 on 15/9/8.
//  Copyright (c) 2015年 chenyanming. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "BUAAHCommon.h"

@interface MapViewController () <MAMapViewDelegate>


@property MAMapView *mapView;
@property CLLocationCoordinate2D shahe;
@property CLLocationCoordinate2D xueyuanlu;
@property MACoordinateRegion region;
@property CLLocationManager* locationManager;
@end



@implementation MapViewController


- (IBAction)locationChanged:(id)sender {
    if ([sender selectedSegmentIndex] == 0) {
        [self.mapView setCenterCoordinate:_xueyuanlu animated:YES];
    } else if ([sender selectedSegmentIndex] == 1) {
        [self.mapView setCenterCoordinate:_shahe animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    _xueyuanlu.latitude = 39.98156573996107f;
    _xueyuanlu.longitude = 116.34779244661331f;
    
    _shahe.latitude =40.15375880445598f;
    _shahe.longitude= 116.27287898719783f;
    
    _locationManager =[[CLLocationManager alloc] init];
    
 
    [MAMapServices sharedServices].apiKey = mapKey;
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    self.mapView.delegate = self;

    self.mapView.showsScale =YES;
    
    [self.mapView setUserTrackingMode: MAUserTrackingModeNone animated:YES];
    //[self.mapView setCameraDegree:45.0f];
    [self.mapView setCenterCoordinate:_xueyuanlu animated:YES];
    [self.mapView setZoomLevel:18 animated:YES];
    
    
    [self.mapView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(limitZoom:)]];
    [self.mapView addGestureRecognizer:[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)]];
    [self.view addSubview:self.mapView];
    
    // fix ios8 location issue
    self.locationManager =[[CLLocationManager alloc] init];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
#ifdef __IPHONE_8_0
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [self.locationManager performSelector:@selector(requestAlwaysAuthorization)];//用这个方法，plist中需要NSLocationAlwaysUsageDescription
        }
        
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [self.locationManager performSelector:@selector(requestWhenInUseAuthorization)];//用这个方法，plist里要加字段NSLocationAlwaysUsageDescription
        }
#endif
    }
 
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

    self.mapView.showsUserLocation=YES;
     _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

- (void) limitZoom:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    if([pinchGestureRecognizer state] == UIGestureRecognizerStateBegan ||[pinchGestureRecognizer state] == UIGestureRecognizerStateChanged){
        float i = [self.mapView zoomLevel];
        float scale= pinchGestureRecognizer.scale;
        if(scale>1.005) scale=1.005;
        else if(scale<0.995) scale=0.995;
        //NSLog(@"%f",scale);
        if(i*scale >18){
            //[self.mapView setZoomLevel:18];
        }
        else if(i*scale <16){
            //[self.mapView setZoomLevel:16];
        }
        else {
            [self.mapView setZoomLevel:i*scale];
        }
    }
}

- (void)rotate:(UIRotationGestureRecognizer *)gestureRecognizer
{
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
       // [gestureRecognizer view].transform = CGAffineTransformRotate([[gestureRecognizer view] transform], [gestureRecognizer rotation]);
        float rotate = [gestureRecognizer rotation];
    
        [self.mapView setRotationDegree:[self.mapView rotationDegree]-rotate*50];
        [gestureRecognizer setRotation:0];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
