//
//  DWOpenGLView.m
//  AVBasicTest02
//
//  Created by Martin Delille on 08/06/12.
//  Copyright (c) 2012 Dubware. All rights reserved.
//

#import "DWOpenGLView.h"
#import <QuartzCore/QuartzCore.h>
#import "DWFourCCToStringTransformer.h"

@implementation DWOpenGLView {
	CVDisplayLinkRef displayLink;
	float x, inc;
	GLuint texture[ 2 ];     // Storage for one texture
	NSMutableArray * textureDictionnary;
}

@synthesize player;

-(BOOL)useAssetForRythmo:(AVAsset *)asset {
	BOOL status = FALSE;/*
	//	int typeOfProjection = 0; // diagonale
	int typeOfProjection = 1; // vertical
	float projectionAxisPosition = 0.5f; 
	AVAssetTrack * videoTrack = nil;
	for (AVAssetTrack *track in [asset tracks])
	{
		if ([track.mediaType isEqualToString:AVMediaTypeVideo]) {
			videoTrack = track;
			break;
		}
	}
	
	if (videoTrack == nil) {
		NSLog(@"no video track");
		return YES;
	}
	
	NSLog(@"totalSampleDataLength : %lld", videoTrack.totalSampleDataLength);
	NSLog(@"start : %lld", videoTrack.timeRange.start.value);
	NSLog(@"duration : %lld", videoTrack.timeRange.duration.value);
	CGSize texSize;
	// WARNING / TODO : check scale
	texSize.height = videoTrack.timeRange.duration.value;
	texSize.width = videoTrack.naturalSize.height;
	
	GLenum texFormat = GL_BGRA;
	char* texBytes = calloc(4 * texSize.width * texSize.height, 1);
	
	AVAssetReader * assetReader = [AVAssetReader assetReaderWithAsset:asset error:nil];
	
	NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
	NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
	NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key]; 
	
	AVAssetReaderTrackOutput *assetReaderOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:videoTrack outputSettings:videoSettings]; 
	
	if ([assetReader canAddOutput:assetReaderOutput]) {
		[assetReader addOutput:assetReaderOutput];
		if ([assetReader startReading] == YES) {
			int count = 0;
			int currentPixelIndex = 0;
			
			while ( [assetReader status]==AVAssetReaderStatusReading ) {
				if (count % 100 == 0) {
					NSLog(@"reading %d", count);
				}
				CMSampleBufferRef sampleBuffer = [assetReaderOutput copyNextSampleBuffer];
				if (sampleBuffer == NULL) {
					if ([assetReader status] == AVAssetReaderStatusFailed) {
						NSLog(@"failed");
						break;
					}
					else
						continue;
				}
				
				CMFormatDescriptionRef format = CMSampleBufferGetFormatDescription(sampleBuffer);
				CMMediaType type = CMFormatDescriptionGetMediaType(format);
				//				FourCharCode fourcc = CMFormatDescriptionGetMediaSubType(format);
				//	NSLog(@"fourcc :%@", [DWFourCCToStringTransformer stringWithFourCC:fourcc]);
				switch (type) {
					case kCMMediaType_Video:
						count++;
						
						
						CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
						
						if (imageBuffer != nil) {
							// Lock the image buffer
							CVPixelBufferLockBaseAddress(imageBuffer,0); 
							// Get information about the image
							uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
							size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
							size_t height = CVPixelBufferGetHeight(imageBuffer);
							size_t width = CVPixelBufferGetWidth(imageBuffer);
							
							// upleft
							// Copy the entire row in one shot
							for (int i = 0; i < height; i++) {
								int offset = 0;
								switch (typeOfProjection) {
									case 0:
										offset = i * width / height;
										break;
									case 1:
										offset = (int)(projectionAxisPosition * width);
								}
								memcpy( texBytes + currentPixelIndex,
									   baseAddress + i * bytesPerRow + offset * 4,
									   4 );
								currentPixelIndex+=4;
							}						
							
							// We unlock the  image buffer
							CVPixelBufferUnlockBaseAddress(imageBuffer,0);
						}
						else {
							NSLog(@"problem");
						}
						
						CFRelease(sampleBuffer);
						
						break;
						
					default:
						break;
				}
				
				
			}
		}
		else {
			NSLog(@"error");
			return NO;
		}
	}
	else {
		NSLog(@"error");
		return NO;
	}
	
	
	status = TRUE;
	
	glGenTextures( 1, &texture[ texIndex ] );   // Create the texture
	
	// Typical texture generation using data from the bitmap
	glBindTexture( GL_TEXTURE_2D, texture[ texIndex ] );
	
	glTexImage2D( GL_TEXTURE_2D, 0, 3, texSize.width,
				 texSize.height, 0, texFormat,
				 GL_UNSIGNED_BYTE, texBytes );
	// Linear filtering
	glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
	glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
	
	free( texBytes );
	*/
	return status;
}

