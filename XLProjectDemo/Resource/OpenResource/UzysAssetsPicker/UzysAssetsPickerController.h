//
//  UzysAssetsPickerController.h
//  UzysAssetsPickerController
//
//  Created by Uzysjung on 2014. 2. 12..
//  Copyright (c) 2014년 Uzys. All rights reserved.
//

// 版权属于原作者
// http://code4app.com(cn) http://code4app.net(en)
// 来源于最专业的源码分享网站: Code4App

#import <UIKit/UIKit.h>
#import "UzysAssetsPickerController_Configuration.h"

#import "MWPhotoBrowser.h"

@class UzysAssetsPickerController;
@protocol UzysAssetsPickerControllerDelegate<NSObject>
- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets;
@optional
- (void)UzysAssetsPickerControllerDidCancel:(UzysAssetsPickerController *)picker;
@end

@interface UzysAssetsPickerController : BaseViewController<MWPhotoBrowserDelegate>{
    NSMutableArray *photos;
    NSMutableArray *thumbs;
    NSMutableArray *selections;
    NSMutableArray *imgs;
}
@property (strong, nonatomic) IBOutlet UIButton *preBtn;
@property (strong, nonatomic) IBOutlet UIButton *finishBtn;
@property (nonatomic, strong) ALAssetsFilter *assetsFilter;
@property (nonatomic, assign) NSInteger maximumNumberOfSelectionVideo;
@property (nonatomic, assign) NSInteger maximumNumberOfSelectionPhoto;
//--------------------------------------------------------------------
@property (nonatomic, assign) NSInteger maximumNumberOfSelectionMedia;

@property (nonatomic, weak) id <UzysAssetsPickerControllerDelegate> delegate;
+ (ALAssetsLibrary *)defaultAssetsLibrary;

@end
