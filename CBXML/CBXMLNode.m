//
//  CBXMLNode.m
//  CBXML
//
//  Created by Chris on 4/23/13.
//  Copyright (c) 2013 Chris Beauchamp. All rights reserved.
//

#import "CBXMLNode.h"

@interface CBXMLNode() {
    NSString *_nodeName;
    NSString *_nodeValue;
    NSDictionary *_attributes;
    NSMutableArray *_children;
}

@end

@implementation CBXMLNode

@synthesize nodeName = _nodeName;
@synthesize nodeValue = _nodeValue;
@synthesize attributes = _attributes;
@synthesize children = _children;

- (void) addChild:(CBXMLNode*)child
{
    [_children addObject:child];
}


- (CBXMLNode*) childWithName:(NSString*)childName
{
    CBXMLNode *child = nil;
    
    for(CBXMLNode *node in _children) {
        if([node.nodeName isEqualToString:childName]) {
            child = node;
            break;
        }
    }
    
    return child;
}

- (id) initWithName:(NSString*)nodeName andAttributes:(NSDictionary*)attributes
{
    self = [super init];
    
    if(self) {
        
        if([attributes count] == 0) {
            attributes = nil;
        }
        
        _children = [[NSMutableArray alloc] init];
        
        _nodeValue = nil;
        _nodeName = nodeName;
        _attributes = attributes;
    }
    
    return self;
}


+ (CBXMLNode*) nodeWithName:(NSString*)nodeName andAttributes:(NSDictionary*)attributes
{
    return [[CBXMLNode alloc] initWithName:nodeName andAttributes:attributes];
}

- (NSString *)description {
    NSString *str = [NSString stringWithFormat: @"Node: Name='%@' Value='%@' Attrs='%@'\n", _nodeName, _nodeValue, _attributes];
    for(CBXMLNode *node in _children) {
        str = [str stringByAppendingFormat:@"\t\t%@\n", node];
    }
    return str;
}

@end
