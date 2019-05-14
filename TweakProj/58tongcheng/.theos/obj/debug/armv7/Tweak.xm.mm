#line 1 "Tweak.xm"

#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class WBJobAggregationPortalTableViewCell; 
static void (*_logos_orig$_ungrouped$WBJobAggregationPortalTableViewCell$awakeFromNib)(_LOGOS_SELF_TYPE_NORMAL WBJobAggregationPortalTableViewCell* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$WBJobAggregationPortalTableViewCell$awakeFromNib(_LOGOS_SELF_TYPE_NORMAL WBJobAggregationPortalTableViewCell* _LOGOS_SELF_CONST, SEL); 

#line 1 "Tweak.xm"


static void _logos_method$_ungrouped$WBJobAggregationPortalTableViewCell$awakeFromNib(_LOGOS_SELF_TYPE_NORMAL WBJobAggregationPortalTableViewCell* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return;
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$WBJobAggregationPortalTableViewCell = objc_getClass("WBJobAggregationPortalTableViewCell"); MSHookMessageEx(_logos_class$_ungrouped$WBJobAggregationPortalTableViewCell, @selector(awakeFromNib), (IMP)&_logos_method$_ungrouped$WBJobAggregationPortalTableViewCell$awakeFromNib, (IMP*)&_logos_orig$_ungrouped$WBJobAggregationPortalTableViewCell$awakeFromNib);} }
#line 8 "Tweak.xm"
