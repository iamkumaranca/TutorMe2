//
//  MapViewController.m
//  TutorME
//
//  Created by Keith Lu on 2016-04-21.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"

@interface MapViewController ()<MKMapViewDelegate>
@property(nonatomic,strong)MKMapView* mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setMap];
    //set Annotation info and show it on map
    MapAnnotation* annotation=[[MapAnnotation alloc]init];
    annotation.coordinate=CLLocationCoordinate2DMake(43.656837, -79.738709);
    annotation.title=@"TutorMe";
    annotation.subtitle=@"7899 McLaughlin Road, Brampton, ON";
    [self.mapView addAnnotation:annotation];
}

-(void)setMap
{
    //MapView configurations.
    self.mapView=[[MKMapView alloc]init];
    self.mapView.frame=self.view.bounds;
    self.mapView.mapType=MKMapTypeStandard;
    self.mapView.showsUserLocation=NO;
    self.mapView.scrollEnabled=YES;
    self.mapView.zoomEnabled=YES;
    self.mapView.pitchEnabled=YES;
    self.mapView.rotateEnabled=YES;
    
    //Need it for zoomlevel and starting location
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 43.656837; // your latitude value
    zoomLocation.longitude= -79.738709; // your longitude value
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.18; // change as per your zoom level
    span.longitudeDelta=0.18; // change as per your zoom level
    region.span=span;
    region.center= zoomLocation;
    [self.mapView setRegion:region animated:TRUE];
    [self.mapView regionThatFits:region];
    
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)exit:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