-(BOOL)loadTextureFromAsset:(AVAsset *)asset atIndex:(int)texIndex {
	BOOL status = FALSE;
	//		return NO;
//	int typeOfProjection = 0; // diagonale
	int typeOfProjection = 1; // vertical
	float projectionAxisPosition = 0.5f; 
	AVAssetTrack * videoTrack = nil;
	for (AVAssetTrack *track in [asset tracks])
	{
		if ([track.mediaType isEqualToString:AVMediaTypeVideo]) {
			videoTrack = track;
			break;
		}
	}
	
	if (videoTrack == nil) {
		NSLog(@"no video track");
		return YES;
	}
	
	NSLog(@"totalSampleDataLength : %lld", videoTrack.totalSampleDataLength);
	NSLog(@"start : %lld", videoTrack.timeRange.start.value);
	NSLog(@"duration : %lld", videoTrack.timeRange.duration.value);
	NSLog(@"scale : %d", videoTrack.timeRange.duration.timescale);
	NSLog(@"rate : %f", videoTrack.nominalFrameRate);
//	NSLog(@"sample : %d", videoTrack.);
	
	CGSize texSize;
	// WARNING / TODO : check scale
	texSize.height = videoTrack.timeRange.duration.value * 25 / videoTrack.timeRange.duration.timescale;
	texSize.width = videoTrack.naturalSize.height;
	
	GLenum texFormat = GL_BGRA;
	char* texBytes = calloc(4 * texSize.width * texSize.height, 1);
	
	AVAssetReader * assetReader = [AVAssetReader assetReaderWithAsset:asset error:nil];
	
	NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
	NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
	NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key]; 
	
	AVAssetReaderTrackOutput *assetReaderOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:videoTrack outputSettings:videoSettings]; 
	
	if ([assetReader canAddOutput:assetReaderOutput]) {
		[assetReader addOutput:assetReaderOutput];
		if ([assetReader startReading] == YES) {
			int count = 0;
			int currentPixelIndex = 0;
			
			while ( [assetReader status]==AVAssetReaderStatusReading ) {
				if (count % 100 == 0) {
					NSLog(@"reading %d", count);
				}
				CMSampleBufferRef sampleBuffer = [assetReaderOutput copyNextSampleBuffer];
				if (sampleBuffer == NULL) {
					if ([assetReader status] == AVAssetReaderStatusFailed) {
						NSLog(@"failed");
						break;
					}
					else
						continue;
				}
				
				CMFormatDescriptionRef format = CMSampleBufferGetFormatDescription(sampleBuffer);
				CMMediaType type = CMFormatDescriptionGetMediaType(format);
				//FourCharCode fourcc = CMFormatDescriptionGetMediaSubType(format);
				//NSLog(@"fourcc :%@", [DWFourCCToStringTransformer stringWithFourCC:fourcc]);
				switch (type) {
					case kCMMediaType_Video:
						count++;
						
						
						CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
						
						if (imageBuffer != nil) {
							// Lock the image buffer
							CVPixelBufferLockBaseAddress(imageBuffer,0); 
							// Get information about the image
							uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
							size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
							size_t height = CVPixelBufferGetHeight(imageBuffer);
							size_t width = CVPixelBufferGetWidth(imageBuffer);
							
							// upleft
							// Copy the entire row in one shot
							for (int i = 0; i < height; i++) {
								int offset = 0;
								switch (typeOfProjection) {
									case 0:
										offset = i * width / height;
										break;
									case 1:
										offset = (int)(projectionAxisPosition * width);
										break;
								}
								memcpy( texBytes + currentPixelIndex,
									   baseAddress + i * bytesPerRow + offset * 4,
									   4 );
								currentPixelIndex+=4;
							}						
							
							// We unlock the  image buffer
							CVPixelBufferUnlockBaseAddress(imageBuffer,0);
						}
						else {
							NSLog(@"problem");
						}
						
						CFRelease(sampleBuffer);
						
						break;
						
					default:
						break;
				}
			}
		}
		else {
			NSLog(@"error");
			return NO;
		}
	}
	else {
		NSLog(@"error");
		return NO;
	}
	
	/*	int n = 0;
	 for (int i = 0; i < texSize.height; i++) {
	 for (int j = 0; j < texSize.width; j++) {
	 texBytes[n++] = i * 255 / texSize.width;
	 texBytes[n++] = j * 255 / texSize.height;
	 texBytes[n++] = 0;
	 }
	 }*/
	
	status = TRUE;
	
	glGenTextures( 1, &texture[ texIndex ] );   // Create the texture
	
	// Typical texture generation using data from the bitmap
	glBindTexture( GL_TEXTURE_2D, texture[ texIndex ] );
	
	glTexImage2D( GL_TEXTURE_2D, 0, 3, texSize.width,
				 texSize.height, 0, texFormat,
				 GL_UNSIGNED_BYTE, texBytes );
	// Linear filtering
	glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
	glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
	
	free( texBytes );
	
	return status;
}

