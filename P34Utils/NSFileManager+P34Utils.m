//
//  NSFileManager+Utils.m
//  Intuit
//
//  Created by Gleb Tarasov on 26.08.12.
//
//

#import "NSFileManager+P34Utils.h"
#include <sys/xattr.h>

@implementation NSFileManager (Utils)

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    if (&NSURLIsExcludedFromBackupKey == nil)
    {
        // iOS 5.0.1 and lower
        u_int8_t attrValue = 1;
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result == 0;
    }
    else
    {
        // First try and remove the extended attribute if it is present
        ssize_t result = getxattr(filePath, attrName, NULL, sizeof(u_int8_t), 0, 0);
        if (result != -1) {
            // The attribute exists, we need to remove it
            int removeResult = removexattr(filePath, attrName, 0);
            if (removeResult == 0) {
                NSLog(@"Removed extended attribute on file %@", URL);
            }
        }
        
        // Set the new key
        NSError *error = nil;
        [URL setResourceValue:@YES forKey:NSURLIsExcludedFromBackupKey error:&error];
        return error == nil;
    }
}

- (void)enumerateFilesRecursivelyInFolder:(NSString *)folder action:(FileBlock)action
{
    NSURL *directoryURL = [NSURL URLWithString:folder];
    
    if (!directoryURL)
        return;
    
    NSArray *keys = @[NSURLIsDirectoryKey];
    
    NSDirectoryEnumerator *enumerator = [self
                                         enumeratorAtURL:directoryURL
                                         includingPropertiesForKeys:keys
                                         options:0
                                         errorHandler:^(NSURL *url, NSError *error) {
                                             // Handle the error.
                                             // Return YES if the enumeration should continue after the error.
                                             return YES;
                                         }];
    
    for (NSURL *url in enumerator)
    {
        NSError *error;
        NSNumber *isDirectory = nil;
        if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error])
        {
            // handle error
        }
        else if (! [isDirectory boolValue])
        {
            action(url);
        }
    }
}

@end
