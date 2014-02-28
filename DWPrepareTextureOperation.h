//
//  DWPrepareTextureOperation.h
//  AVBasicTest02
//
//  Created by Martin Delille on 10/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface DWPrepareTextureOperation : NSOperation

@property int textureNumber;

-(id)initWithAsset:(AVAsset*)asset;

@end
