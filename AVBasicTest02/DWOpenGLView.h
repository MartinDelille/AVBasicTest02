//
//  DWOpenGLView.h
//  AVBasicTest02
//
//  Created by Martin Delille on 08/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
#import <OpenGL/glu.h>

@interface DWOpenGLView : NSOpenGLView

@property AVPlayer * player;

-(BOOL)loadTextureFromAsset:(AVAsset*)asset atIndex:(int)texIndex;

-(void)start;

@end
