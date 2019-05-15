#define WSDefaults [NSUserDefaults standardUserDefaults]
#define WSSwitchKey @"ws_switch_key"
#define WSFile(path) @"/Library/PreferenceLoader/Preferences/WSWeChat/" #path

%hook MMBadgeView
- (id)initWithFrame:(struct CGRect)arg1 ipadClassic:(_Bool)arg2 range:(double)arg3 {
    return nil;
}
- (id)initWithFrame:(struct CGRect)arg1 {
    return nil;
}
%end


%hook FindFriendEntryViewController
// data source
- (long long)numberOfSectionsInTableView:(id)tableView {
    return %orig + 1;
}
- (long long)tableView:(id)tableView numberOfRowsInSection:(long long)section {
    if (section == [self numberOfSectionsInTableView:tableView] - 1) {
        return 2;
    } else {
        return %orig;
    }
}

- (id)tableView:(id)tableView cellForRowAtIndexPath:(id)indexPath {
    if ([indexPath section] != [self numberOfSectionsInTableView:tableView] - 1) {
        return %orig;
    }

    NSString *cellId = ([indexPath row] == 1) ? @"exitCellId" : @"autoCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor whiteColor];
        cell.imageView.image = [UIImage imageWithContentsOfFile:WSFile(skull.png)];
    }

    if ([indexPath row] == 0) {
        cell.textLabel.text = @"自动抢红包";
        UISwitch *switchView = [[UISwitch alloc] init];
        switchView.on = [WSDefaults boolForKey:WSSwitchKey];
        [switchView addTarget:self action:@selector(ws_autoChange:) forControlEvents:(UIControlEventValueChanged)];
        cell.accessoryView = switchView;
    } else if ([indexPath row] == 1) {
        cell.textLabel.text = @"退出微信";
    }

    return cell;

}

%new
- (void) ws_autoChange:(UISwitch *)switchView {
    [WSDefaults setBool:switchView.isOn forKey:WSSwitchKey];
    [WSDefaults synchronize];
}

- (double)tableView:(id)tableView heightForRowAtIndexPath:(id)indexPath {
    if ([indexPath section] == [self numberOfSectionsInTableView:tableView] - 1) {
        return 44;
    } else {
        return %orig;
    }

}

// delegate
- (void)tableView:(id)tableView didSelectRowAtIndexPath:(id)indexPath {
    if ([indexPath section] != [self numberOfSectionsInTableView:tableView] - 1) {
        %orig;
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([indexPath row] == 1) {
        abort();
    }
}

%end