-(BOOL)loadTextureFromAsset2:(AVAsset *)asset atIndex:(int)texIndex {
	BOOL status = FALSE;

	AVAssetTrack * videoTrack = nil;
	for (AVAssetTrack *track in [asset tracks])
	{
		if ([track.mediaType isEqualToString:AVMediaTypeVideo]) {
			videoTrack = track;
			break;
		}
	}
	
	if (videoTrack == nil) {
		NSLog(@"no video track");
		return YES;
	}
	
	CGSize texSize = videoTrack.naturalSize;
	GLenum texFormat = GL_BGRA;
	char* texBytes = nil;
	
	AVAssetReader * assetReader = [AVAssetReader assetReaderWithAsset:asset error:nil];
	
	NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
	NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
	NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key]; 
	
	AVAssetReaderTrackOutput *assetReaderOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:videoTrack outputSettings:videoSettings]; 
	
	if ([assetReader canAddOutput:assetReaderOutput]) {
		[assetReader addOutput:assetReaderOutput];
		if ([assetReader startReading] == YES) {
			int count = 0;
			
			while ( [assetReader status]==AVAssetReaderStatusReading ) {
				NSLog(@"reading %d", count);
				CMSampleBufferRef sampleBuffer = [assetReaderOutput copyNextSampleBuffer];
				if (sampleBuffer == NULL) {
					if ([assetReader status] == AVAssetReaderStatusFailed) {
						NSLog(@"failed");
						break;
					}
					else
						continue;
				}
				
				CMFormatDescriptionRef format = CMSampleBufferGetFormatDescription(sampleBuffer);
				CMMediaType type = CMFormatDescriptionGetMediaType(format);
				FourCharCode fourcc = CMFormatDescriptionGetMediaSubType(format);
				NSLog(@"fourcc :%@", [DWFourCCToStringTransformer stringWithFourCC:fourcc]);
				switch (type) {
					case kCMMediaType_Video:
						count++;
						
						
						CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
						
						if (imageBuffer != nil) {
							// Lock the image buffer
							CVPixelBufferLockBaseAddress(imageBuffer,0); 
							// Get information about the image
							uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
							size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
							//				size_t width = CVPixelBufferGetWidth(imageBuffer); 
							size_t height = CVPixelBufferGetHeight(imageBuffer);
							
							if (texBytes == nil) {
								texBytes = calloc(bytesPerRow * height, 1);
							}
							// upleft
							
							int destRowNum = 0;
							for( int rowNum = height - 1; rowNum >= 0; rowNum--, destRowNum++ )
							{
								// Copy the entire row in one shot
								memcpy( texBytes + ( destRowNum * bytesPerRow ),
									   baseAddress + ( rowNum * bytesPerRow ),
									   bytesPerRow );
							}
							
							// We unlock the  image buffer
							CVPixelBufferUnlockBaseAddress(imageBuffer,0);
						}
						else {
							NSLog(@"problem");
						}
						
						CFRelease(sampleBuffer);
						
						break;
						
					default:
						break;
				}
				
				
				break;
			}
		}
		else {
			NSLog(@"error");
			return NO;
		}
	}
	else {
		NSLog(@"error");
		return NO;
	}
	
	/*	int n = 0;
	 for (int i = 0; i < texSize.height; i++) {
	 for (int j = 0; j < texSize.width; j++) {
	 texBytes[n++] = i * 255 / texSize.width;
	 texBytes[n++] = j * 255 / texSize.height;
	 texBytes[n++] = 0;
	 }
	 }*/
	
	status = TRUE;
	
	glGenTextures( 1, &texture[ texIndex ] );   // Create the texture
	
	// Typical texture generation using data from the bitmap
	glBindTexture( GL_TEXTURE_2D, texture[ texIndex ] );
	
	glTexImage2D( GL_TEXTURE_2D, 0, 3, texSize.width,
				 texSize.height, 0, texFormat,
				 GL_UNSIGNED_BYTE, texBytes );
	// Linear filtering
	glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
	glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
	
	free( texBytes );
	
	return status;
}


