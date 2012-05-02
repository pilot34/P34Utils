//
//  StringUtils.m
//  Intuit
//
//  Created by Глеб Тарасов on 11.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StringUtils.h"

static NSDictionary *__translitDictionary;

@implementation StringUtils

+ (NSArray *)splitByCapitalLetters:(NSString *)string
{
    if (!string)
        return nil;
    
    if (string.length == 0)
        return [NSArray array];
    
    if (string.length == 1)
        return [NSArray arrayWithObject:[string lowercaseString]];
    
    NSMutableArray *result = [NSMutableArray array];
    NSInteger lastCapital = 0;
    
    for (int i = 1; i < string.length + 1; ++i)
    {
        unichar c = i == string.length ? 0 : [string characterAtIndex:i];
        
        if (isupper(c) || i == string.length)
        {
            NSRange range;
            range.length = i - lastCapital;
            range.location = lastCapital;
            
            NSString *part = [string substringWithRange:range];
            [result addObject:part.lowercaseString];
            lastCapital = i;
        }
    }
    
    return result;
}


+ (NSString *)getCase:(NSInteger)num 
           nominative:(NSString *)nominative
             genitive:(NSString *)genitive 
       pluralGenitive:(NSString *)pluralGenitive
{
    if ((num % 10) == 1 && num != 11)
        return nominative;
    
    if ((num % 10) >= 2 && (num % 10) <= 4 && num / 10 != 1)
    {
        return genitive;
    }
    
    return pluralGenitive;
}

+ (NSString *)sizeToString:(NSInteger)bytes
{
    CGFloat floatBytes = bytes;
    CGFloat result;
    NSString *format;
    if (bytes >= (1 << 30))
    {
        result = floatBytes / (1 << 30);
        format = @"%d Гб";
    }
    else if (bytes >= (1 << 20))
    {
        result = floatBytes / (1 << 20);
        format = @"%d Мб";
    }
    else if (bytes >= (1 << 10))
    {
        result = floatBytes / (1 << 10);
        format = @"%d Кб";
    }
    else
    {
        result = bytes;
        format = @"%d б";
    }
    
    return [NSString stringWithFormat:format, (int)roundf(result)];
}

+ (NSString *)timeIntervalToStringFull:(NSTimeInterval)time
{
    int seconds = time;
    int minutes = seconds / 60;
    seconds %= 60;
    int hours = minutes / 60;
    minutes %= 60;
    
    NSString *hoursString = [self getCase:hours nominative:@"час" genitive:@"часа" pluralGenitive:@"часов"];
    NSString *minutesString = [self getCase:minutes nominative:@"минута" genitive:@"минуты" pluralGenitive:@"минут"];
    NSString *secondsString = [self getCase:seconds nominative:@"секунда" genitive:@"секунды" pluralGenitive:@"секунд"];
    
    if (hours)
    {
        return [NSString stringWithFormat:@"%d %@ %d %@", hours, hoursString, minutes, minutesString];
    }
    else if (minutes)
    {    
        return [NSString stringWithFormat:@"%d %@ %d %@", minutes, minutesString, seconds, secondsString];
    }
    else 
    {
        return [NSString stringWithFormat:@"%d %@", seconds, secondsString];
    }
}

+ (NSString *)timeIntervalToStringShort:(NSTimeInterval)time
{
    int seconds = time;
    int minutes = seconds / 60;
    seconds %= 60;
    int hours = minutes / 60;
    minutes %= 60;

    if (hours)
    {
        return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }
    else 
    {
        return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    }

}

+ (NSString *)translit:(NSString *)str
{
    if (!__translitDictionary)
    {
        __translitDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"A", @"А",
                                @"B", @"Б",
                                @"V", @"В",
                                @"G", @"Г",
                                @"D", @"Д",
                                @"E", @"Е",
                                @"Yo", @"Ё",
                                @"Zh", @"Ж",
                                @"Z", @"З",
                                @"I", @"И",
                                @"J", @"Й",
                                @"K", @"К",
                                @"L", @"Л",
                                @"M", @"М",
                                @"N", @"Н",
                                @"O", @"О",
                                @"P", @"П",
                                @"R", @"Р",
                                @"S", @"С",
                                @"T", @"Т",
                                @"U", @"У",
                                @"F", @"Ф",
                                @"H", @"Х",
                                @"C", @"Ц",
                                @"Ch", @"Ч",
                                @"Sh", @"Ш",
                                @"Sch", @"Щ",
                                @"'", @"Ь",
                                @"\"", @"Ъ",
                                @"E", @"Э",
                                @"Yu", @"Ю",
                                @"Ya", @"Я",
                                @"a", @"а",
                                @"b", @"б",
                                @"v", @"в",
                                @"g", @"г",
                                @"d", @"д",
                                @"e", @"е",
                                @"yo", @"ё",
                                @"zh", @"ж",
                                @"z", @"з",
                                @"i", @"и",
                                @"j", @"й",
                                @"k", @"к",
                                @"l", @"л",
                                @"m", @"м",
                                @"n", @"н",
                                @"o", @"о",
                                @"p", @"п",
                                @"r", @"р",
                                @"s", @"с",
                                @"t", @"т",
                                @"u", @"у",
                                @"f", @"ф",
                                @"h", @"х",
                                @"c", @"ц",
                                @"ch", @"ч",
                                @"sh", @"ш",
                                @"sch", @"щ",
                                @"'", @"ь",
                                @"\"", @"ъ",
                                @"e", @"э",
                                @"yu", @"ю",
                                @"ya", @"я",
                                nil];
                                
    }
    
    NSMutableString *result = str.mutableCopy;
    for (NSString *key in __translitDictionary) 
    {
        NSString *value = [__translitDictionary objectForKey:key];
        [result replaceOccurrencesOfString:key withString:value options:0 range:NSMakeRange(0, result.length)];
    }
    return result;
}

@end
