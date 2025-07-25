import 'package:cash_crafter/Pages/widget/button/button.dart';
import 'package:cash_crafter/Pages/widget/custom_appbar.dart';
import 'package:cash_crafter/constant/app_colors.dart';
import 'package:cash_crafter/constant/app_font.dart';
import 'package:cash_crafter/provider/balance_provider.dart';
import 'package:cash_crafter/service/card_details_fetch_from_bin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  String cardNumber = "";
  String expiryDate = "";
  String cardHolderName = "";
  String cvv = "";
  bool showBackView = false;
  bool useGlassMorphism = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Card"),
      body: Column(
        children: [
          CreditCardWidget(
            // glassmorphismConfig: _getGlassmorphismConfig(),
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvv,
            showBackView: showBackView,
            onCreditCardWidgetChange: (creditCardBrand) {},
            cardBgColor: Color(0xFF02081C),

            backCardBorder: Border.all(
              color: Color(0xFF000C75),
              width: 1.5,
            ),
            frontCardBorder: Border.all(
              color: Color(0xFF000C78),
              width: 1.5,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: CreditCardForm(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvv,
                onCreditCardModelChange: onCreditCardModelChange,
                formKey: formKey,
                inputConfiguration: InputConfiguration(
                  cardNumberTextStyle: AppFont.textFieldText,
                  cardHolderTextStyle: AppFont.textFieldText,
                  expiryDateTextStyle: AppFont.textFieldText,
                  cvvCodeTextStyle: AppFont.textFieldText,
                  cardNumberDecoration: _inpuDecoration(
                    "Card Number",
                    "XXXX XXXX XXXX XXXX",
                  ),
                  expiryDateDecoration: _inpuDecoration(
                    "Expiry Date",
                    "MM/YY",
                  ),
                  cvvCodeDecoration: _inpuDecoration(
                    "CVV",
                    "XXX",
                  ),
                  cardHolderDecoration: _inpuDecoration(
                    "Card Holder Name",
                    "Enter your name",
                  ),
                ),
              ),
            ),
          ),
          CustomButton(buttonText: "Save Card Details", onPressed: (){
            if (formKey.currentState?.validate() ?? false) {
            final provider = Provider.of<BalanceProvider>(context,listen: false);
              formKey.currentState?.save();
              provider.accModel.debitCardNumber = cardNumber;
              provider.accModel.debitValidUpTo = expiryDate;
              provider.accModel.debitCardHolderName = cardHolderName;
              provider.accModel.debitCVV = cvv;
              Navigator.pop(context);
            } else {
              print('invalid!');
            }
          }),
          SizedBox(height: 30,)
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvv = creditCardModel.cvvCode;
      showBackView = creditCardModel.isCvvFocused;
    });
  }

  InputDecoration _inpuDecoration(String label, String hint) {
    return InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: AppFont.textFieldLabelText,
        hintStyle: AppFont.cardSubTitle,
        fillColor: AppColors.containerColor,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 2, color: AppColors.secondaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        )
    );
  }

  Glassmorphism? _getGlassmorphismConfig() {
    final LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Colors.grey.withAlpha(10), Colors.grey.withAlpha(10)],
      stops: const <double>[0.1, 0],
    );

    return Glassmorphism(blurX: 10.0, blurY: 16.0, gradient: gradient);
  }
}
