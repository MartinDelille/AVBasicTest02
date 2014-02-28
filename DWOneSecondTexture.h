//
//  DWOneSecondTexture.h
//  AVBasicTest02
//
//  Created by Martin Delille on 09/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface DWOneSecondTexture : NSObject

@property BOOL ready;

-(id)initWithTrack:(AVAssetTrack*)track andTimeRange:(CMTimeRange)timeRange;

-(void)select;

@end
