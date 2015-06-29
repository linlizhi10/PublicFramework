//
//  FacialView.m
//  KeyBoardTest
//
//  Created by wangqiulei on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacialView.h"

#define numOfPage 23
#define rowNum 4
#define numOfRow 6


@implementation FacialView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        faces=[EmojiEmoticons allEmoticons];
        faces=[Emoji allEmoji];
//        faces=[EmojiPictographs allPictographs];
    }
    return self;
}

-(void)loadFacialView:(int)page size:(CGSize)size
{
	//row number
	for (int i=0; i<rowNum; i++) {
		//column numer
		for (int y=0; y<numOfRow; y++) {
            NSInteger index = page*numOfPage+i*numOfRow+y;
            NSLog(@"index:%d-%d--%d",[faces count],page,index);
            if (index>[faces count]-1) {
                //添加删除按钮
                float mWidth;
                float mHeight;
                if (y<numOfRow) {
                    mWidth = (numOfRow-1)*size.width;
                    mHeight = i*size.height;
                } else {
                    mWidth = (numOfRow-1)*size.width;
                    mHeight = (i+1)*size.height;
                }
                
                UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                [button setBackgroundColor:[UIColor clearColor]];
                [button setFrame:CGRectMake(mWidth, mHeight, size.width, size.height)];
                [button setImage:[UIImage imageNamed:@"faceDelete"] forState:UIControlStateNormal];
                button.tag=10000;
                [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                
                
                return;
            }
            
			UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor clearColor]];
            [button setFrame:CGRectMake(y*size.width, i*size.height, size.width, size.height)];
            if (i==3&&y==(numOfRow-1)) {
                [button setImage:[UIImage imageNamed:@"faceDelete"] forState:UIControlStateNormal];
                button.tag=10000;
                
            }else{
                [button.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0]];
                
                
                
                [button setTitle: [faces objectAtIndex:index]forState:UIControlStateNormal];
                button.tag=index;
                
            }
			[button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:button];
            
            
		}
	}
}


-(void)selected:(UIButton*)bt
{
    if (bt.tag==10000) {
        NSLog(@"点击删除");
        [delegate selectedFacialView:@"删除"];
    }else{
        faces=[Emoji allEmoji];
        NSLog(@"%@",faces);
        NSLog(@"%d--%@--%d",[faces count],faces,bt.tag);
        NSString *str=[faces objectAtIndex:bt.tag];
        NSLog(@"点击其他%@",str);
        [delegate selectedFacialView:str];
    }	
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

@end
