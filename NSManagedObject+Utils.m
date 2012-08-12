//
//  NSManagedObject+Utils.m
//  AldoCoppola
//
//  Created by Gleb Tarasov on 30.07.12.
//
//

#import "NSManagedObject+Utils.h"

@implementation NSManagedObject (Utils)

- (void)revertChanges
{
    NSDictionary *changedValues = [self changedValues];
    NSDictionary *committedValues = [self committedValuesForKeys:[changedValues allKeys]];
    NSEnumerator *enumerator;
    id key;
    enumerator = [changedValues keyEnumerator];
    
    while ((key = [enumerator nextObject]))
    {
        [self setValue:committedValues[key] forKey:key];
    }
}

@end
