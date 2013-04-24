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
    NSLog(@"ElementName: %@ in uri: %@ withQName: %@ andDict: %@", elementName, namespaceURI, qualifiedName, attributeDict);
    
    // create a new node in our document
    CBXMLNode *current = [CBXMLNode nodeWithName:elementName andAttributes:attributeDict];
    [_openNodes addObject:current];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"Found chars: %@", string);
    [_captured appendString:string];
    NSLog(@"Got 'em: %@", _captured);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    // trim our string
    NSLog(@"pre-trim: '%@'", _captured);
    _captured = [[_captured stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
    NSLog(@"post-trim: '%@'", _captured);

    if([_captured length] == 0) {
        _captured = nil;
    }
    
    NSLog(@"CAPTURED: '%@'", _captured);
    
    CBXMLNode *current = [_openNodes lastObject];
    
    if(_captured != nil) {
        [current setNodeValue:[NSString stringWithString:_captured]];        
    }
    
    NSLog(@"CAPTURED_POST: %@", current);
    
    // add this to its parent (or root if none)
    if([_openNodes count] > 1) {
        [(CBXMLNode*)[_openNodes objectAtIndex:_openNodes.count-2] addChild:current];
    } else {
        [_children addObject:current];
    }
    
    NSLog(@"Ended element: %@", current);

    // TODO: add this node to the document (or open element)
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
