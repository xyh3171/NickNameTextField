//
//  ViewController.m
//  NickNameTextField
//
//  Created by xuyonghua on 2018/9/3.
//  Copyright © 2018 FN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
{
    UITextField *_nickNameTF;
    UILabel *_tipLbl;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nickNameTF = [[UITextField alloc] init];
    _nickNameTF.delegate = self;
    _nickNameTF.frame = RECT((SCR_WIDTH - 180) / 2, 110, 180, 25);
    _nickNameTF.font = FONT(16);
    _nickNameTF.placeholder = @"请输入成员名称";
    [self.view addSubview:_nickNameTF];
    
    _tipLbl = [[UILabel alloc] initWithFrame:RECT((SCR_WIDTH - 180) / 2, 110 + 25, 180, 25)];
    _tipLbl.font = FONT(16);
    [self.view addSubview:_tipLbl];
    
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField addTarget:self action:@selector(textFieldDidEditingChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidEditingChanged:(UITextField *)textField {
    NSString *toBeString = textField.text;
    NSString *lang = textField.textInputMode.primaryLanguage;// 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length >= 5) {
                textField.text = [toBeString substringToIndex:5];
                _tipLbl.text = @"请最多输入5个汉字";
            } else {
                _tipLbl.text = @"请勿输入特殊字符";
            }
        }
        else{// 有高亮选择的字符串，则暂不对文字进行统计和限制
            
        }
    }
    else{// 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length >= 5) {
            textField.text = [toBeString substringToIndex:5];
            _tipLbl.text = @"请最多输入5个汉字";
        } else {
            _tipLbl.text = @"请勿输入特殊字符";
        }
    }
}


// return NO to not change text
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //名字
    //利用NSCharacterSet去除字符串中的指定/任意字符集
    // invertedSet 取反
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:[self specialSymbolsAction]] invertedSet];
    // 取反后cs是正常的字符集
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [string isEqualToString:filtered];
    
    if(basicTest){
        if([string isEqualToString:@""]){
            return YES;
        }
        return NO;
    }
    return YES;
}

//特殊字符限制
- (NSString *)specialSymbolsAction{
    //数学符号
    NSString *matSym = @" ﹢﹣×÷±/=≌∽≦≧≒﹤﹥≈≡≠=≤≥<>≮≯∷∶∫∮∝∞∧∨∑∏∪∩∈∵∴⊥∥∠⌒⊙√∟⊿㏒㏑%‰⅟½⅓⅕⅙⅛⅔⅖⅚⅜¾⅗⅝⅞⅘≂≃≄≅≆≇≈≉≊≋≌≍≎≏≐≑≒≓≔≕≖≗≘≙≚≛≜≝≞≟≠≡≢≣≤≥≦≧≨≩⊰⊱⋛⋚∫∬∭∮∯∰∱∲∳%℅‰‱øØπ";
    
    //标点符号
    NSString *punSym = @"。，、＇：∶；?‘’“”〝〞ˆˇ﹕︰﹔﹖﹑·¨….¸;！´？！～—ˉ｜‖＂〃｀@﹫¡¿﹏﹋﹌︴々﹟#﹩$﹠&﹪%*﹡﹢﹦﹤‐￣¯―﹨ˆ˜﹍﹎+=<＿_-ˇ~﹉﹊（）〈〉‹›﹛﹜『』〖〗［］《》〔〕{}「」【】︵︷︿︹︽_﹁﹃︻︶︸﹀︺︾ˉ﹂﹄︼❝❞!():,'[]｛｝^・.·．•＃＾＊＋＝＼＜＞＆§⋯`－–／—|\"\\";
    
    //单位符号＊·
    NSString *unitSym = @"°′″＄￥〒￠￡％＠℃℉﹩﹪‰﹫㎡㏕㎜㎝㎞㏎m³㎎㎏㏄º○¤%$º¹²³";
    
    //货币符号
    NSString *curSym = @"₽€£Ұ₴$₰¢₤¥₳₲₪₵元₣₱฿¤₡₮₭₩ރ円₢₥₫₦zł﷼₠₧₯₨Kčर₹ƒ₸￠";
    
    //制表符
    NSString *tabSym = @"─ ━│┃╌╍╎╏┄ ┅┆┇┈ ┉┊┋┌┍┎┏┐┑┒┓└ ┕┖┗ ┘┙┚┛├┝┞┟┠┡┢┣ ┤┥┦┧┨┩┪┫┬ ┭ ┮ ┯ ┰ ┱ ┲ ┳ ┴ ┵ ┶ ┷ ┸ ┹ ┺ ┻┼ ┽ ┾ ┿ ╀ ╁ ╂ ╃ ╄ ╅ ╆ ╇ ╈ ╉ ╊ ╋ ╪ ╫ ╬═║╒╓╔ ╕╖╗╘╙╚ ╛╜╝╞╟╠ ╡╢╣╤ ╥ ╦ ╧ ╨ ╩ ╳╔ ╗╝╚ ╬ ═ ╓ ╩ ┠ ┨┯ ┷┏ ┓┗ ┛┳ ⊥ ﹃ ﹄┌ ╮ ╭ ╯╰";
    
    return [NSString stringWithFormat:@"%@%@%@%@%@",matSym,punSym,unitSym,curSym,tabSym];
}


@end
