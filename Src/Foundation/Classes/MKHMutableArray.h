//
//  MKHMutableArray.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 28/03/14.
//  Copyright (c) 2014 Maxim Khatskevich. All rights reserved.
//

#import <Foundation/Foundation.h>

//===

@class MKHMutableArray;
@class MKHMAResetParamSet;
@class MKHMAChangeParamSet;

//===

typedef enum
{
    kInsertionMKHMAChangeType,
    kRemovalMKHMAChangeType,
    kReplacementMKHMAChangeType
    
} MKHMAChangeType;

//===

typedef BOOL(^MKHMAEqualityCheckBlock)(id leftObject, id rightObject);
typedef void(^MKHMAResetNotificationBlock)(MKHMAResetParamSet *params);
typedef void(^MKHMAChangeNotificationBlock)(MKHMAChangeParamSet *params);

//===

@interface MKHMAResetParamSet : NSObject

@property (readonly, strong, nonatomic) MKHMutableArray *array;
@property (readonly, copy, nonatomic) NSArray *previousValues;
@property (readonly, copy, nonatomic) NSArray *targetValues;

@end

//===

@interface MKHMAChangeParamSet : NSObject

@property (readonly, strong, nonatomic) MKHMutableArray *array;
@property (readonly) MKHMAChangeType changeType;
@property (readonly) NSUInteger targetIndex;
@property (readonly, strong, nonatomic) id previousValue;
@property (readonly, strong, nonatomic) id targetValue;

@end

//===

@interface MKHMutableArray : NSMutableArray

// pagination support:
@property NSUInteger totalCount;
@property (readonly) BOOL moreItemsAvailalbe;

@property (readonly, nonatomic) NSArray *selection;
@property (readonly, nonatomic) id selectedObject;

// indesxes of all selected objects:
@property (readonly) NSIndexSet *selectedObjectsIndexSet;
// index of FIRST selected object, if any:
@property (readonly) NSUInteger selectedObjectIndex;

@property (nonatomic, copy) MKHMAEqualityCheckBlock onEqualityCheck;

- (void)setObjectsFromArray:(NSArray *)otherArray;

- (void)addToSelectionObject:(id)object;
- (void)addToSelectionObjectAtIndex:(NSUInteger)index;
- (void)addToSelectionObjects:(NSArray *)objectList;

- (void)setSelectedObject:(id)object;
- (void)setSelectedObjectAtIndex:(NSUInteger)index;
- (void)setSelectedObjects:(NSArray *)objectList;

- (void)removeFromSelectionObject:(id)object;
- (void)removeFromSelectionObjectAtIndex:(NSUInteger)index;
- (void)removeFromSelectionObjects:(NSArray *)objectList;

- (void)resetSelection;

- (void)subscribe:(id)subscriber onWillResetContent:(MKHMAResetNotificationBlock)notificationBlock;
- (void)subscribe:(id)subscriber onDidResetContent:(MKHMAResetNotificationBlock)notificationBlock;

- (void)subscribe:(id)subscriber onWillChangeContent:(MKHMAChangeNotificationBlock)notificationBlock;
- (void)subscribe:(id)subscriber onDidChangeContent:(MKHMAChangeNotificationBlock)notificationBlock;
- (void)subscribe:(id)subscriber onWillChangeSelection:(MKHMAChangeNotificationBlock)notificationBlock;
- (void)subscribe:(id)subscriber onDidChangeSelection:(MKHMAChangeNotificationBlock)notificationBlock;

- (void)unsubscribe:(id)subscriber;

@end
