//
//  application.h
//  show
//
//  Created by Pharaoh on 13-9-11.
//  Copyright (c) 2013年 monarch-sw. All rights reserved.
//

#ifndef show_application_h
#define show_application_h
#define SUITE_SECTION 0
#define SEARCH_BAR_EXPAND_LENGTH 260
#define SEARCH_BAR_SHRINK_LENGTH 100
#define SEARCH_BAR_HEIGHT 40

enum ProductCategory{
    SUITE_CATE = 0, //套间
    BATHDROBE_CATE = 1, // 浴室柜
    BATHTUB_CATE = 2, // 浴缸
    CLOSESTOOL_CATE = 3, // 马桶
    BATHROOM_CATE = 4 // 淋浴房
};
#define SUITE_ENTITY @"Suite"
#define SINGLE_ENTITY @"Single"
#define DYMANTIC_BUTTON_TAG_PREFIX 500
#define COVER_TAG 1000
#endif
