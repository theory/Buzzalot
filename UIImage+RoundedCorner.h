// UIImage+RoundedCorner.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.
// http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/

// Extends the UIImage class to support making rounded corners
@interface UIImage (RoundedCorner)
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
@end
