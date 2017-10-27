#define PAGEINDEX @"1"
#define PAGESIZE @"10"


#define NavigationBgColor [[UIColor alloc] initWithRed:40.0/255.0 green:149.0/255.0 blue:217.0/255.0 alpha:1]





#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define Tmp_path [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/videos"]
#define Cache_path [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]
#define UserMessage [Cache_path stringByAppendingPathComponent:@"usermessage"]
#define ScanCodeList [Cache_path stringByAppendingPathComponent:@"scancodelist"]
#define SearchhotList [Cache_path stringByAppendingPathComponent:@"searchhotlist"]

#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue]>6.3?7:6
#define CLEARCOLOR [UIColor clearcolor]
#define COLORNOW(a,b,c) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:1]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define iphone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iphone6ratio 1.17  // 375/320
#define iphone6pratio 1.29 //  414/320

//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]

//本地图片地址
#define LocalImageAddr(file,ext) [[NSBundle mainBundle] pathForResource:file ofType:ext]

//定义UIImage对象
#define LOADCACHEIMAGE(A) [UIImage imageWithContentsOfFile:A]

//字体
#define FONTN(F) [UIFont systemFontOfSize:F]
#define FONTB(F) [UIFont fontWithName:@"HelveticaNeue" size:F]//系统默认粗体
#define FONTHelve(F) [UIFont fontWithName:@"Helvetica" size:F]
#define FONTLIGHT(F) [UIFont fontWithName:@"STHeitiTC-Light" size:F]//黑体细体
#define FONTMEDIUM(F) [UIFont fontWithName:@"STHeitiTC-Medium" size:F]//黑体粗体
#define URLSTRING(str) [NSURL URLWithString:str]


