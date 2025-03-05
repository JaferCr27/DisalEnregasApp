
class PrinterServices{
//   final BlueThermalPrinter printer = BlueThermalPrinter.instance;

//   Future<void> connectToPrinter() async {
//     List<BluetoothDevice> devices = await printer.getBondedDevices();
    
//     if (devices.isNotEmpty) {
//       await printer.connect(devices.first); // Conecta el primer dispositivo emparejado
//     }
//   }

//   Future<void> printInvoice() async {
//   if ((await printer.isConnected)!) {
//     printer.printNewLine();
//     printer.printCustom("DISAL S.A.", 3, 1);
//     printer.printCustom("Factura Electrónica", 2, 1);
//     printer.printNewLine();
//     printer.printCustom("Cliente: Juan Pérez", 1, 0);
//     printer.printCustom("Fecha: 25/02/2025", 1, 0);
//     printer.printNewLine();
//     printer.printCustom("Producto   Cant  Precio  Total", 1, 0);
//     printer.printCustom("----------------------------", 1, 0);
//     printer.printCustom("Café         2     2.00   4.00", 1, 0);
//     printer.printCustom("Pan          3     1.50   4.50", 1, 0);
//     printer.printNewLine();
//     printer.printCustom("TOTAL: 8.50 USD", 2, 1);
//     printer.printNewLine();
//     printer.printCustom("Gracias por su compra!", 1, 1);
//     printer.printNewLine();
//     printer.paperCut();
//   } else {
//     print("No conectado a la impresora");
//   }
// }
}