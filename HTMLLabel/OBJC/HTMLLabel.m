//
//  HTMLLabel.m
//  HTMLLabel
//
//  Created by Jim Huang on 2022/5/23.
//

#import "HTMLLabel.h"

@interface HTMLLabel ()

@property(retain) UITapGestureRecognizer *gestureRecognize;

@end

@implementation HTMLLabel

- (void)dealloc {
    if (self.gestureRecognize) {
        [self removeGestureRecognizer:self.gestureRecognize];
    }
    
    if (self.linkDelegate) {
        self.linkDelegate = nil;
    }
}

- (void)setHTMLText:(NSString *)htmlText {
    NSData *data = [htmlText dataUsingEncoding:NSUnicodeStringEncoding allowLossyConversion:NO];
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithData:data
                                                                          options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                               documentAttributes:nil error:nil];
    
    self.attributedText = attributedText;
    [self setUserInteractionEnabled:YES];

    self.gestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleHTMLTextTapped:)];
    [self addGestureRecognizer:self.gestureRecognize];
}

- (void)handleHTMLTextTapped:(UITapGestureRecognizer *)gesture {
    if ([gesture state] == UIGestureRecognizerStateEnded) {
        if (self.attributedText && [self.attributedText length] > 0) {
            [self.attributedText enumerateAttribute:NSLinkAttributeName inRange:NSMakeRange(0, [self.attributedText length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
                if (value) {
                    if (self.linkDelegate) {
                        [self.linkDelegate tappedLinkTextFunction:value];
                    }
                }
            }];
        }
    }
}

@end
