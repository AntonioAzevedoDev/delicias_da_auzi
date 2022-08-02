import 'package:clipboard/clipboard.dart';
import 'package:delicias_da_auzi/src/services/utils_services.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../models/order_model.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;

  PaymentDialog({Key? key, required this.order}) : super(key: key);

  final UtilsServices utilServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          //Conteudo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Titulo
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Pagamento com Pix',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),

                //QR Code
                Image.memory(
                  utilServices.decodeQrCodeImage(order.qrCodeImage),
                  height: 200,
                  width: 200,
                ),
                //Vencimento
                Text(
                  'Vencimento: ${utilServices.formatDateTime(order.overdueDateTime)}',
                  style: const TextStyle(fontSize: 12),
                ),
                //Total
                Text(
                  'Total: ${utilServices.priceToCurrency(order.total)}',
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),

                //Botão copia e cola
                OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 2, color: Colors.purple),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      FlutterClipboard.copy(order.copyAndPaste);
                      utilServices.showToast(message: 'Código copiado');
                    },
                    icon: const Icon(
                      Icons.copy,
                      size: 15,
                    ),
                    label: const Text('Copiar código pix'))
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ))
        ],
      ),
    );
  }
}
