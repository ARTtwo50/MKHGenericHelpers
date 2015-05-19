//
//  MKHMutableArray.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 28/03/14.
//  Copyright (c) 2014 Maxim Khatskevich. All rights reserved.
//

#import "MKHMutableArray.h"

#import "MKHMacros.h"
#import "NSArray+MKHGenericHelpers.h"
#import "NSMutableArray+MKHGenericHelpers.h"
#import "NSObject+MKHDynamicMaps.h"
#import "MKHArrayItemWrapper.h"

//===

@interface MKHMAChangeParamSet ()

@property (strong, nonatomic) MKHMutableArray *array;
@property MKHMAChangeType changeType;
@property NSUInteger targetIndex;
@property (strong, nonatomic) id previousValue;
@property (strong, nonatomic) id targetValue;

@end

@implementation MKHMAChangeParamSet

@end

//===

@interface MKHMutableArray ()

// backing store
@property (strong, nonatomic) NSMutableArray *store;

@property (readonly, nonatomic) NSMapTable *willChangeContentSubscriptions;
@property (readonly, nonatomic) NSMapTable *didChangeContentSubscriptions;
@property (readonly, nonatomic) NSMapTable *willChangeSelectionSubscriptions;
@property (readonly, nonatomic) NSMapTable *didChangeSelectionSubscriptions;

@end

@implementation MKHMutableArray
{
    BOOL _batchUpdate;
}

#pragma mark - Overrided methods

- (instancetype)init
{
    self = [super init];
    
    //===
    
    if (self)
    {
        self.store = [NSMutableArray array];
        
        [self setup];
    }
    
    //===
    
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems
{
    self = [super init];
    
    //===
    
    if (self)
    {
        self.store = [NSMutableArray arrayWithCapacity:numItems];
        
        [self setup];
    }
    
    //===
    
    return self;
}

- (instancetype)initWithObjects:(const id [])objects
                          count:(NSUInteger)count
{
    self = [super init];
    
    //===
    
    if (self)
    {
        self.store = [NSMutableArray array];
        
        for (int i = 0; i < count; i++)
        {
            [self.store addObject:
             [MKHArrayItemWrapper wrapperWithContent:objects[i]]];
        }
        
        [self setup];
    }
    
    //===
    
    return self;
}

#pragma mark - Overrided methods - NSArray

- (NSUInteger)count
{
    return self.store.count;
}

- (id)objectAtIndex:(NSUInteger)index
{
    return ((MKHArrayItemWrapper *)[self.store safeObjectAtIndex:index]).content;
}

#pragma mark - Overrided methods - NSMutableArray

- (void)addObject:(id)anObject
{
    if (anObject)
    {
        MKHMAChangeParamSet *params = [MKHMAChangeParamSet new];
        
        params.array = self;
        params.changeType = kInsertionMKHMAChangeType;
        params.targetIndex = self.count; // !!!
        params.targetValue = anObject;
        
        //===
        
        [self willChangeContentWithParams:params];
        
        //===
        
        [self.store addObject:
         [MKHArrayItemWrapper wrapperWithContent:anObject]];
        
        //===
        
        [self didChangeContentWithParams:params];
    }
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject &&
        (self.count <= index))
    {
        MKHMAChangeParamSet *params = [MKHMAChangeParamSet new];
        
        params.array = self;
        params.changeType = kInsertionMKHMAChangeType;
        params.targetIndex = index;
        params.targetValue = anObject;
        
        //===
        
        [self willChangeContentWithParams:params];
        
        //===
        
        MKHArrayItemWrapper *newWrapper = [MKHArrayItemWrapper wrapperWithContent:anObject];
        
        [self.store
         insertObject:newWrapper
         atIndex:index];
        
        //===
        
        [self didChangeContentWithParams:params];
    }
}

