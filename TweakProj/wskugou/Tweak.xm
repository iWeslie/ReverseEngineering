@interface WSMethodSet
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end

%hook KGHomeIconView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return %orig;
    } else {
        return 0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return %orig;
    } else {
        return 0;
    }
}

%end

// %class KMMusicSpecialViewController;

%hook KGHomeViewController
- (void)viewDidAppear:(_Bool)arg1 {
	%orig;

	
}
%end


%ctor {
	[[[UIApplication sharedApplication] keyWindow] setRootViewController:[[%c(KMMusicSpecialViewController) alloc] init]];
	NSLog(@"------------------------------------------------");
}