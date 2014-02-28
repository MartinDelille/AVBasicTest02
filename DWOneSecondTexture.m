//
//  DWOneSecondTexture.m
//  AVBasicTest02
//
//  Created by Martin Delille on 09/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWOneSecondTexture.h"
#import <OpenGL/gl.h>

@implementation DWOneSecondTexture {
	GLuint texture;
	AVAssetTrack * _track;
	CMTimeRange _timeRange;
}

@synthesize ready;

-(id)initWithTrack:(AVAssetTrack *)track andTimeRange:(CMTimeRange)timeRange {
	self = [super init];
	if (self != nil) {
		_track = track;
		_timeRange = timeRange;
	}
	return self;
}

-(void)select {
	if (self.ready) {
		glBindTexture(GL_TEXTURE_2D, texture);
	}
}
@end
