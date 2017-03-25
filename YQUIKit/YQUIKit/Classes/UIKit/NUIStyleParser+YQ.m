//
//  NUIStyleParser+YQ.m
//  NUITest
//
//  Created by Hydra on 2017/1/17.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NUIStyleParser+YQ.h"
#import "NUIRuleSet.h"
#import "YQUIDefinitions.h"
#import "NUIParse.h"
#import "NUIPTokeniser.h"
#import "NUITokeniserDelegate.h"
#import "NUIParserDelegate.h"
#import "NUIStyleSheet.h"
#import "NUIRuleSet.h"
#import "NUIRenderer.h"
#import "NUISettings.h"
#import "NUIDefinition.h"
#import "YQUIDefinitions.h"


//提取私有方法，复制实现，避免未来因为官方方法修改导致异常
@interface NUIStyleParser (PullUpMethod)
- (NSMutableDictionary*)mergeRuleSetIntoConsolidatedRuleSet:(NUIRuleSet*)ruleSet consolidatedRuleSet:(NSMutableDictionary*)consolidatedRuleSet definitions:(NSDictionary*)definitions;
    
- (BOOL)mediaOptionsSatisified:(NSDictionary *)mediaOptions;
    
- (NUIStyleSheet *)parse:(NSString *)styles;
    @end

@implementation NUIStyleParser (PullUpMethod)
- (NSMutableDictionary*)mergeRuleSetIntoConsolidatedRuleSet:(NUIRuleSet*)ruleSet consolidatedRuleSet:(NSMutableDictionary*)consolidatedRuleSet definitions:(NSDictionary*)definitions
    {
        for (NSString *property in ruleSet.declarations) {
            NSString *value = ruleSet.declarations[property];
            if ([value hasPrefix:@"@"]) {
                NSString *variable = value;
                value = definitions[variable];
                
                if (!value) {
                    [NSException raise:@"Undefined variable" format:@"Variable %@ is not defined", variable];
                }
            }
            consolidatedRuleSet[property] = value;
        }
        return consolidatedRuleSet;
    }
    
- (BOOL)mediaOptionsSatisified:(NSDictionary *)mediaOptions
    {
        if (!mediaOptions)
        return YES;
        
        static NSString *device;
        NSString *mediaDevice = mediaOptions[@"device"];
        
        if (mediaDevice) {
            if (!device) {
                device = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"ipad" : @"iphone";
            }
            
            if (![mediaDevice isEqualToString:device])
            return NO;
        }
        
        NSString *mediaOrientation = mediaOptions[@"orientation"];
        
        if (mediaOrientation) {
            [NUIRenderer setRerenderOnOrientationChange:YES];
            
            if (![mediaOrientation isEqualToString:[NUISettings stylesheetOrientation]])
            return NO;
        }
        
        return YES;
    }
    
