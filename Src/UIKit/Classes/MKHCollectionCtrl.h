//
//  MKHCollectionCtrl.h
//  MKHGenericHelpers
//
//  Created by Maxim Khatskevich on 14/09/14.
//  Copyright (c) 2014 Maxim Khatskevich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

//===

@class MKHCollectionCtrl;
@class MKHMutableArray;

//===

#define MKHCollectionSectionClass MKHMutableArray

//===

typedef CGSize(^MKHCCSizeForItem)(MKHCollectionCtrl *collectionCtrl,
                                  NSIndexPath *indexPath,
                                  id targetItem);
typedef NSString *(^MKHCCCellReuseId)(MKHCollectionCtrl *collectionCtrl,
                                      NSIndexPath *indexPath,
                                      id targetItem);
typedef void(^MKHCCConfigureCell)(MKHCollectionCtrl *collectionCtrl,
                                  NSIndexPath *indexPath,
                                  id targetItem,
                                  UICollectionViewCell *targetCell);
typedef void(^MKHCCSelectItem)(MKHCollectionCtrl *collectionCtrl,
                               NSIndexPath *indexPath,
                               id targetItem);
typedef void(^MKHCCNeedMoreItems)(MKHCollectionCtrl *collectionCtrl,
                                  NSUInteger sectionNumber,
                                  MKHCollectionSectionClass *sectionItemList);

//===

@interface MKHCollectionCtrl : NSObject
<UICollectionViewDataSource, UICollectionViewDelegate>

@property(getter = isMultiselectEnabled) BOOL multiselectEnabled;

@property (copy, nonatomic) NSString *defaultCellIdentifier;

@property (copy, nonatomic) MKHCCSizeForItem onSizeForItem;
@property (copy, nonatomic) MKHCCCellReuseId onCellReuseId;
@property (copy, nonatomic) MKHCCConfigureCell onConfigureCell;
@property (copy, nonatomic) MKHCCSelectItem onDidSelectItem;
@property (copy, nonatomic) MKHCCSelectItem onDidDeselectItem;

// pagination support:
@property NSUInteger preloadOffset;
@property (copy, nonatomic) MKHCCNeedMoreItems onNeedMoreItems;

- (void)resetContent;

- (NSUInteger)numberOfItems;
- (NSUInteger)numberOfItemsInSectionAtIndex:(NSUInteger)sectionIndex;
- (NSString *)cellReuseIdentifierForIndexPath:(NSIndexPath *)indexPath;
- (MKHCollectionSectionClass *)itemListForSectionAtIndex:(NSUInteger)sectionIndex;

- (void)setOnSizeForItem:(MKHCCSizeForItem)onSizeForItem;
- (void)setOnCellReuseId:(MKHCCCellReuseId)onCellReuseId;
- (void)setOnConfigureCell:(MKHCCConfigureCell)onConfigureCell;
- (void)setOnDidSelectItem:(MKHCCSelectItem)onDidSelectItem;
- (void)setOnDidDeselectItem:(MKHCCSelectItem)onDidDeselectItem;
- (void)setOnNeedMoreItems:(MKHCCNeedMoreItems)onNeedMoreItems;

@end
