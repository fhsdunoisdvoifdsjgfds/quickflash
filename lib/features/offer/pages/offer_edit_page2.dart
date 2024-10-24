import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/offer.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/textfields/txt_field.dart';
import '../bloc/offer_bloc.dart';
import '../widgets/field_title.dart';

class OfferEditPage2 extends StatefulWidget {
  const OfferEditPage2({super.key, required this.offer});

  final Offer offer;

  @override
  State<OfferEditPage2> createState() => _OfferEditPage2State();
}

class _OfferEditPage2State extends State<OfferEditPage2> {
  final controller1 = TextEditingController();

  void onSend() {
    context.read<OfferBloc>().add(
          EditOfferEvent(
            offer: Offer(
              id: widget.offer.id,
              cost: widget.offer.cost,
              who: widget.offer.who,
              paymentPeriod: widget.offer.paymentPeriod,
              transportType: widget.offer.transportType,
              note: controller1.text,
              comment: widget.offer.comment,
            ),
          ),
        );
    context.pop();
    context.pop();
  }

  void onContinue() {
    context.push(
      '/offer-edit-3',
      extra: Offer(
        id: widget.offer.id,
        cost: widget.offer.cost,
        who: widget.offer.who,
        paymentPeriod: widget.offer.paymentPeriod,
        transportType: widget.offer.transportType,
        note: controller1.text,
        comment: widget.offer.comment,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller1.text = widget.offer.note;
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const CustomAppbar('Edit Offer'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(height: 26),
                const FieldTitle('Note to Owner'),
                const SizedBox(height: 16),
                TxtField(
                  controller: controller1,
                  multiline: true,
                  onChanged: () {},
                ),
                const SizedBox(height: 10),
                PrimaryButton(
                  title: 'Send',
                  grey: true,
                  onPressed: onSend,
                ),
                const SizedBox(height: 18),
                PrimaryButton(
                  title: 'Continue',
                  onPressed: onContinue,
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
