import 'package:auto_route/auto_route.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/core/config.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/screens/support/data/model/payment_init_params.dart';
import 'package:flutterui/screens/support/logic/payment/payment_bloc.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/utils/util.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';
import 'package:flutterui/shared/ui/widgets/layout/app_layout.dart';

@RoutePage()
class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  bool loading = false;
  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter.currency(
    locale: 'en',
    decimalDigits: 0,
    symbol: 'XAF ',
  );

  final controller = TextEditingController();
  final paymentBloc = getIt.get<PaymentBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppLayout(
        children: [
          Wrap(
            // verticalDirection: VerticalDirection.up,
            children: [
              donationForm(),
              donationImage(),
            ],
          ),
        ],
      ),
    );
  }

  Widget donationForm() {
    return Container(
      width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 50),
      height: AppSizing.kHPercentage(context, AppSizing.isMobile(context) ? 50 : 100),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is InitializePaymentSuccess) {
            UtilHelper.openUrl(state.response.data.transactionUrl);
          }
          if (state is InitializePaymentFailed) {}
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Support us", style: Theme.of(context).textTheme.displayLarge),
              AppSizing.kh10Spacer(),
              const Text(
                "Your support goes a long way to help us maintain our project and build beautiful UI/UX experiences as well as push the boundaries of flutter",
              ),
              AppSizing.kh20Spacer(),
              Text("Enter Amount", style: Theme.of(context).textTheme.bodyMedium),
              AppSizing.khSpacer(5),
              SizedBox(
                width: AppSizing.kWPercentage(context, 30),
                child: Center(
                  child: TextField(
                    controller: controller,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, formatter],
                    readOnly: state is InitializePaymentLoading,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      hintText: "XAF 20,000",
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(5),
                        child: AppIcon(icon: AppIcons.card),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).dividerColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).dividerColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
              AppSizing.kh20Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(fixedSize: Size(150, 50)),
                onPressed: () {
                  String tId = UtilHelper.generateUniqueId(length: 8);
                  final rawAmount = formatter.getUnformattedValue();
                  final amount = rawAmount.toDouble();
                  // if (amount == null) return;
                  if (amount < 500) return;
                  final params = InitializePaymentParams(
                    totalAmount: amount,
                    currency: 'XAF',
                    transactionId: tId,
                    returnUrl: AppConfig.payUnitBaseUrl,
                    notifyUrl: AppConfig.payUnitBaseUrl,
                    paymentCountry: "CM",
                  );

                  // print(params.toMap());
                  paymentBloc.add(InitializePaymentEvent(params: params));
                },
                label: state is InitializePaymentLoading ? const CircularProgressIndicator.adaptive() : Text("Donate now"),
              )
            ],
          );
        },
      ),
    );
  }

  Widget donationImage() {
    return Container(
      width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 50),
      height: AppSizing.height(context),
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Image.asset(
        "assets/images/support_1.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}
