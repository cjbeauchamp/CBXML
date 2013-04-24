//
//  CBXMLDocument.h
//  CBXML
//
//  Created by Chris on 4/23/13.
//  Copyright (c) 2013 Chris Beauchamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBXMLDocument : NSObject
<NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *children;

@end
