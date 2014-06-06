//
//  LPSaverView.m
//  LPSaver
//
//  Created by Oriol Ferrer Mesià on 29/04/14.
//  Copyright (c) 2014 Oriol Ferrer Mesià. All rights reserved.
//

#import "LPSaverView.h"

static BOOL mounted = false;

@implementation LPSaverView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {

		[self setAnimationTimeInterval:1/60.0];
		[self setWantsLayer:YES];

		CALayer *bgLayer = [CALayer layer];
		bgLayer.backgroundColor = [[NSColor whiteColor] CGColor];
		frame.origin.x = frame.origin.y = 0.0f;
		bgLayer.frame = frame;
		[[self layer] addSublayer:bgLayer];
		[self setNeedsDisplay:true];

		CABasicAnimation* fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
		fadeAnimation.toValue = (id)[NSNumber numberWithFloat:0.0];
		fadeAnimation.removedOnCompletion = NO;
		fadeAnimation.duration = 2.5;
		fadeAnimation.fillMode = kCAFillModeForwards;
		[bgLayer addAnimation:fadeAnimation forKey:@"selectionAnimation"];

		if(!mounted){
			[NSThread detachNewThreadSelector:@selector(mount) toTarget:self withObject:nil];
		}

		while(!mounted){
			[NSThread sleepForTimeInterval:0.01];
		}

		NSString * compPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"saver" ofType:@"qtz"];
		//NSLog(@"CompPath: %@", compPath);


		//NSLog(@"frame: %@", NSStringFromRect(frame));
		qcComp = [QCCompositionLayer compositionLayerWithFile:compPath];
		qcComp.frame = NSRectToCGRect(frame);
		qcComp.opacity = 1.0;
		[[self layer] insertSublayer: qcComp below:bgLayer];
    }
    return self;
}

-(void)mount{
	NSString * scriptPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"mountVault" ofType:@"scpt"];
	//NSLog(@"scriptPath: %@", scriptPath);
	NSArray * args = [NSArray arrayWithObjects: scriptPath, nil];
	NSTask * task = [NSTask launchedTaskWithLaunchPath: @"/usr/bin/osascript" arguments: args];
	[task waitUntilExit];
	[task terminate];
	mounted = true;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
	return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
