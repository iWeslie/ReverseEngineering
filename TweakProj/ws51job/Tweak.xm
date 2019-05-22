%hook HomeViewController
- (void)customView {
	return;
}

- (id)errorMessageForHomeBannerDataLoad:(id)arg1 {
	return nil;
}
%end

%hook DataItemDetail
- (_Bool)get_isshowupdate {
	return NO;
}
- (_Bool)has_isshowupdate {
	return NO;
}
%end

%hook UserCoreInfo
- (id)init {
	return nil;
}
%end