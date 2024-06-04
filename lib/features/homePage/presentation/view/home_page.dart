

import 'package:flutter/material.dart';

import '../../../../cores/utlis/app_fonts.dart';
import '../../../../cores/widgets/segment_button.dart';
import '../../../../cores/widgets/sliver_sizedbox.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: CustomScrollView(

            slivers: [

              SliverToBoxAdapter(

                child: Text('Good Morning', style: AppFonts.textStyle30Medium,),
              ),

              const SliverSizedBox(height: 10,),
              const SliverToBoxAdapter(child: SegmentButtonList(),)

            ],
          ),
        )
      ),
    );
  }
}
