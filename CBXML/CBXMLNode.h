//
//  CBXMLNode.h
//  CBXML
//
//  Created by Chris on 4/23/13.
//  Copyright (c) 2013 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBXMLNode : NSObject

+ (CBXMLNode*) nodeWithName:(NSString*)nodeName andAttributes:(NSDictionary*)attributes;

@property (nonatomic, strong) NSString *nodeName;
@property (nonatomic, strong) NSString *nodeValue;
@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, strong) NSMutableArray *children;

- (void) addChild:(CBXMLNode*)child;

@end