- (NUIStyleSheet *)parse:(NSString *)styles
    {
        NUIPTokeniser *tokeniser = [[NUIPTokeniser alloc] init];
        
        
        [tokeniser addTokenRecogniser:[NUIPWhiteSpaceRecogniser whiteSpaceRecogniser]];
        [tokeniser addTokenRecogniser:[NUIPQuotedRecogniser quotedRecogniserWithStartQuote:@"/*"
                                                                                  endQuote:@"*/"
                                                                                      name:@"Comment"]];
        
        [tokeniser addTokenRecogniser:[NUIPKeywordRecogniser recogniserForKeyword:@"@media"]];
        [tokeniser addTokenRecogniser:[NUIPKeywordRecogniser recogniserForKeyword:@"and"]];
        
        NSCharacterSet *idCharacters = [NSCharacterSet characterSetWithCharactersInString:
                                        @"abcdefghijklmnopqrstuvwxyz"
                                        @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                        @"0123456789"
                                        @"-_\\/."];
        NSCharacterSet *initialIdCharacters = [NSCharacterSet characterSetWithCharactersInString:
                                               @"abcdefghijklmnopqrstuvwxyz"
                                               @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                               @"0123456789"
                                               @"#@-_\\."];
        [tokeniser addTokenRecogniser:[NUIPIdentifierRecogniser identifierRecogniserWithInitialCharacters:initialIdCharacters identifierCharacters:idCharacters]];
        
        [tokeniser addTokenRecogniser:[NUIPKeywordRecogniser recogniserForKeyword:@":"]];
        [tokeniser addTokenRecogniser:[NUIPKeywordRecogniser recogniserForKeyword:@"{"]];
        [tokeniser addTokenRecogniser:[NUIPKeywordRecogniser recogniserForKeyword:@"}"]];
        [tokeniser addTokenRecogniser:[NUIPKeywordRecogniser recogniserForKeyword:@"("]];
        [tokeniser addTokenRecogniser:[NUIPKeywordRecogniser recogniserForKeyword:@")"]];
        [tokeniser addTokenRecogniser:[NUIPKeywordRecogniser recogniserForKeyword:@","]];
        [tokeniser addTokenRecogniser:[NUIPKeywordRecogniser recogniserForKeyword:@";"]];
        
        NUITokeniserDelegate *tokenizerDelegate = [[NUITokeniserDelegate alloc] init];
        tokeniser.delegate = tokenizerDelegate;
        
        NSString *expressionGrammar =
        @"NUIStyleSheet            ::= items@<NUIStyleSheetItem>*;\n"
        "NUIStyleSheetItem        ::= ruleSet@<NUIRuleSet> | mediaBlock@<NUIMediaBlock> | definition@<NUIDefinition>;\n"
        "NUIMediaBlock            ::= '@media' mediaOptions@<NUIMediaOptionSet> '{' items@<NUIMediaBlockItem>* '}';\n"
        "NUIMediaBlockItem        ::= ruleSet@<NUIRuleSet> | definition@<NUIDefinition>;\n"
        "NUIMediaOptionSet        ::= firstMediaOption@<NUIMediaOption> otherMediaOptions@<NUIDelimitedMediaOption>*;\n"
        "NUIMediaOption           ::= '(' property@'Identifier' ':' value@'Identifier' ')';\n"
        "NUIDelimitedMediaOption  ::= 'and' mediaOption@<NUIMediaOption>;\n"
        "NUIRuleSet               ::= selectors@<NUISelectorSet> '{' declarations@<NUIDeclaration>* '}';\n"
        "NUISelectorSet           ::= firstSelector@<NUISelector> otherSelectors@<NUIDelimitedSelector>*;\n"
        "NUISelector              ::= name@'Identifier';\n"
        "NUIDelimitedSelector     ::= ',' selector@<NUISelector>;\n"
        "NUIDeclaration           ::= property@'Identifier' ':' value@<NUIValue> ';';\n"
        "NUIDefinition            ::= variable@'Variable' ':' value@<NUIValue> ';';\n"
        "NUIValue                 ::= <NUIAny>+;\n"
        "NUIAny                   ::= 'Identifier' | 'Variable' | '(' | ')' | ',';\n"
        ;
        
        NSError *err = nil;
        NUIPGrammar *grammar = [NUIPGrammar grammarWithStart:@"NUIStyleSheet"
                                              backusNaurForm:expressionGrammar
                                                       error:&err];
        if (!grammar) {
            NSLog(@"Error creating grammar:%@", err);
            return nil;
        }
        
        NUIPParser *parser = [NUIPLALR1Parser parserWithGrammar:grammar];
        
        if (!parser)
        return nil;
        
        NUIParserDelegate *parserDelegate = [[NUIParserDelegate alloc] init];
        parser.delegate = parserDelegate;
        
        NUIPTokenStream *tokenStream = [tokeniser tokenise:styles];
        return [parser parse:tokenStream];
    }
    
    
    
    @end


@implementation NUIStyleParser (YQ)
    
    
    /**
     一次性解析多个style文件
     
     @param fileNames 文件名称数组
     @return 参数数组
     */
- (NSMutableDictionary*)getStylesFromFiles:(NSArray*)fileNames
    {
        NSString *contents = @"";
        for(NSString *fileName in fileNames){
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"YQUIKit" ofType:@"bundle"];
            NSBundle *YQUIKitBundle = [NSBundle bundleWithPath:bundlePath];
            NSString* path = [YQUIKitBundle pathForResource:fileName ofType:@"nss"];
            NSAssert1(path != nil, @"File \"%@\" does not exist", fileName);
            NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            contents = [contents stringByAppendingFormat:@"\n%@",content];
        }
        
        NUIStyleSheet *styleSheet = [self parse:contents];
        return [self consolidateRuleSets:styleSheet];
        
        
    }
    
    
    /**
     将StyleSheet转换成对应的参数kv对
     
     @param styleSheet 待转换的styleSheet
     @return 转换后的kv对
     */
- (NSMutableDictionary*)consolidateRuleSets:(NUIStyleSheet *)styleSheet
    {
        //方向转换不重新绘制
        [NUIRenderer setRerenderOnOrientationChange:NO];
        
        NSMutableDictionary *consolidatedRuleSets = [NSMutableDictionary dictionary];
        NSMutableDictionary *definitions          = [NSMutableDictionary dictionary];
        
        //判断styleSheet的定义是否满足当前屏幕设置
        for (NUIDefinition *definition in styleSheet.definitions) {
            if ([self mediaOptionsSatisified:definition.mediaOptions])
            definitions[definition.variable] = definition.value;
        }
        
        //判断ruleSets是否满足定义
        for (NUIRuleSet *ruleSet in styleSheet.ruleSets) {
            if (![self mediaOptionsSatisified:ruleSet.mediaOptions])
            continue;
            
            for (NSString *selector in ruleSet.selectors) {
                if (consolidatedRuleSets[selector] == nil) {
                    consolidatedRuleSets[selector] = [[NSMutableDictionary alloc] init];
                }
                [self mergeRuleSetIntoConsolidatedRuleSet:ruleSet consolidatedRuleSet:consolidatedRuleSets[selector] definitions:definitions];
            }
        }
        
        [[YQUIDefinitions sharedInstance].definitions addEntriesFromDictionary:definitions];
        
        return consolidatedRuleSets;
    }
    
    @end
