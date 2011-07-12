//
//  main.m
//  MacOSNativeEvent
//
//  Created by François Reynaud on 11/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/objc-auto.h>
#import "AUT.h"
#import "HTTPServer.h"

int main (int argc, const char * argv[])
{
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
   /*    NSLog(@"Hello, World!");
    [[HTTPServer sharedHTTPServer] start];
    [[NSRunLoop mainRunLoop] run]; 
    [pool drain];
    return 0;
    */
    
    objc_startCollectorThread();
    
    //NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    // insert code here...
    NSLog(@"Hello, World!");
   
    NSArray *arguments = [NSArray arrayWithObjects: @"af5748c6-5c80-44f0-a019-26856ecab8a1.html", nil];
    AUT *safari = [[AUT alloc] initWithParam:arguments];
    [safari start];
        
    
    AUT *safari2 = [AUT getApplicationForSession:@"af5748c6-5c80-44f0-a019-26856ecab8a1"];
    NSLog(@"working on safari : %d",[safari2 pid]);
    NSLog(@"on windowId : %d",[safari2 windowId]);
    [safari2 mouseDown:150 onY:120];
    [safari2 mouseUp:150 onY:120];
    
    sleep(5);
    [safari2 stop];
   
    return 0;
}

