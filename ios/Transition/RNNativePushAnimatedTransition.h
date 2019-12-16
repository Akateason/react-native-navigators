//
//  RNNativePushAnimatedTransition.h
//  owl
//
//  Created by Bell Zhong on 2019/10/18.
//  Copyright © 2019 shimo.im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNNativeConst.h"

NS_ASSUME_NONNULL_BEGIN

/**
 push 动画
 */
@interface RNNativePushAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) RNNativeSceneTransition transition;

- (instancetype)initWithTransition:(RNNativeSceneTransition)transition;

@end

NS_ASSUME_NONNULL_END
