//
//  DWAppDelegate.h
//  AVBasicTest02
//
//  Created by Martin Delille on 07/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DWVideoView.h"
#import "DWOpenGLView.h"

@interface DWAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet DWVideoView *videoView;
@property (weak) IBOutlet DWOpenGLView *openglView;

@end
