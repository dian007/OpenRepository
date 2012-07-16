//
//  SpeedometerDemoViewController.m
//  SpeedometerDemo
//

//

#import "SpeedometerDemoViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation SpeedometerDemoViewController
@synthesize needleImageView;
@synthesize speedometerCurrentValue;
@synthesize prevAngleFactor;
@synthesize angle;
@synthesize speedometer_Timer;
@synthesize speedometerReading;
@synthesize maxVal;
@synthesize sliderValue;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	// Add Meter Contents //
	[self addMeterViewContents];
	
	
    [super viewDidLoad];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {

    [sliderValue release];
    sliderValue = nil;
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



- (void)dealloc {
	[maxVal release];
	[needleImageView release];
	[speedometer_Timer release];
	[speedometerReading release];
    [sliderValue release];
    [super dealloc];
}


#pragma mark -
#pragma mark Public Methods

-(void) addMeterViewContents
{
	
	UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320,460)];
	backgroundImageView.image = [UIImage imageNamed:@"main_bg.png"];
	[self.view addSubview:backgroundImageView];
	[backgroundImageView release];
	
	
	UIImageView *meterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 286,315)];
	meterImageView.image = [UIImage imageNamed:@"meter.png"];
	[self.view addSubview:meterImageView];
	[meterImageView release];
	
	
	//  Needle //
	UIImageView *imgNeedle = [[UIImageView alloc]initWithFrame:CGRectMake(143,155, 22, 84)];
	self.needleImageView = imgNeedle;
	[imgNeedle release];
	
	self.needleImageView.layer.anchorPoint = CGPointMake(self.needleImageView.layer.anchorPoint.x, self.needleImageView.layer.anchorPoint.y*2);
	self.needleImageView.backgroundColor = [UIColor clearColor];
	self.needleImageView.image = [UIImage imageNamed:@"arrow.png"];
	[self.view addSubview:self.needleImageView];
	
	// Needle Dot //
	UIImageView *meterImageViewDot = [[UIImageView alloc]initWithFrame:CGRectMake(131.5, 175, 45,44)];
	meterImageViewDot.image = [UIImage imageNamed:@"center_wheel.png"];
	[self.view addSubview:meterImageViewDot];
	[meterImageViewDot release];
	
	// Speedometer Reading //
	UILabel *tempReading = [[UILabel alloc] initWithFrame:CGRectMake(125, 250, 60, 30)];
	self.speedometerReading = tempReading;
	[tempReading release];
	self.speedometerReading.textAlignment = UITextAlignmentCenter;
	self.speedometerReading.backgroundColor = [UIColor blackColor];
	self.speedometerReading.text= @"0";
	self.speedometerReading.textColor = [UIColor colorWithRed:114/255.f green:146/255.f blue:38/255.f alpha:1.0];
	[self.view addSubview:self.speedometerReading ];
	
	// Set Max Value //
	self.maxVal = @"100";
	
	/// Set Needle pointer initialy at zero //
	[self rotateIt:-118.4];
	
	// Set previous angle //
	self.prevAngleFactor = -118.4;
	
	// Set Speedometer Value //
	[self setSpeedometerCurrentValue];
}

#pragma mark -
#pragma mark calculateDeviationAngle Method

-(void) calculateDeviationAngle
{
	
	if([self.maxVal floatValue]>0)
	{
		self.angle = ((self.speedometerCurrentValue *237.4)/[self.maxVal floatValue])-118.4;  // 237.4 - Total angle between 0 - 100 //
	}
	else
	{
		self.angle = 0;
	}
	
	if(self.angle<=-118.4)
	{
		self.angle = -118.4;  
	}
	if(self.angle>=119)
	{
		self.angle = 119;
	}
	
	
	// If Calculated angle is greater than 180 deg, to avoid the needle to rotate in reverse direction first rotate the needle 1/3 of the calculated angle and then 2/3. // 
	if(abs(self.angle-self.prevAngleFactor) >180)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5f];
		[self rotateIt:self.angle/3];
		[UIView commitAnimations];
		
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5f];
		[self rotateIt:(self.angle*2)/3];
		[UIView commitAnimations];
		
	}
	
	self.prevAngleFactor = self.angle;
	
	
	// Rotate Needle //
	[self rotateNeedle];
	
	
}


#pragma mark -
#pragma mark rotateNeedle Method
-(void) rotateNeedle
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5f];	
	[self.needleImageView setTransform: CGAffineTransformMakeRotation((M_PI / 180) * self.angle)];	
	[UIView commitAnimations];
	
}

#pragma mark -
#pragma mark setSpeedometerCurrentValue

-(void) setSpeedometerCurrentValue
{
	if(self.speedometer_Timer)
	{
		[self.speedometer_Timer invalidate];
		self.speedometer_Timer = nil;
	}
	self.speedometerCurrentValue =  arc4random() % 100; // Generate Random value between 0 to 100. //
	
    // disable timer
	//self.speedometer_Timer = [NSTimer  scheduledTimerWithTimeInterval:2 target:self selector:@selector(setSpeedometerCurrentValue) userInfo:nil repeats:YES];
	
	self.speedometerReading.text = [NSString stringWithFormat:@"%.2f",self.speedometerCurrentValue];
	
	// Calculate the Angle by which the needle should rotate //
	[self calculateDeviationAngle];
}
#pragma mark -
#pragma mark Speedometer needle Rotation View Methods

-(void) rotateIt:(float)angl
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.01f];
	
	[self.needleImageView setTransform: CGAffineTransformMakeRotation((M_PI / 180) *angl)];	
	
	[UIView commitAnimations];
}

-(IBAction) setValue:(id)sender {
    float  f = [sliderValue value];
    NSLog(@"get this %f", f);
    
    // should be refactored
    self.speedometerCurrentValue = f;
    self.speedometerReading.text = [NSString stringWithFormat:@"%.2f",self.speedometerCurrentValue];
	
	// Calculate the Angle by which the needle should rotate //
	[self calculateDeviationAngle];
}

@end
