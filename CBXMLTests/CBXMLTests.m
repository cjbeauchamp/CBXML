//
//  CBXMLTests.m
//  CBXMLTests
//
//  Created by Chris on 4/23/13.
//  Copyright (c) 2013 Chris Beauchamp. All rights reserved.
//

#import "CBXMLTests.h"

#import "CBXML.h"

@implementation CBXMLTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{

    NSString *testString = @"<root> \
    <child1> \
    <child1_a attr='attr'/> \
    <child1_b>node value</child1_b> \
    </child1> \
    </root>";
    
    CBXMLDocument *doc = [CBXML parseXML:testString];
    
    // get the root node
    CBXMLNode *root = [[doc children] objectAtIndex:0];
    STAssertEqualObjects(root.nodeName, @"root", nil);
    STAssertTrue(root.children.count == 1, nil);
    
    // get the child1 node
    CBXMLNode *child1 = [root.children objectAtIndex:0];
    STAssertEqualObjects(child1.nodeName, @"child1", nil);
    STAssertTrue(child1.children.count == 2, nil);
    
    // get the child1_a node
    CBXMLNode *child1a = [child1.children objectAtIndex:0];
    STAssertEqualObjects(child1a.nodeName, @"child1_a", nil);
    STAssertTrue(child1a.children.count == 0, nil);
    STAssertTrue(child1a.attributes.count == 1, nil);
    STAssertEqualObjects([child1a.attributes objectForKey:@"attr"], @"attr", nil);
    
    // get the child1_b node
    CBXMLNode *child1b = [child1.children objectAtIndex:1];
    STAssertEqualObjects(child1b.nodeName, @"child1_b", nil);
    STAssertTrue(child1b.children.count == 0, nil);
    STAssertEqualObjects(child1b.attributes, nil, nil);
    STAssertEqualObjects(child1b.nodeValue, @"node value", nil);
    
}

@end
