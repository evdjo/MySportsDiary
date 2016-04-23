

//    if (entryIndex == entries!.count - 1) {
//				cell.backgroundColor = appBlueColor
//
//				let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
//				dispatch_after(time, dispatch_get_main_queue()) {
//    cell.backgroundColor = UIColor.whiteColor();
//				}
//    }

/// When we select the last cell, redirect the user to the second tab bar.
// func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//
// if let entries = entries where entries.count > 0 && indexPath.row < entries.count {
// return;
// } else {
// self.tabBarController?.selectedIndex = 2;
// if let vc = self.tabBarController?.viewControllers?[2] as? UINavigationController {
// vc.popToRootViewControllerAnimated(false);
// }
// }
// }

// // SOURCE FROM -> https://www.reddit.com/r/swift/comments/2fc1ze/animated_switch_when_using_tabbarcontroller/

/// LOST AND FOUND

///
//        let fromView = self.tabBarController?.selectedViewController!.view;
//        let toView = self.tabBarController?.viewControllers![2].view;
//
//        UIView.transitionFromView(
//            fromView!, toView: toView!, duration: 0.56,
//            options: .TransitionFlipFromRight,
//            completion: { (finished) in
//                if (finished) {
//                    self.navigationController?.popViewControllerAnimated(false)
//                    self.tabBarController?.selectedIndex = 2;
//                }
//        });

//		UIView.transitionWithView(tableView,
//			duration: duration,
//			options: [.TransitionFlipFromTop, .CurveEaseOut],
//			animations: { () -> Void in self.tableView.reloadData() },
//			completion: nil);

//		if let appState = DataManagerInstance().getAppState() {
//			if (appState == .Diary && entries.todayEntries.count >= 5) {
//				DataManagerInstance().setAppState(.DiaryDailyLimitReached);
//				alertWithMessage(self, title: "The limit of 5 entries has been reached. You can add more entries tomorrow")
//				self.tabBarController?.tabBar.items![1].enabled = false;
//			} else if appState == .DiaryDailyLimitReached && entries.todayEntries.count < 5 {
//				DataManagerInstance().setAppState(.Diary);
//				self.tabBarController?.tabBar.items![1].enabled = true;
//			}
//		}
