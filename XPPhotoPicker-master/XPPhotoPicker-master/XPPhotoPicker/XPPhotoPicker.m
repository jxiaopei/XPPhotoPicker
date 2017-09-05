//
//  XPPhotoPicker.m
//  XPPhotoPicker-master
//
//  Created by iMac on 2017/9/5.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "XPPhotoPicker.h"
#import "UIView+GetValues.h"
#import<AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
@interface XPPhotoPicker()<UIImagePickerControllerDelegate>



@end

@implementation XPPhotoPicker

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UIButton *addBtn = [UIButton new];
    [self addSubview:addBtn];
    addBtn.frame = CGRectMake(10, 10, 60, 60);
    [addBtn setBackgroundImage:[UIImage imageNamed:@"addPic"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(didClickAddPicBtn:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)didClickAddPicBtn:(UIButton *)sender{
    //设置提示文字内容
    NSString *string1;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        string1 = @"iPhone";
    } else {
        string1 = @"iPad";
    }
    
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //相机
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //判断是否支持相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
            {
           
                //无相机权限 则弹出提示
                NSString *tips = [NSString stringWithFormat:@"请在%@的”设置-隐私-相机“选项中，允许App访问你的手机相机",string1];
                
                UIAlertController *cameraAlert = [UIAlertController alertControllerWithTitle:@"提示" message:tips preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                
                [cameraAlert addAction:confirmAction];
                
                [[self findViewController] presentViewController:cameraAlert animated:YES completion:nil];
            }else{
                //有权限 弹出照相机
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = (id)self;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [[self findViewController] presentViewController:imagePickerController animated:YES completion:nil];
            }
        }
        
    }];
    
    //相册
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if(author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
            
            //没有相册权限
            NSString *tips = [NSString stringWithFormat:@"请在%@的”设置-隐私-照片“选项中，允许App访问你的手机相册",string1];
            
            UIAlertController *albumAlert = [UIAlertController alertControllerWithTitle:@"提示" message:tips preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            
            [albumAlert addAction:confirmAction];
            
            [[self findViewController] presentViewController:albumAlert animated:YES completion:nil];
        }else{
            //有权限 弹出相册选择图片
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [[self findViewController] presentViewController:imagePickerController animated:YES completion:nil];
        }
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:  UIAlertActionStyleCancel handler:nil];
    
    [alertViewController addAction:cameraAction];
    [alertViewController addAction:albumAction];
    [alertViewController addAction:cancelAction];
    [[self findViewController] presentViewController:alertViewController animated:YES completion:nil];
    
}

#pragma mark - 相册代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    _imageView.image = image;
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/upload.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    
//    _isSelectedImage = YES;
}

- (UIViewController *)findViewController
{
    id target= self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}


@end
