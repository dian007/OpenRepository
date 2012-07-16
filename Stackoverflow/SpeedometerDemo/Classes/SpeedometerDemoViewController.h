//
//  SpeedometerDemoViewController.h
//  SpeedometerDemo
//

//

#import <UIKit/UIKit.h>

@interface SpeedometerDemoViewController : UIViewController {
	UIImageView *needleImageView;
	float speedometerCurrentValue;
	float prevAngleFactor;
	float angle;
	NSTimer *speedometer_Timer;
	UILabel *speedometerReading;
	NSString *maxVal;

    IBOutlet UISlider *sliderValue;

}
@property(nonatomic,retain) UIImageView *needleImageView;
@property(nonatomic,assign) float speedometerCurrentValue;
@property(nonatomic,assign) float prevAngleFactor;
@property(nonatomic,assign) float angle;
@property(nonatomic,retain) NSTimer *speedometer_Timer;
@property(nonatomic,retain) UILabel *speedometerReading;
@property(nonatomic,retain) NSString *maxVal;
@property(nonatomic,retain) UISlider *sliderValue;


-(void) addMeterViewContents; 
-(void) rotateIt:(float)angl;
-(void) rotateNeedle;
-(void) setSpeedometerCurrentValue;

-(IBAction) setValue:(id) sender;

@end

