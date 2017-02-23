//
//  JSZModel.m
//  JSZExample
//
//  Created by Nova Internet on 23/2/17.
//  Copyright © 2017 JSZ. All rights reserved.
//

#import "JSZModel.h"
#import "BackgroundSessionManager.h"

@interface JSZModel()
{
    BOOL _downloaded;
    BOOL _downloading;
    CGFloat _progress;
}

@end

@implementation JSZModel

static int contador = 0;

-(id) initWith:(NSString *) fileUrl title:(NSString *) title
{
    self = [super init];
    if (!self) {
        return nil;
    }
    //Inicializamos
    self.fileUrl = fileUrl;
    self.title = title;
    _downloaded = FALSE;
    _downloading = FALSE;
    return self;
}

#pragma mark -
#pragma mark - Download

-(void) needDownloadPodcast
{
    NSURL *url = [NSURL URLWithString:self.fileUrl];
    [self downloadItem:url];
}

- (void) downloadItem:(NSURL *) url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    contador = contador + 1;
    _downloading = YES;
    [[[BackgroundSessionManager sharedManager] downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
        documentsDirectoryPath = [documentsDirectoryPath URLByAppendingPathComponent:[targetPath lastPathComponent]];
        return documentsDirectoryPath;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            //el fichero se ha descargado correctamente
        }
    }] resume];
    
    
    [[BackgroundSessionManager sharedManager] setDownloadTaskDidWriteDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
        
        _progress = (progress * 100);
        [_delegate didUpdateProgress:_progress];
    }];
    
    [[BackgroundSessionManager sharedManager] setDownloadTaskDidFinishDownloadingBlock:^NSURL * _Nullable(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, NSURL * _Nonnull location) {
        [_delegate didFinishDownload];
        _downloaded = YES;
        _downloading = NO;
        
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [[NSString alloc] initWithString:[dirPaths objectAtIndex:0]];
        
        NSString *filename = [NSString stringWithFormat:@"%@%d",[downloadTask.originalRequest.URL lastPathComponent],contador];
        path = [path stringByAppendingPathComponent:filename];
        return [NSURL fileURLWithPath:path];
    }];
}

- (CGFloat) progress
{
    return _progress;
}

- (BOOL) isDownloaded
{
    return _downloaded;
}

-(void) setIsDownloaded:(BOOL) state
{
    _downloaded = state;
}

- (BOOL) isDownloading
{
    return _downloading;
}


@end
