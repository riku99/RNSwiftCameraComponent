#import <Foundation/Foundation.h>
#import <React/RCTViewManager.h>
#import <React/RCTBridgeModule.h>

// RCT_EXTERN_MODULEの第二引数にはこのクラスの型
// Viewを伴う場合RCTViewManager, ネイティブ機能のみの場合NSObject
@interface RCT_EXTERN_MODULE(RCTCamaraManager, RCTViewManager)
@end
