//
//  MKHCollectionCtrl.m
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 14/09/14.
//  Copyright (c) 2014 Maxim Khatskevich. All rights reserved.
//

#import "MKHCollectionCtrl.h"

#import "MKHMutableArray.h"
#import "NSObject+MKHGenericHelpers.h"
#import "NSArray+MKHGenericHelpers.h"

//===

@interface MKHCollectionCtrl ()

@property(strong, nonatomic) NSHashTable *contentStorage;

@end

//===

@implementation MKHCollectionCtrl

#pragma mark - Overrided methods

- (instancetype)init
{
    self = [super init];
    
    //===
    
    if (self)
    {
        self.contentStorage =
        [NSHashTable weakObjectsHashTable];
        
        self.multiselectEnabled = NO;
        self.defaultCellIdentifier = @"Cell";
        self.preloadOffset = 10;
    }
    return self;
}

- (void)configureWithObject:(id)object
{
    [super configureWithObject:object];
    
    //===
    
    if ([UICollectionView isClassOfObject:object])
    {
        ((UICollectionView *)object).dataSource = self;
        ((UICollectionView *)object).delegate = self;
    }
    else if ([MKHCollectionSectionClass isClassOfObject:object])
    {
        [self addSection:object];
    }
    else if ([NSArray isClassOfObject:object])
    {
        for (id item in object)
        {
            if ([MKHCollectionSectionClass isClassOfObject:item])
            {
                [self addSection:item];
            }
        }
    }
}

#pragma mark - Custom

- (void)resetContent
{
    [self.contentStorage removeAllObjects];
}

- (void)addSection:(MKHCollectionSectionClass *)itemList
{
    if ([MKHCollectionSectionClass isClassOfObject:itemList])
    {
        [self.contentStorage addObject:itemList];
    }
}

- (NSUInteger)numberOfItems
{
    return [self numberOfItemsForSectionAtIndex:0];
}

- (NSUInteger)numberOfItemsForSectionAtIndex:(NSUInteger)sectionIndex
{
    NSUInteger result = 0;
    
    //===
    
    MKHCollectionSectionClass *sectionItemList =
    [[self.contentStorage allObjects] safeObjectAtIndex:sectionIndex];
    
    if ([MKHCollectionSectionClass isClassOfObject:sectionItemList])
    {
        // with pagination support:
        
        if (sectionItemList.totalCount > sectionItemList.count)
        {
            result = sectionItemList.totalCount;
        }
        else
        {
            result = sectionItemList.count;
        }
    }
    
    //===
    
    return result;
}

- (NSString *)cellReuseIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    return self.defaultCellIdentifier;
}

- (MKHCollectionSectionClass *)itemListForSectionAtIndex:(NSUInteger)sectionIndex
{
    MKHCollectionSectionClass *result = nil;
    
    //===
    
    MKHCollectionSectionClass *tmp =
    [[self.contentStorage allObjects] safeObjectAtIndex:sectionIndex];
    
    if ([MKHCollectionSectionClass isClassOfObject:tmp])
    {
        result = tmp;
    }
    
    //===
    
    return result;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.contentStorage.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self numberOfItemsForSectionAtIndex:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuseId = nil;
    
    //===
    
    cellReuseId = [self cellReuseIdentifierForIndexPath:indexPath];
    
    UICollectionViewCell *cell   =
    [collectionView
     dequeueReusableCellWithReuseIdentifier:cellReuseId
     forIndexPath:indexPath];
    
    //===
    
    MKHCollectionSectionClass *targetSectionItemList =
    [self itemListForSectionAtIndex:indexPath.section];
    
    id targetItem = [targetSectionItemList safeObjectAtIndex:indexPath.item];
    
    if (self.onConfigureCell)
    {
        self.onConfigureCell(self,
                             indexPath,
                             targetItem,
                             cell);
    }
    else
    {
        // default fallback:
        [cell configureWithObject:targetItem];
    }
    
    //===
    
    if (targetSectionItemList.moreItemsAvailalbe &&
        ((targetSectionItemList.count - indexPath.item) <= self.preloadOffset) &&
        self.onNeedMoreItems)
    {
        self.onNeedMoreItems(self, indexPath.section, targetSectionItemList);
    }
    
    //===
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MKHCollectionSectionClass *targetSectionItemList =
    [self itemListForSectionAtIndex:indexPath.section];
    
    id targetItem = [targetSectionItemList safeObjectAtIndex:indexPath.item];
    
    //===
    
    if (self.isMultiselectEnabled)
    {
        [targetSectionItemList addToSelectionObjectAtIndex:indexPath.item];
    }
    else
    {
        [targetSectionItemList setSelectedObjectAtIndex:indexPath.item];
    }
    
    //===
    
    if (targetItem && self.onDidSelectItem)
    {
        self.onDidSelectItem(self, indexPath, targetItem);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MKHCollectionSectionClass *targetSectionItemList =
    [self itemListForSectionAtIndex:indexPath.section];
    
    if (targetSectionItemList.selectedObjectIndex == indexPath.item)
    {
        id targetItem = [targetSectionItemList safeObjectAtIndex:indexPath.item];
        
        //===
        
        [targetSectionItemList removeFromSelectionObjectAtIndex:indexPath.item];
        
        //===
        
        if (targetItem && self.onDidDeselectItem)
        {
            self.onDidDeselectItem(self, indexPath, targetItem);
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize result = CGSizeZero;
    
    //===
    
    if ([collectionView.collectionViewLayout
         isKindOfClass:UICollectionViewFlowLayout.class])
    {
        result = ((UICollectionViewFlowLayout *)layout).itemSize;
        
        //===
        
        MKHCollectionSectionClass *targetSectionItemList =
        [self itemListForSectionAtIndex:indexPath.section];
        
        if (targetSectionItemList)
        {
            id targetItem = [targetSectionItemList safeObjectAtIndex:indexPath.item];
            
            //===
            
            if (targetItem &&
                self.onSizeForItem)
            {
                result = self.onSizeForItem(self, indexPath, targetItem);
            }
        }
    }
    
    //===
    
    return result;
}

@end
