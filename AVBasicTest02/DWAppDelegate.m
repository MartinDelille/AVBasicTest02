//
//  DWAppDelegate.m
//  AVBasicTest02
//
//  Created by Martin Delille on 07/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWAppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@implementation DWAppDelegate {
	AVURLAsset * urlAsset;
	AVPlayerItem * playerItem;
	AVPlayer * player;
}


@synthesize window = _window;
@synthesize videoView = _videoView;
@synthesize openglView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	NSURL * url = [NSURL fileURLWithPath:@"/Users/martindelille/Dropbox/DirtyLove/DirtyLove.mov"];
//	NSURL * url = [NSURL fileURLWithPath:@"/Users/martindelille/Downloads/simpsons_movie_trailer/The Simpsons Movie - Trailer.mp4"];
	player = [AVPlayer playerWithURL:url];
	urlAsset = [[AVURLAsset alloc] initWithURL:url options:nil];
	NSLog(@"asset : %@", urlAsset.URL);
	NSArray *keys = [NSArray arrayWithObject:@"tracks"];
	
	[urlAsset loadValuesAsynchronouslyForKeys:keys completionHandler:^() {
		dispatch_async(dispatch_get_main_queue(),
					   ^{
						   NSError *error = nil;
						   NSLog(@"result :");
						   
						   AVKeyValueStatus trackStatus = [urlAsset statusOfValueForKey:@"tracks" error:&error];
						   
						   switch (trackStatus) {
							   case AVKeyValueStatusLoaded:
							   {
								   NSLog(@"loaded");
								   playerItem = [AVPlayerItem playerItemWithAsset:urlAsset];
								   
								   [playerItem addObserver:self forKeyPath:@"status" options:0 context:nil];
								   player = [AVPlayer playerWithPlayerItem:playerItem];
								   self.videoView.player = player;
								   break;
							   }
							   case AVKeyValueStatusFailed:
								   NSLog(@"failed");
								   break;
							   case AVKeyValueStatusCancelled:
								   NSLog(@"canceled");
								   break;
						   }
					   });
	}];
	NSLog(@"%s : bye", __PRETTY_FUNCTION__);

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	NSLog(@"%s : %@", __PRETTY_FUNCTION__, keyPath);
	if (playerItem.status == AVPlayerItemStatusReadyToPlay ) {
		
		[openglView loadTextureFromAsset:urlAsset atIndex:0];
		openglView.player = player;
		player.rate = 1;
		[openglView start];
		NSLog(@"%@", [self.window firstResponder]);
		[self.window makeFirstResponder:self.videoView];
	}
}

@end