/*
 * Setup a texture from our model
 */
- (BOOL) loadGLTextureFromComputingAtIndex:(int)texIndex
{
	BOOL status = FALSE;
	GLenum texFormat = GL_RGB;
	
	NSSize texSize = NSMakeSize(16, 16);     // Width and height
	char *texBytes = calloc( 3 * texSize.width * texSize.height, 1);
	
	int n = 0;
	for (int i = 0; i < 16; i++) {
		for (int j = 0; j < 16; j++) {
			texBytes[n++] = i*16;
			texBytes[n++] = j*16;
			texBytes[n++] = 0;
		}
	}
	
	
	status = TRUE;
	
	glGenTextures( 1, &texture[ texIndex ] );   // Create the texture
	
	// Typical texture generation using data from the bitmap
	glBindTexture( GL_TEXTURE_2D, texture[ texIndex ] );
	
	glTexImage2D( GL_TEXTURE_2D, 0, 3, texSize.width,
				 texSize.height, 0, texFormat,
				 GL_UNSIGNED_BYTE, texBytes );
	// Linear filtering
	glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
	glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
	
	free( texBytes );
	
	return status;
}

/*
 * Setup a texture from our model
 */
- (BOOL) loadGLTextureFromFile:(NSString*)filename atIndex:(int)texIndex
{
	BOOL success = FALSE;
	NSBitmapImageRep *theImage;
	int bitsPPixel, bytesPRow;
	unsigned char *theImageData;
	int rowNum, destRowNum;
	
	theImage = [ NSBitmapImageRep imageRepWithContentsOfFile:[ NSString stringWithFormat:@"%@/%@",
															  [ [ NSBundle mainBundle ] resourcePath ],
															  filename ] ];
	if( theImage != nil )
	{
		bitsPPixel = [ theImage bitsPerPixel ];
		bytesPRow = [ theImage bytesPerRow ];
		GLenum texFormat;
		if( bitsPPixel == 24 )        // No alpha channel
			texFormat = GL_RGB;
		else if( bitsPPixel == 32 )   // There is an alpha channel
			texFormat = GL_RGBA;
		NSSize texSize = NSMakeSize(theImage.pixelsWide, theImage.pixelsHigh);
		char* texBytes = calloc( bytesPRow * texSize.height,
								1 );
		if( texBytes != NULL )
		{
			success = TRUE;
			theImageData = [ theImage bitmapData ];
			destRowNum = 0;
			for( rowNum = texSize.height - 1; rowNum >= 0;
				rowNum--, destRowNum++ )
			{
				// Copy the entire row in one shot
				memcpy( texBytes + ( destRowNum * bytesPRow ),
					   theImageData + ( rowNum * bytesPRow ),
					   bytesPRow );
			}
			
			glGenTextures( 1, &texture[ texIndex ] );   // Create the texture
			
			// Typical texture generation using data from the bitmap
			glBindTexture( GL_TEXTURE_2D, texture[ texIndex ] );
			
			glTexImage2D( GL_TEXTURE_2D, 0, 3, texSize.width,
						 texSize.height, 0, texFormat,
						 GL_UNSIGNED_BYTE, texBytes );
			// Linear filtering
			glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
			glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
			
			free( texBytes );
			
		}
		
	}
	
	return success;
}

-(void)dealloc {
	CVDisplayLinkStop(displayLink);
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[self render];
}

-(void)prepareOpenGL {
	// Create a display link capable of being used with all active displays
    CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);
	
	
    // Set the renderer output callback function
    CVDisplayLinkSetOutputCallback(displayLink, &MyDisplayLinkCallback, (__bridge void*)self);
	
    // Set the display link for the current renderer
    CGLContextObj cglContext = [[self openGLContext] CGLContextObj];
    CGLPixelFormatObj cglPixelFormat = [[self pixelFormat] CGLPixelFormatObj];
    CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink, cglContext, cglPixelFormat);
	
	CGLError err =  CGLEnable( cglContext, kCGLCEMPEngine);
	
	if (err != kCGLNoError )
	{
		NSLog(@"Multithreaded execution may not be available");
		// Insert your code to take appropriate action
	}
	
	
	//[self loadGLTextureFromFile:@"2011-11-07 23.41.02.png" atIndex:0];
	//[self loadGLTextureFromComputingAtIndex:0];
	glEnable( GL_TEXTURE_2D );                // Enable texture mapping
	glShadeModel( GL_SMOOTH );                // Enable smooth shading
	glClearColor( 0.0f, 0.0f, 0.0f, 0.5f );   // Black background
	// Really nice perspective calculations
	glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST );

	NSLog(@"%s over", __PRETTY_FUNCTION__);
	inc = 4;
}

