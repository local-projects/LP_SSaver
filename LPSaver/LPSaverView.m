//
//  LPSaverView.m
//  LPSaver
//
//  Created by Oriol Ferrer Mesià on 29/04/14.
//  Copyright (c) 2014 Oriol Ferrer Mesià. All rights reserved.
//

#import "LPSaverView.h"

@implementation LPSaverView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {

		[self setAnimationTimeInterval:1/60.0];
		[self setWantsLayer:YES];

		NSString * scriptPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"mountVault" ofType:@"scpt"];
		//NSLog(@"scriptPath: %@", scriptPath);
		NSArray * args = [NSArray arrayWithObjects: scriptPath, nil];
		NSTask * task = [NSTask launchedTaskWithLaunchPath: @"/usr/bin/osascript" arguments: args];
		[task waitUntilExit];
		[task terminate];

		NSString * compPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"saver" ofType:@"qtz"];
		//NSLog(@"CompPath: %@", compPath);

		frame.origin.x = frame.origin.y = 0.0f;

		//NSLog(@"frame: %@", NSStringFromRect(frame));
		qcComp = [QCCompositionLayer compositionLayerWithFile:compPath];
		qcComp.frame = NSRectToCGRect(frame);
		qcComp.opacity = 1.0;
		[[self layer] addSublayer: qcComp];

    }
    return self;
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
