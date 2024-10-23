//
//  ViewController.m
//  appConvertidorDivisas
//
//  Created by Shalom Isai Salazar Arguijo on 21/10/24.
//

#import "ViewController.h"

@interface ViewController () {
    NSArray *divisasPaises1;
    NSArray *divisasPaises2;
    NSArray *tiposMoneda;
    int tipoMonedaSeleccionada;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tipoMonedaSeleccionada = 0; // 0 para Pesos, 1 para Dólares
    
    divisasPaises2 = @[@"Australia🇦🇺", @"China🇨🇳", @"Francia🇫🇷", @"Inglaterra🏴", @"Japón🇯🇵", @"México🇲🇽", @"Suiza🇨🇭"];
    divisasPaises1 = @[@"Australia🇦🇺", @"China🇨🇳", @"Francia🇫🇷", @"Inglaterra🏴", @"Japón🇯🇵", @"EEUU🇺🇸", @"Suiza🇨🇭"];
    tiposMoneda = @[@"Pesos", @"Dólares"];
    
    // Inicializar tasas de cambio
    _tipoDeCambio = @[@1.50, @7.11, @0.92, @0.77, @150.48, @19.89, @0.87];
    _tipoDeCambioP = @[@1.50, @0.75, @0.046, @0.039, @7.59, @0.050, @0.043];
    
    self.pckVDivisas.dataSource = self;
    self.pckVDivisas.delegate = self;
}

#pragma mark - UIPickerView DataSource y Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return tiposMoneda.count;
    } else {
        if (tipoMonedaSeleccionada == 0) {
            return divisasPaises1.count;
        } else {
            return divisasPaises2.count;
        }
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        // Mostrar "Pesos" o "Dólares" en la primera columna
        return tiposMoneda[row];
    } else {
        // Mostrar divisas correspondientes en la segunda columna
        if (tipoMonedaSeleccionada == 0) {
            return divisasPaises1[row];
        } else {
            return divisasPaises2[row];
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        // Si se selecciona el primer componente ("Pesos" o "Dólares")
        tipoMonedaSeleccionada = (int)row;
        self.txtMon.placeholder=(tipoMonedaSeleccionada==0)?@"Pesos Mexicanos (MXN)":@"US Dollar (USD)";
        [self.pckVDivisas reloadComponent:1]; // Recargar el segundo componente para reflejar el cambio
    } else {
        // Obtener el valor ingresado en el campo de texto
        float cantidad = [self.txtMon.text floatValue];
        float valorMoneda;
        NSString *divisaSeleccionada;
        
        if (tipoMonedaSeleccionada == 0) {
            // Si se seleccionaron "Pesos", usar `tipoDeCambioP`
            valorMoneda = [[self.tipoDeCambioP objectAtIndex:row] floatValue];
            divisaSeleccionada = divisasPaises1[row];
        } else {
            // Si se seleccionaron "Dólares", usar `tipoDeCambio`
            valorMoneda = [[self.tipoDeCambio objectAtIndex:row] floatValue];
            divisaSeleccionada = divisasPaises2[row];
        }
        
        // Realizar la conversión
        float resultado = cantidad * valorMoneda;
        NSString *texto = [NSString stringWithFormat:@"%.2f en %@ = %.2f", cantidad, divisaSeleccionada, resultado];
        self.lblConv.text = texto;
    }
}

@end
