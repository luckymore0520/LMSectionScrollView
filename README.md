# LMSectionScrollView
A ScrollView with custom page control


## Sreenshot
![Demo GIF Animation](http://recordit.co/LYEqQuqOaO.gif
 "Demo GIF Animation")
 
## Usage

#### Init the scrollView with custom views
```Objective-C 
LMSectionScrollView *sectionScrollView = [[LMSectionScrollView alloc] initWithFrame:frame];    
[sectionScrollView buildViewWithViews:@[firstView,secondView,thirdView] 
					 sectionNameArray:@[@"page 1",@"page 2",@"page 3"]];
[self.view addSubview: sectionScrollView];
```


#### Init the scrollView with bundleNames 
```Objective-C 
LMSectionScrollView *sectionScrollView = [[LMSectionScrollView alloc] initWithFrame:frame];    
[sectionScrollView buildViewWithNibNames:@[@"videoRecordView",@"AudioRecordView",@"AnotherView"] 
	    				 sectionNameArray:@[@"page 1",@"page 2",@"page 3"]];
[self.view addSubview: sectionScrollView];
```


## To Do
Support more custom configuration.

Support callBack when selected.
