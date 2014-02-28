//
//  DWVideoView.m
//  AVBasicTest02
//
//  Created by Martin Delille on 07/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWVideoView.h"

@implementation DWVideoView{
	AVPlayerLayer* _playerLayer;
	AVPlayer * _player;
}


-(AVPlayer *)player {
	return _player;
}

-(void)setPlayer:(AVPlayer *)player {
	_player = player;
	[self setWantsLayer:YES];
	AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
	[playerLayer setFrame:self.bounds];
	[self.layer addSublayer:playerLayer];
}

-(BOOL)acceptsFirstResponder {
	return YES;
}

-(void)keyDown:(NSEvent *)theEvent {
	NSLog(@"video keydown : %d", theEvent.keyCode);
	switch (theEvent.keyCode) {
		case 5:
			self.player.rate = -3;
			break;
		case 4:
			self.player.rate = -1;
			break;
		case 38:
			self.player.rate = 1;
			break;
		case 40:
			self.player.rate = 3;
			break;
		case 49:
			if (_player.rate == 0) {
				_player.rate = 1;
			}
			else {
				_player.rate = 0;
			}
			break;
	}
	NSLog(@"rate = %f", _player.rate);
}

@end
