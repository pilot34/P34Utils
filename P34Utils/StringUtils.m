//
//  StringUtils.m
//  Intuit
//
//  Created by Глеб Тарасов on 11.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StringUtils.h"
#import "P34Utils.h"

static NSDictionary *__translitDictionary;

@implementation StringUtils

+ (NSString *)removePlural:(NSString *)string
{
    if ([string endsWith:@"s"])
        string = [string substringToIndex:string.length - 1];
    
    return string;
}

+ (NSString *)capitalizeFirstLetter:(NSString *)string
{
    if (string.length < 1)
        return string;
    
    if (string.length == 1)
        return string.capitalizedString;
    
    NSString *firstLetter = [string substringToIndex:1];
    NSString *end = [string substringFromIndex:1];
    return [[firstLetter capitalizedString] stringByAppendingString:end];
}

+ (NSArray *)splitByCapitalLetters:(NSString *)string
{
    if (!string)
        return nil;
    
    if (string.length == 0)
        return @[];
    
    if (string.length == 1)
        return @[[string lowercaseString]];
    
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
    
    if ((num % 10) >= 2 && (num % 10) <= 4 && (num % 100) / 10 != 1)
    {
        return genitive;
    }
    
    return pluralGenitive;
}

+ (NSString *)sizeToString:(long long)bytes
{
    double floatBytes = bytes;
    double result;
    NSString *format;
    NSInteger roundSize = 1;
    
    if (bytes >= (1 << 30))
    {
        result = floatBytes / (1 << 30);
        format = @"%@ Гб";
        roundSize = 100;
    }
    else if (bytes >= (1 << 20))
    {
        result = floatBytes / (1 << 20);
        format = @"%@ Мб";
    }
    else if (bytes >= (1 << 10))
    {
        result = floatBytes / (1 << 10);
        format = @"%@ Кб";
    }
    else
    {
        result = bytes;
        format = @"%@ б";
    }
    
    result = ((long long)(result * roundSize)) / (double)roundSize;
    
    return [NSString stringWithFormat:format, [@(result) descriptionWithLocale:NSLocale.currentLocale]];
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
        __translitDictionary = @{@"А": @"A",
                                @"Б": @"B",
                                @"В": @"V",
                                @"Г": @"G",
                                @"Д": @"D",
                                @"Е": @"E",
                                @"Ё": @"Yo",
                                @"Ж": @"Zh",
                                @"З": @"Z",
                                @"И": @"I",
                                @"Й": @"J",
                                @"К": @"K",
                                @"Л": @"L",
                                @"М": @"M",
                                @"Н": @"N",
                                @"О": @"O",
                                @"П": @"P",
                                @"Р": @"R",
                                @"С": @"S",
                                @"Т": @"T",
                                @"У": @"U",
                                @"Ф": @"F",
                                @"Х": @"H",
                                @"Ц": @"C",
                                @"Ч": @"Ch",
                                @"Ш": @"Sh",
                                @"Щ": @"Sch",
                                @"Ь": @"'",
                                @"Ъ": @"\"",
                                @"Э": @"E",
                                @"Ю": @"Yu",
                                @"Я": @"Ya",
                                @"а": @"a",
                                @"б": @"b",
                                @"в": @"v",
                                @"г": @"g",
                                @"д": @"d",
                                @"е": @"e",
                                @"ё": @"yo",
                                @"ж": @"zh",
                                @"з": @"z",
                                @"и": @"i",
                                @"й": @"j",
                                @"к": @"k",
                                @"л": @"l",
                                @"м": @"m",
                                @"н": @"n",
                                @"о": @"o",
                                @"п": @"p",
                                @"р": @"r",
                                @"с": @"s",
                                @"т": @"t",
                                @"у": @"u",
                                @"ф": @"f",
                                @"х": @"h",
                                @"ц": @"c",
                                @"ч": @"ch",
                                @"ш": @"sh",
                                @"щ": @"sch",
                                @"ь": @"'",
                                @"ъ": @"\"",
                                @"э": @"e",
                                @"ю": @"yu",
                                @"я": @"ya"};
                                
    }
    
    NSMutableString *result = str.mutableCopy;
    for (NSString *key in __translitDictionary) 
    {
        NSString *value = __translitDictionary[key];
        [result replaceOccurrencesOfString:key withString:value options:0 range:NSMakeRange(0, result.length)];
    }
    return result;
}

@end
