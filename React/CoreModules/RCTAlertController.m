/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <React/RCTUtils.h>

#import "RCTAlertController.h"

@interface RCTAlertController ()

@property (nonatomic, strong) UIWindow *alertWindow;

@end

@implementation RCTAlertController

- (UIWindow *)alertWindow
{
  if (_alertWindow == nil) {
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *scene in RCTSharedApplication().connectedScenes) {
          if(scene.activationState == UISceneActivationStateForegroundActive && scene.class == UIWindowScene.class) {
            _alertWindow = [[UIWindow alloc] initWithWindowScene:scene];
            break;
          }
        }
      }
      if (_alertWindow == nil) {
        _alertWindow = [[UIWindow alloc] initWithFrame:RCTSharedApplication().keyWindow.bounds];
      }

    _alertWindow.rootViewController = [UIViewController new];
    _alertWindow.windowLevel = UIWindowLevelAlert + 1;
  }
  return _alertWindow;
}

- (void)show:(BOOL)animated completion:(void (^)(void))completion
{
  [self.alertWindow makeKeyAndVisible];
  [self.alertWindow.rootViewController presentViewController:self animated:animated completion:completion];
}

- (void)hide
{
  _alertWindow = nil;
}

@end
