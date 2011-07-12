//
//  EventFactory.m
//  MacOSNativeEvent
//
//  Created by François Reynaud on 12/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventFactory.h"
#import "AUT.h"


@implementation EventFactory


+ (void) initialize {
    safariMenuHeigth = 72;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (id) initWithApplication: (AUT*) app {
    
    self = [super init];
    if (self) {
        self->app = app;
    }
    return self;
}



- (CGEventRef) mouseDown: (int)x onY:(int)y {
    CGEventRef CGEvent;
    NSEvent *customEvent;
    NSRect screen = [[NSScreen mainScreen]frame];
    NSSize size= screen.size;
    
    int maxX = size.width; 
    int maxY = size.height;
    
    
    int offsetY = maxY - safariMenuHeigth - y;
    NSPoint point = {x,offsetY};
    
    NSDate * past = [NSDate date];
    NSTimeInterval current = [past timeIntervalSince1970];
   
    customEvent = [NSEvent mouseEventWithType: NSLeftMouseDown
                                     location: point 
                                modifierFlags: NSCommandKeyMask
                                    timestamp: current
                                 windowNumber: [app windowId]
                                      context: nil
                                  eventNumber: 0
                                   clickCount: 1
                                     pressure: 0];
    
    CGEvent = [customEvent CGEvent];
    return CGEvent;
    
}

- (CGEventRef) mouseUp: (int)x onY:(int)y {
    CGEventRef *CGEvent;
    NSEvent *customEvent;
    NSRect screen = [[NSScreen mainScreen]frame];
    NSSize size= screen.size;
    
    int maxX = size.width; 
    int maxY = size.height;
    
    
    int offsetY = maxY - safariMenuHeigth - y;
    NSPoint point = {x,offsetY};
    
    NSDate * past = [NSDate date];
    NSTimeInterval current = [past timeIntervalSince1970];
    
    customEvent = [NSEvent mouseEventWithType: NSLeftMouseUp
                                     location: point 
                                modifierFlags: NSCommandKeyMask
                                    timestamp: current
                                 windowNumber: [app windowId]
                                      context: nil
                                  eventNumber: 0
                                   clickCount: 1
                                     pressure: 0];
    
    CGEvent = [customEvent CGEvent];
    return CGEvent;
}





- (void)dealloc
{
    [super dealloc];
}

@end
