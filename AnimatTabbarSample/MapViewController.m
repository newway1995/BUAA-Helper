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
#import <AMapSearchKit/AMapSearchAPI.h>
@interface MapViewController () <MAMapViewDelegate,AMapSearchDelegate>


@property MAMapView *mapView;
@property CLLocationCoordinate2D shahe;
@property CLLocationCoordinate2D xueyuanlu;
@property MACoordinateRegion region;
@property CLLocationManager* locationManager;
@property AMapSearchAPI* search;
@property NSString* searchingStr;
@property NSMutableArray* hints;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property CGFloat cellHeight;
@property BOOL first;
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
   // [[self.searchBar.subviews objectAtIndex:0] setHidden:YES];
    //[[self.searchBar.subviews objectAtIndex:0] removeFromSuperview];
    for (UIView *view in self.searchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    self.first=YES;
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
    
    [self.mapView setUserTrackingMode: MAUserTrackingModeNone animated:YES];
    //[self.mapView setCameraDegree:45.0f];
    [self.mapView setCenterCoordinate:_xueyuanlu animated:YES];
    [self.mapView setZoomLevel:18 animated:YES];
     self.mapView.showsUserLocation=YES;
    
    [self.mapView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(limitZoom:)]];
    [self.mapView addGestureRecognizer:[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)]];
    [self.view addSubview:self.mapView];
    
    
    [self.view bringSubviewToFront:self.searchBar];

    [self.view bringSubviewToFront:self.tableView];
    [self.tableView setHidden:YES];
    [self.mapView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)]];
    
}

-(void)tapView:(UITapGestureRecognizer *)tap{
    [self.searchBar resignFirstResponder];
    [self tableViewHidden];
}



-(void)searchLocation:(NSString*)place{
    _search = [[AMapSearchAPI alloc] initWithSearchKey:mapKey Delegate:self];
    AMapGeocodeSearchRequest *geoRequest = [[AMapGeocodeSearchRequest alloc] init];
    geoRequest.searchType = AMapSearchType_Geocode;
    geoRequest.address = place;
    geoRequest.city = @[@"beijing"];
    
    //发起正向地理编码
    [_search AMapGeocodeSearch: geoRequest];
}
//实现正向地理编码的回调函数
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    [self.mapView setZoomLevel:17];
    NSLog(@"%ld",[response.geocodes count]);
    AMapGeocode * location = [response.geocodes objectAtIndex:0];
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(location.location.latitude, location.location.longitude);
    pointAnnotation.title = self.searchingStr;
    CLLocationCoordinate2D poi;
    poi.latitude=location.location.latitude;
    poi.longitude=location.location.longitude;
    [self.mapView setCenterCoordinate:poi animated:YES];
     [self.mapView addAnnotation:pointAnnotation];
    
}



- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

 
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
        //取出当前位置的坐标'
        if(self.first){
            [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
            self.first=NO;
        }
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

- (void) limitZoom:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    
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


//实现输入提示的回调函数
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    if(response.tips.count == 0)
    {
        return;
    }
    
    //通过AMapInputTipsSearchResponse对象处理搜索结果
    self.hints = [[NSMutableArray alloc] init];
    for (AMapTip *p in response.tips) {
        [self.hints addObject:p.name];
    }
    [self.tableView reloadData];

    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize labelsize = [[self.hints objectAtIndex:[indexPath row]] boundingRectWithSize:cell.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    self.cellHeight= labelsize.height+10;
    return self.cellHeight;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.hints count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"hintCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    if (self.hints != nil && self.hints.count >0) {
        NSUInteger row = [indexPath row];
        cell.textLabel.text = [self.hints objectAtIndex:row];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
           }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    self.searchBar.text = cell.textLabel.text;
    [self tableViewHidden];
    [self searchLocation:self.searchBar.text];
}


-(void)tableViewShow{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype= kCATransitionMoveIn;
    animation.duration = 0.4;
    [self.tableView.layer addAnimation:animation forKey:nil];
    self.tableView.hidden=NO;
}

-(void)tableViewHidden{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype= kCATransitionMoveIn;
    animation.duration = 0.4;
    [self.tableView.layer addAnimation:animation forKey:nil];
    self.tableView.hidden=YES;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
{
    if (searchText!=nil && searchText.length>0) {
        //初始化检索对象
        _search = [[AMapSearchAPI alloc] initWithSearchKey:mapKey Delegate:self];
        
        //构造AMapInputTipsSearchRequest对象，keywords为必选项，city为可选项
        AMapInputTipsSearchRequest *tipsRequest= [[AMapInputTipsSearchRequest alloc] init];
        tipsRequest.searchType = AMapSearchType_InputTips;
         tipsRequest.keywords = searchText;
        tipsRequest.city = @[@"北京"];
        
        //发起输入提示搜索
        [_search AMapInputTipsSearch: tipsRequest];
        if(self.tableView.hidden){
            [self tableViewShow];

        }
        else{
            CGRect frame = self.tableView.frame;
            [self.tableView setFrame:CGRectMake(frame.origin.x ,frame.origin.y, frame.size.width,(frame.size.height>5*self.cellHeight?self.cellHeight:frame.size.height))];
        }
       
    }
    
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchBar:self.searchBar textDidChange:nil];
    [_searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self searchBar:self.searchBar textDidChange:nil];
    [_searchBar resignFirstResponder];
}



@end
