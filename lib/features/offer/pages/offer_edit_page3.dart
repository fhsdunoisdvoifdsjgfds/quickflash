import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/offer.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/textfields/txt_field.dart';
import '../../../core/widgets/texts/text_r.dart';
import '../bloc/offer_bloc.dart';
import '../widgets/field_title.dart';

class OfferEditPage3 extends StatefulWidget {
  const OfferEditPage3({super.key, required this.offer});

  final Offer offer;

  @override
  State<OfferEditPage3> createState() => _OfferEditPage3State();
}

class _OfferEditPage3State extends State<OfferEditPage3> {
  final controller1 = TextEditingController();

  bool active = true;

  void checkActive() {
    setState(() {
      active = getButtonActive([controller1]);
    });
  }

  void onAdd() {
    context.read<OfferBloc>().add(
          EditOfferEvent(
            offer: Offer(
              id: widget.offer.id,
              cost: widget.offer.cost,
              who: widget.offer.who,
              paymentPeriod: widget.offer.paymentPeriod,
              transportType: widget.offer.transportType,
              note: widget.offer.note,
              comment: controller1.text,
            ),
          ),
        );
    context.pop();
    context.pop();
    context.pop();
  }

  @override
  void initState() {
    super.initState();
    controller1.text = widget.offer.comment;
    if (widget.offer.comment.isEmpty) active = false;
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
                const SizedBox(height: 60),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff363636),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _Data(
                        title: 'Type:',
                        data: widget.offer.transportType,
                      ),
                      const _Divider(),
                      _Data(
                        title: 'Rental Cost:',
                        data: '\$${widget.offer.cost}',
                      ),
                      const _Divider(),
                      _Data(
                        title: 'Payment Type:',
                        data: widget.offer.paymentPeriod,
                      ),
                      const _Divider(),
                      _Data(
                        title: 'Who rent:',
                        data: widget.offer.who,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const FieldTitle('Comment'),
                const SizedBox(height: 16),
                TxtField(
                  controller: controller1,
                  multiline: true,
                  onChanged: checkActive,
                ),
                const SizedBox(height: 40),
                PrimaryButton(
                  title: 'Edit Offer',
                  active: active,
                  onPressed: onAdd,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Data extends StatelessWidget {
  const _Data({
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const SizedBox(width: 22),
          TextR(
            title,
            fontSize: 16,
            color: AppColors.main,
          ),
          const Spacer(),
          TextR(
            data,
            fontSize: 16,
            color: AppColors.main,
          ),
          const SizedBox(width: 22),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: AppColors.white10,
      margin: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
