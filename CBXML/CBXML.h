//
//  CBXML.h
//  CBXML
//
//  Created by Chris on 4/23/13.
//  Copyright (c) 2013 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBXMLDocument.h"
#import "CBXMLNode.h"

@interface CBXML : NSObject

+ (CBXMLDocument*) parseXML:(NSString*)xmlString;

@end
