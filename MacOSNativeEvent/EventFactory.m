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
        eventCount = 0;
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
                                modifierFlags: 0 | NSCommandKeyMask
                                    timestamp: current
                                 windowNumber: [app windowId]
                                      context: nil
                                  eventNumber: ++eventCount
                                   clickCount: 1
                                     pressure: 0];
    
    CGEvent = [customEvent CGEvent];
    CGEventFlags f = CGEventGetFlags(CGEvent);
    return CGEvent;
    
}

- (CGEventRef) mouseUp: (int)x onY:(int)y {
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
    
    customEvent = [NSEvent mouseEventWithType: NSLeftMouseUp
                                     location: point 
                                modifierFlags: 0 //| NSCommandKeyMask
                                    timestamp: current
                                 windowNumber: [app windowId]
                                      context: nil
                                  eventNumber: ++eventCount
                                   clickCount: 1
                                     pressure: 0];
    
    CGEvent = [customEvent CGEvent];
    CGPoint mouseLocation = CGEventGetLocation(CGEvent);
    return CGEvent;
}

- (CGEventRef) mouseDragged: (int)x onY:(int)y {
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
    
    customEvent = [NSEvent mouseEventWithType:NSLeftMouseDragged
                       location:point
                  modifierFlags:0 | NSCommandKeyMask
                      timestamp:current
                   windowNumber: [app windowId]
                        context:nil
                    eventNumber:++eventCount
                     clickCount:1
                       pressure:0];

    usleep(5000);
    CGEvent = [customEvent CGEvent];
    
          
   return CGEvent;
}

- (CGEventRef) mouseMove: (int)x onY:(int)y {
    CGEventRef *CGEvent;
    NSEvent *customEvent;
    NSRect screen = [[NSScreen mainScreen]frame];
    NSSize size= screen.size;
    
    int maxX = size.width; 
    int maxY = size.height;
    
    int offsetY =    y;
    NSPoint point = {x,offsetY};
    
    NSDate * past = [NSDate date];
    NSTimeInterval current = [past timeIntervalSince1970];
    
    customEvent = [NSEvent mouseEventWithType:NSMouseMoved
                                     location:point
                                modifierFlags:0 | NSCommandKeyMask
                                    timestamp:current
                                 windowNumber: [app windowId]
                                      context:nil
                                  eventNumber:++eventCount
                                   clickCount:0
                                     pressure:1];
    
    usleep(10000);
    
    CGEvent = [customEvent CGEvent];
    
    return CGEvent;
}

- (CGEventRef)simulateMouseEvent:(CGEventType)eventType onX:(int)x onY:(int)y
{
    // Get the current mouse position
    // CGEventRef ourEvent = CGEventCreate(NULL);
    NSRect screen = [[NSScreen mainScreen]frame];
    NSSize size= screen.size;
    int maxX = size.width; 
    int maxY = size.height;
    int offsetY = maxY - safariMenuHeigth - y;
    NSPoint p = {x,y};
    CGPoint point = p;
    //CGPoint mouseLocation = {x,y};//CGEventGetLocation(ourEvent);
    
    // Create and post the event
    CGEventRef event = CGEventCreateMouseEvent(NULL, eventType, point, kCGMouseButtonLeft);
    CGEventSetType(event, eventType);
    CGEventSetIntegerValueField(event, kCGMouseEventClickState, 1);
   
    usleep(10000);

    return event;
    //CGEventPost(kCGHIDEventTap, event);
    //CFRelease(event);
}






- (void)dealloc
{
    [super dealloc];
}

@end
