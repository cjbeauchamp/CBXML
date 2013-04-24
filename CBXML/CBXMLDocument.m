//
//  CBXMLDocument.m
//  CBXML
//
//  Created by Chris on 4/23/13.
//  Copyright (c) 2013 Chris Beauchamp. All rights reserved.
//

#import "CBXMLDocument.h"

#import "CBXMLNode.h"

@interface CBXMLDocument() {
    NSMutableString *_captured;
    NSMutableArray *_openNodes;
    NSMutableArray *_children;
}

@end

@implementation CBXMLDocument

@synthesize children = _children;

- (id) init
{
    self = [super init];
    if(self) {
        _captured = [[NSMutableString alloc] init];
        _openNodes = [[NSMutableArray alloc] init];

        _children = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    // create a new node in our document
    CBXMLNode *current = [CBXMLNode nodeWithName:elementName andAttributes:attributeDict];
    [_openNodes addObject:current];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [_captured appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    // trim our string
    _captured = [[_captured stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];

    if([_captured length] == 0) {
        _captured = nil;
    }
        
    CBXMLNode *current = [_openNodes lastObject];
    
    if(_captured != nil) {
        [current setNodeValue:[NSString stringWithString:_captured]];        
    }
        
    // add this to its parent (or root if none)
    if([_openNodes count] > 1) {
        [(CBXMLNode*)[_openNodes objectAtIndex:_openNodes.count-2] addChild:current];
    } else {
        [_children addObject:current];
    }
    
    [_openNodes removeLastObject];
    
    // clear our captured chars
    _captured = nil;
    _captured =  [[NSMutableString alloc] initWithString:@""];
    
}


- (NSString *)description {
    
    NSString *str = @"";
    
    for(CBXMLNode *child in _children) {
        str = [str stringByAppendingFormat:@"%@", child];
    }
    
    return str;
}

@end
