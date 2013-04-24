//
//  CBXML.m
//  CBXML
//
//  Created by Chris on 4/23/13.
//  Copyright (c) 2013 Chris Beauchamp. All rights reserved.
//

#import "CBXML.h"

@interface CBXML() {
    
}

@end

@implementation CBXML

- (CBXMLDocument*) documentWithString:(NSString*)xmlString
{
    
    CBXMLDocument *doc = [[CBXMLDocument alloc] init];
    
    NSData *data = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = doc;
    [parser parse];
    
    return doc;
}

+ (CBXMLDocument*) parseXML:(NSString*)xmlString
{
    CBXML *xml = [[CBXML alloc] init];
    return [xml documentWithString:xmlString];
}

@end