-(void)start {
	// Activate the display link
    CVDisplayLinkStart(displayLink);
	
}

-(void)render {
	CGLContextObj ctx = [self.openGLContext CGLContextObj];
	CGLLockContext(ctx);
	
	[self.openGLContext makeCurrentContext];
	// Clear the screen buffer
	glClear( GL_COLOR_BUFFER_BIT );
	glLoadIdentity();   // Reset the current modelview matrix
	
	glTranslatef( x, 0.0, -1 );      // Move into screen 5 units
	
	glBindTexture( GL_TEXTURE_2D, texture[ 0 ] );   // Select our texture
	
	[self drawQuad2:NSMakeRect(0, 0, 2929 * 4, 200)];
	
	glFlush();
	
	CGLUnlockContext(ctx);
	
	if (self.player != nil) {
		CMTime t = self.player.currentTime;
		x = -t.value * 25 * 4 / t.timescale;
	}
/*	x -= inc;
	if (x <  -200) {
		x = self.bounds.size.width;
	}
	else if (x>self.bounds.size.width) {
		x = 0;
	}*/
}


// This is the renderer output callback function
static CVReturn MyDisplayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp* now, const CVTimeStamp* outputTime,
									  CVOptionFlags flagsIn, CVOptionFlags* flagsOut, void* displayLinkContext)
{
	@autoreleasepool {
		
		DWOpenGLView * view = (__bridge DWOpenGLView*)displayLinkContext;
		
		//[view performSelectorOnMainThread:@selector(render) withObject:nil waitUntilDone:NO];
		[view render];
	}

	return kCVReturnSuccess;
}


-(void)reshape {
	NSLog(@"%s", __PRETTY_FUNCTION__);
	CGLContextObj ctx = [self.openGLContext CGLContextObj];
	CGLLockContext(ctx);
	//	NSLog(@"%s : %@", __PRETTY_FUNCTION__, NSStringFromRect(self.bounds));
	NSSize sceneSize;
	
	[ [ self openGLContext ] update ];
	sceneSize = self.bounds.size;
	// Reset current viewport
	glViewport( 0, 0, sceneSize.width, sceneSize.height );
	glMatrixMode( GL_PROJECTION );   // Select the projection matrix
	glLoadIdentity();                // and reset it
	glOrtho(0, sceneSize.width, 0, sceneSize.height, 0, 1000);
	
	glMatrixMode( GL_MODELVIEW );    // Select the modelview matrix
	glLoadIdentity();                // and reset it
	
	CGLUnlockContext(ctx);
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void)drawQuad2:(NSRect)rect {
	glBegin( GL_QUADS );
	
	glTexCoord2f( 1.0f, 0.0f );
	glVertex2f( rect.origin.x, rect.origin.y);   // Bottom left
	glTexCoord2f( 1.0f, 1.0f );
	glVertex2f(  rect.origin.x + rect.size.width, rect.origin.y);   // Bottom right
	glTexCoord2f( 0.0f, 1.0f );
	glVertex2f(  rect.origin.x + rect.size.width, rect.origin.y + rect.size.height );   // Top right
	glTexCoord2f( 0.0f, 0.0f );
	glVertex2f( rect.origin.x, rect.origin.y + rect.size.height );   // Top left
	
	glEnd();
	
}

-(void)drawQuad:(NSRect)rect {
	glBegin( GL_QUADS );
	
	glTexCoord2f( 0.0f, 0.0f );
	glVertex2f( rect.origin.x, rect.origin.y);   // Bottom left
	glTexCoord2f( 1.0f, 0.0f );
	glVertex2f(  rect.origin.x + rect.size.width, rect.origin.y);   // Bottom right
	glTexCoord2f( 1.0f, 1.0f );
	glVertex2f(  rect.origin.x + rect.size.width, rect.origin.y + rect.size.height );   // Top right
	glTexCoord2f( 0.0f, 1.0f );
	glVertex2f( rect.origin.x, rect.origin.y + rect.size.height );   // Top left
	
	glEnd();
	
}

@end
