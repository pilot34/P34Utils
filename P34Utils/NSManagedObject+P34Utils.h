//
//  NSManagedObject+P34Utils.h
//  AldoCoppola
//
//  Created by Gleb Tarasov on 30.07.12.
//
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Utils)

- (void)revertChanges;
- (BOOL)isNew;

@end
