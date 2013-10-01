//
//  TileView.m
//  BitmapSlice
//
//  Created by Matt Long on 2/17/11.
//  Copyright 2011 Skye Road Systems, Inc. All rights reserved.
//

#import "TileView.h"


@implementation TileView

@synthesize tileTag;
@synthesize tileDirectory;

+ layerClass
{
  return [CATiledLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (!self) return  nil;
 CATiledLayer* tiledLayer = (CATiledLayer*)[self layer];
    tiledLayer.levelsOfDetail = 4;
  return self;
}

- (void)dealloc
{
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat scale = CGContextGetCTM(context).a;
    CATiledLayer* tiledLayer = (CATiledLayer*)[self layer];
    CGSize tileSize =
    tiledLayer.tileSize;
    tileSize.height /= scale;
    tileSize.width /= scale;
//      (CGSize){512, 512};
  int firstCol = floorf(CGRectGetMinX(rect) / tileSize.width);
  int lastCol = floorf((CGRectGetMaxX(rect)-1) / tileSize.width);
  int firstRow = floorf(CGRectGetMinY(rect) / tileSize.height);
  int lastRow = floorf((CGRectGetMaxY(rect)-1) / tileSize.height);
     for (int col = firstCol; col <= lastCol; col++) { 
  for (int row = firstRow; row <= lastRow; row++) {

      UIImage *tile = [self tileAtCol:col row:row];

      if (tile)
      {
        CGRect tileRect = CGRectMake(tileSize.width * col, tileSize.height * row,
                                     tileSize.width, tileSize.height);
        
        tileRect = CGRectIntersection(self.bounds, tileRect);
        
        [tile drawInRect:tileRect];
//
//        [[UIColor whiteColor] set];
//        CGContextSetLineWidth(context, 6.0);
//        CGContextStrokeRect(context, tileRect);
      }
    }
  }
}

- (UIImage*)tileAtCol:(int)col row:(int)row
{
  NSString *path = [NSString stringWithFormat:@"%@/%@%d_%d.png", tileDirectory, tileTag, col, row];
  return [UIImage imageWithContentsOfFile:path];  
}

@end
