//
//  JSZModel.h
//  JSZExample
//
//  Created by Nova Internet on 23/2/17.
//  Copyright © 2017 JSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol JSZModelDelegate <NSObject>

-(void)didStartDownloading;
-(void)didUpdateProgress:(CGFloat)progress;
-(void)didFinishDownload;
-(void)didFailDownload;

@end

@interface JSZModel : NSObject

@property (nonatomic, strong) id<JSZModelDelegate> delegate;

@property (nonatomic, copy) NSString *fileUrl;
@property (nonatomic, copy) NSString *title;

-(id) initWith:(NSString *) fileUrl title:(NSString *) title;

-(void) needDownloadPodcast;

-(CGFloat) progress;

-(BOOL) isDownloading;

-(BOOL) isDownloaded;

@end
