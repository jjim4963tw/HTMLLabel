//
//  HTMLLabel.h
//  HTMLLabel
//
//  Created by Jim Huang on 2022/5/23.
//

#import <UIKit/UIKit.h>

@protocol HTMLLabelDelegate <NSObject>

- (void)tappedLinkTextFunction:(NSURL *_Nonnull)linkString;

@end

@interface HTMLLabel : UILabel

@property (nullable, nonatomic, weak) id <HTMLLabelDelegate> linkDelegate;


- (void)setHTMLText:(NSString *_Nonnull)htmlText;
@end
