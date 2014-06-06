//
//  LPSaverView.h
//  LPSaver
//
//  Created by Oriol Ferrer Mesià on 29/04/14.
//  Copyright (c) 2014 Oriol Ferrer Mesià. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import <Quartz/Quartz.h>
#import <QuartzCore/QuartzCore.h>

@interface LPSaverView : ScreenSaverView{
	QCCompositionLayer * qcComp;

}

-(void)mount;

@end