- (void)removeLastObject
{
    MKHArrayItemWrapper *targetWrapper = [self.store lastObject];
    
    //===
    
    if (targetWrapper)
    {
        MKHMAChangeParamSet *params = [MKHMAChangeParamSet new];
        
        params.array = self;
        params.changeType = kRemovalMKHMAChangeType;
        params.targetIndex = (self.count - 1);
        params.previousValue = targetWrapper.content;
        
        //===
        
        if (targetWrapper.selected)
        {
            [self willChangeSelectionWithParams:params];
            
            //===
            
            targetWrapper.selected = NO;
            
            //===
            
            [self didChangeSelectionWithParams:params];
        }
        
        //===
        
        [self willChangeContentWithParams:params];
        
        //===
        
        [self.store removeLastObject];
        
        //===
        
        [self didChangeContentWithParams:params];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    MKHArrayItemWrapper *targetWrapper = [self.store safeObjectAtIndex:index];
    
    //===
    
    if (targetWrapper)
    {
        MKHMAChangeParamSet *params = [MKHMAChangeParamSet new];
        
        params.array = self;
        params.changeType = kRemovalMKHMAChangeType;
        params.targetIndex = index;
        params.previousValue = targetWrapper.content;
        
        //===
        
        if (targetWrapper.selected)
        {
            [self willChangeSelectionWithParams:params];
            
            //===
            
            targetWrapper.selected = NO;
            
            //===
            
            [self didChangeSelectionWithParams:params];
        }
        
        //===
        
        [self willChangeContentWithParams:params];
        
        //===
        
        [self.store removeObjectAtIndex:index];
        
        //===
        
        [self didChangeContentWithParams:params];
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (anObject)
    {
        MKHArrayItemWrapper *currentWrapper = [self.store safeObjectAtIndex:index];
        
        //===
        
        if (currentWrapper)
        {
            MKHMAChangeParamSet *params = [MKHMAChangeParamSet new];
            
            params.array = self;
            params.changeType = kReplacementMKHMAChangeType;
            params.targetIndex = index;
            params.previousValue = currentWrapper.content;
            params.targetValue = anObject;
            
            //===
            
            BOOL wasSelected = currentWrapper.selected;
            MKHArrayItemWrapper *newWrapper = [MKHArrayItemWrapper wrapperWithContent:anObject];
            
            //===
            
            if (wasSelected)
            {
                [self willChangeSelectionWithParams:params];
            }
            
            [self willChangeContentWithParams:params];
            
            //===
            
            if (wasSelected)
            {
                currentWrapper.selected = NO;
                newWrapper.selected = YES;
            }
            
            [self.store
             replaceObjectAtIndex:index
             withObject:newWrapper];
            
            //===
            
            [self didChangeContentWithParams:params];
            
            if (wasSelected)
            {
                [self didChangeSelectionWithParams:params];
            }
        }
    }
}

#pragma mark - Overrided methods

- (void)safeAddUniqueObject:(id)object
{
    // NOTE: completely override!
    
    if (object)
    {
        BOOL canProceed = YES;
        
        //===
        
        for (id item in self)
        {
            if (self.onEqualityCheck(item, object))
            {
                // an equal/same object is found in array,
                // so no need to add new instance, because it should be unique
                
                canProceed = NO;
            }
        }
        
        //===
        
        if (canProceed)
        {
            [self addObject:object];
        }
    }
}

#pragma mark - Property accessors

- (NSMapTable *)willChangeContentSubscriptions
{
    return [self mapForKey:@"willChangeContentSubscriptions"];
}

- (NSMapTable *)didChangeContentSubscriptions
{
    return [self mapForKey:@"didChangeContentSubscriptions"];
}

- (NSMapTable *)willChangeSelectionSubscriptions
{
    return [self mapForKey:@"willChangeSelectionSubscriptions"];
}

- (NSMapTable *)didChangeSelectionSubscriptions
{
    return [self mapForKey:@"didChangeSelectionSubscriptions"];
}

- (BOOL)moreItemsAvailalbe
{
    return (self.totalCount > self.count);
}

- (NSArray *)selection
{
    NSMutableArray *result = [NSMutableArray array];
    
    //===
    
    for (MKHArrayItemWrapper *wrapper in self.store)
    {
        if (wrapper.selected)
        {
            [result addObject:wrapper.content];
        }
    }
    
    //===
    
    return [result copy];
}

- (id)selectedObject
{
    return self.selection.firstObject;
}

- (NSUInteger)selectedObjectIndex
{
    NSUInteger result = NSNotFound;
    
    //===
    
    for (NSUInteger i = 0; i < self.store.count; i++)
    {
        MKHArrayItemWrapper *wrapper = self.store[i];
        
        if (wrapper.selected)
        {
            result = i;
            break;
        }
    }
    
    //===
    
    return result;
}

- (NSIndexSet *)selectedObjectsIndexSet
{
    NSMutableIndexSet *result = [NSMutableIndexSet indexSet];
    
    //===
    
    for (NSUInteger i = 0; i < self.store.count; i++)
    {
        MKHArrayItemWrapper *wrapper = self.store[i];
        
        if (wrapper.selected)
        {
            [result addIndex:i];
        }
    }
    
    //===
    
    return [result copy];
}

#pragma mark - Custom

- (void)setup
{
    _batchUpdate = NO;
    
    self.onEqualityCheck = ^(id firstObject, id secondObject) {
        
        return [firstObject isEqual:secondObject];
    };
    
    self.totalCount = 0;
}

#pragma mark - Add to selection

- (void)addToSelectionObject:(id)newObject
{
    if (newObject)
    {
        MKHArrayItemWrapper *targetWrapper = nil;
        NSUInteger targetIndex = NSNotFound;
        
        //===
        
        for (NSUInteger i = 0; i < self.store.count; i++)
        {
            MKHArrayItemWrapper *wrapper = self.store[i];
            
            if (self.onEqualityCheck(wrapper.content, newObject))
            {
                targetWrapper = wrapper;
                targetIndex = i;
                break;
            }
        }
        
        //===
        
        if (targetWrapper &&
            !targetWrapper.selected)
        {
            MKHMAChangeParamSet *params = [MKHMAChangeParamSet new];
            
            params.array = self;
            params.changeType = kInsertionMKHMAChangeType;
            params.targetIndex = targetIndex;
            params.targetValue = newObject;
            
            //===
            
            [self willChangeSelectionWithParams:params];
            
            //===
            
            targetWrapper.selected = YES;
            
            //===
            
            [self didChangeSelectionWithParams:params];
        }
    }
}

- (void)addToSelectionObjectAtIndex:(NSUInteger)index
{
    MKHArrayItemWrapper *targetWrapper = [self.store safeObjectAtIndex:index];
    
    //===
    
    if (targetWrapper &&
        !targetWrapper.selected)
    {
        MKHMAChangeParamSet *params = [MKHMAChangeParamSet new];
        
        params.array = self;
        params.changeType = kInsertionMKHMAChangeType;
        params.targetIndex = index;
        params.targetValue = targetWrapper.content;
        
        //===
        
        [self willChangeSelectionWithParams:params];
        
        //===
        
        targetWrapper.selected = YES;
        
        //===
        
        [self didChangeSelectionWithParams:params];
    }
}

- (void)addToSelectionObjects:(NSArray *)objectList
{
    for (id object in objectList)
    {
        [self addToSelectionObject:object];
    }
}

#pragma mark - Set selection

- (void)setSelectedObject:(id)object
{
    NSArray *selection = self.selection;
    
    //===
    
    BOOL alreadySelected = NO;
    BOOL otherSelectedObjects = NO;
    
    for (id selectedObject in selection)
    {
        if (self.onEqualityCheck(selectedObject, object))
        {
            alreadySelected = YES;
            break;
        }
        else
        {
            otherSelectedObjects = YES;
        }
    }
    
    //===
    
    if (!alreadySelected || otherSelectedObjects)
    {
        [self resetSelection];
        
        //===
        
        [self addToSelectionObject:object];
    }
}

- (void)setSelectedObjectAtIndex:(NSUInteger)index
{
    NSArray *selection = self.selection;
    
    //===
    
    MKHArrayItemWrapper *targetWrapper = [self.store safeObjectAtIndex:index];
    BOOL otherSelectedObjects = (selection.count > 1);
    
    //===
    
    if (targetWrapper)
    {
        if (!targetWrapper.selected || otherSelectedObjects)
        {
            [self resetSelection];
            
            //===
            
            [self addToSelectionObjectAtIndex:index];
        }
    }
}

- (void)setSelectedObjects:(NSArray *)newSelection
{
    NSArray *selection = self.selection;
    
    //===
    
    if (newSelection.count)
    {
        // lets check if current and target selection objects are identical?
        
        NSMutableArray *newSelectionCopy = [NSMutableArray arrayWithArray:newSelection];
        NSMutableArray *selectionCopy = [NSMutableArray arrayWithArray:selection];
        
        for (id selectedObject in selection)
        {
            // we should check each item with each item in the other array
            
            for (id targetObject in newSelection)
            {
                if (self.onEqualityCheck(selectedObject, targetObject)) // !!!
                {
                    [newSelectionCopy removeObject:targetObject];
                    [selectionCopy removeObject:selectedObject];
                }
            }
        }
        
        //===
        
        // proceed if NOT fully identical
        
        if (newSelectionCopy.count || selectionCopy.count)
        {
            [self resetSelection];
            
            //===
            
            for (id newSelectedObject in newSelection)
            {
                [self addToSelectionObject:newSelectedObject];
            }
        }
    }
}

#pragma mark - Remove from selection

- (void)removeFromSelectionObject:(id)object
{
    if (object)
    {
        MKHArrayItemWrapper *targetWrapper = nil;
        NSUInteger targetIndex = NSNotFound;
        
        //===
        
        for (NSUInteger i = 0; i < self.store.count; i++)
        {
            MKHArrayItemWrapper *wrapper = self.store[i];
            
            if (self.onEqualityCheck(wrapper.content, object))
            {
                targetWrapper = wrapper;
                targetIndex = i;
                break;
            }
        }
        
        //===
        
        if (targetWrapper.selected)
        {
            MKHMAChangeParamSet *params = [MKHMAChangeParamSet new];
            
            params.array = self;
            params.changeType = kRemovalMKHMAChangeType;
            params.targetIndex = (self.count - 1);
            params.previousValue = targetWrapper.content;
            
            //===
            
            [self willChangeSelectionWithParams:params];
            
            //===
            
            targetWrapper.selected = NO;
            
            //===
            
            [self didChangeSelectionWithParams:params];
        }
    }
}

- (void)removeFromSelectionObjectAtIndex:(NSUInteger)index
{
    MKHArrayItemWrapper *targetWrapper = [self.store safeObjectAtIndex:index];
    
    //===
    
    if (targetWrapper.selected)
    {
        MKHMAChangeParamSet *params = [MKHMAChangeParamSet new];
        
        params.array = self;
        params.changeType = kRemovalMKHMAChangeType;
        params.targetIndex = (self.count - 1);
        params.previousValue = targetWrapper.content;
        
        //===
        
        [self willChangeSelectionWithParams:params];
        
        //===
        
        targetWrapper.selected = NO;
        
        //===
        
        [self didChangeSelectionWithParams:params];
    }
}

- (void)removeFromSelectionObjects:(NSArray *)objectList
{
    for (id object in objectList)
    {
        [self removeFromSelectionObject:object];
    }
}

- (void)resetSelection
{
    for (NSUInteger i = 0; i < self.store.count; i++)
    {
        MKHArrayItemWrapper *targetWrapper = self.store[i];
        
        if (targetWrapper.selected)
        {
            MKHMAChangeParamSet *params = [MKHMAChangeParamSet new];
            
            params.array = self;
            params.changeType = kRemovalMKHMAChangeType;
            params.targetIndex = i;
            params.previousValue = targetWrapper.content;
            
            //===
            
            [self willChangeSelectionWithParams:params];
            
            //===
            
            targetWrapper.selected = NO;
            
            //===
            
            [self didChangeSelectionWithParams:params];
        }
    }
}

#pragma mark - Notifications - Public

- (void)subscribe:(id)subscriber onWillChangeContent:(MKHMAChangeNotificationBlock)notificationBlock
{
    [self
     addNotification:notificationBlock
     subscriber:subscriber
     targetTable:self.willChangeContentSubscriptions];
}

- (void)subscribe:(id)subscriber onDidChangeContent:(MKHMAChangeNotificationBlock)notificationBlock
{
    [self
     addNotification:notificationBlock
     subscriber:subscriber
     targetTable:self.didChangeContentSubscriptions];
}

- (void)subscribe:(id)subscriber onWillChangeSelection:(MKHMAChangeNotificationBlock)notificationBlock
{
    [self
     addNotification:notificationBlock
     subscriber:subscriber
     targetTable:self.willChangeSelectionSubscriptions];
}

- (void)subscribe:(id)subscriber onDidChangeSelection:(MKHMAChangeNotificationBlock)notificationBlock
{
    [self
     addNotification:notificationBlock
     subscriber:subscriber
     targetTable:self.didChangeSelectionSubscriptions];
}

- (void)unsubscribe:(id)subscriber
{
    [self
     remove:subscriber
     fromTable:self.willChangeContentSubscriptions];

    [self
     remove:subscriber
     fromTable:self.didChangeContentSubscriptions];
    
    [self
     remove:subscriber
     fromTable:self.willChangeSelectionSubscriptions];
    
    [self
     remove:subscriber
     fromTable:self.didChangeSelectionSubscriptions];
}

#pragma mark - Notifications - Private - Manage

- (void)addNotification:(id)notificationBlock
             subscriber:(id)subscriber
            targetTable:(NSMapTable *)targetTable
{
    if (notificationBlock && subscriber && targetTable)
    {
        [targetTable
         setObject:notificationBlock
         forKey:subscriber];
    }
}

- (void)remove:(id)subscriber fromTable:(NSMapTable *)targetTable
{
    [targetTable removeObjectForKey:subscriber];
}

#pragma mark - Notifications - Private - Send notifications

- (void)notifyAboutChangeWithTable:(NSMapTable *)targetTable
                            params:(MKHMAChangeParamSet *)params
{
    if (!_batchUpdate)
    {
        for (id key in [[targetTable keyEnumerator] allObjects])
        {
            MKHMAChangeNotificationBlock block = [targetTable objectForKey:key];
            
            if (block)
            {
                block(params);
            }
        }
    }
}

- (void)willChangeContentWithParams:(MKHMAChangeParamSet *)params
{
    [self
     notifyAboutChangeWithTable:self.willChangeContentSubscriptions
     params:params];
}

- (void)didChangeContentWithParams:(MKHMAChangeParamSet *)params
{
    [self
     notifyAboutChangeWithTable:self.didChangeContentSubscriptions
     params:params];
}

- (void)willChangeSelectionWithParams:(MKHMAChangeParamSet *)params
{
    [self
     notifyAboutChangeWithTable:self.willChangeSelectionSubscriptions
     params:params];
}

- (void)didChangeSelectionWithParams:(MKHMAChangeParamSet *)params
{
    [self
     notifyAboutChangeWithTable:self.didChangeSelectionSubscriptions
     params:params];
}

@end
