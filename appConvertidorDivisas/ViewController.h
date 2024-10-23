//
//  ViewController.h
//  appConvertidorDivisas
//
//  Created by Shalom Isai Salazar Arguijo on 21/10/24.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong,nonatomic) NSArray *tipoDeCambio;
@property (strong,nonatomic) NSArray *tipoDeCambioP;
@property (weak, nonatomic) IBOutlet UIPickerView *pckVDivisas;
@property (weak, nonatomic) IBOutlet UITextField *txtMon;
@property (weak, nonatomic) IBOutlet UILabel *lblConv;
@end

