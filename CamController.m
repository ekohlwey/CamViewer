/*
 * Copyright 2011 Edmund Kohlwey
 *
 * This file is licensed you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "CamController.h"


@implementation CamController

-(void)beginCapture: (QTCaptureDevice *) device
{
	mCaptureSession = [[QTCaptureSession alloc] init];
	BOOL success = NO;
	NSError *error;
	if (device){
		success = [device open:&error];
		if(!success){
			//TODO error handling
		}
		mCaptureInput = [[QTCaptureDeviceInput alloc] initWithDevice:device];
		success = [mCaptureSession addInput:mCaptureInput error:&error];
		if(!success){
			//TODO error handling
		}
		[mCaptureView setCaptureSession:mCaptureSession];
		[mCaptureSession startRunning];
	} else {
		//TODO - error handling
	}	
}

-(void)stopCapture
{
	[mCaptureSession stopRunning];
	[[mCaptureInput device] close];
}

-(void) windowClosing:(id) sender
{
	[self stopCapture];
	[NSApp terminate: sender];
}

-(void)dealloc
{
	[mCaptureSession release];
	[mCaptureInput release];
	[super dealloc];
}

-(void)awakeFromNib
{
	QTCaptureDevice *device = [QTCaptureDevice defaultInputDeviceWithMediaType:QTMediaTypeVideo];
	[self beginCapture:device];
	[mWindow setLevel:NSScreenSaverWindowLevel];
}


@end
