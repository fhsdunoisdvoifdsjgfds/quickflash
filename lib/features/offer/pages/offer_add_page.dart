import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/offer.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/textfields/txt_field.dart';
import '../widgets/field_title.dart';
import '../widgets/payment_period.dart';
import '../widgets/type_card.dart';

class OfferAddPage extends StatefulWidget {
  const OfferAddPage({super.key});

  @override
  State<OfferAddPage> createState() => _OfferAddPageState();
}

class _OfferAddPageState extends State<OfferAddPage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();

  bool active = false;

  void checkActive() {
    setState(() {
      active = getButtonActive([
        controller1,
        controller2,
        controller3,
        controller4,
      ]);
    });
  }

  void onContinue() {
    context.push(
      '/offer-add-2',
      extra: Offer(
        id: getCurrentTimestamp(),
        cost: parseInt(controller1.text),
        who: controller2.text,
        paymentPeriod: controller3.text,
        transportType: controller4.text,
      ),
    );
  }

  void onPaymentPeriod(String period) {
    controller3.text = period;
    checkActive();
  }

  void onSelectType(String type) {
    controller4.text = type;
    checkActive();
  }

  @override
  void initState() {
    super.initState();
    controller3.text = 'Daily';
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const CustomAppbar('New Offer'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(height: 26),
                const FieldTitle('Rental Cost'),
                const SizedBox(height: 16),
                TxtField(
                  controller: controller1,
                  number: true,
                  length: 5,
                  onChanged: checkActive,
                ),
                const SizedBox(height: 16),
                const FieldTitle('Who rents from you?'),
                const SizedBox(height: 16),
                TxtField(
                  controller: controller2,
                  onChanged: checkActive,
                ),
                const SizedBox(height: 16),
                const FieldTitle('How often is the rental payment made?'),
                const SizedBox(height: 16),
                PaymentPeriod(
                  title: controller3.text,
                  onPressed: onPaymentPeriod,
                ),
                const SizedBox(height: 46),
                const FieldTitle('Select the type of transportation'),
                const SizedBox(height: 16),
                TypeCard(
                  id: 1,
                  title: 'Passenger car',
                  active: controller4.text == 'Passenger car',
                  onPressed: onSelectType,
                ),
                const SizedBox(height: 20),
                TypeCard(
                  id: 2,
                  title: 'Truck',
                  active: controller4.text == 'Truck',
                  onPressed: onSelectType,
                ),
                const SizedBox(height: 20),
                TypeCard(
                  id: 3,
                  title: 'Motorcycle',
                  active: controller4.text == 'Motorcycle',
                  onPressed: onSelectType,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  title: 'Continue',
                  active: active,
                  onPressed: onContinue,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
