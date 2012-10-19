//
//  NSFileManager+P34Utils.h
//  Intuit
//
//  Created by Gleb Tarasov on 26.08.12.
//
//

#import <Foundation/Foundation.h>

typedef void(^FileBlock)(NSURL *fileURL);

@interface NSFileManager (Utils)

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
- (void)enumerateFilesRecursivelyInFolder:(NSString *)folder action:(FileBlock)action;

@end
