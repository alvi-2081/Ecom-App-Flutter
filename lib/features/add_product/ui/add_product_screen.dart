import 'package:ecommerece_app/core/components/button_component.dart';
import 'package:ecommerece_app/core/components/route_constants.dart';
import 'package:ecommerece_app/core/components/text_component.dart';
import 'package:ecommerece_app/core/components/textfield_component.dart';
import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:ecommerece_app/core/constants/sizedbox_constants.dart';
import 'package:ecommerece_app/core/constants/string_constants.dart';
import 'package:ecommerece_app/core/utils/navigation_utils.dart';
import 'package:ecommerece_app/features/add_product/ui/cubit/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late GlobalKey<FormState> formkey;
  late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    formkey = GlobalKey<FormState>();
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstants.white,
            appBar: AppBar(
              backgroundColor: ColorConstants.main,
              title: const TextComponent(
                StringConstants.addProduct,
                style: TextStyle(color: Colors.white),
              ),
              leading: InkWell(
                  onTap: () => NavigationUtil.pop(context,
                      previousScreen: RouteConstants.categoryScreen),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
            ),
            body: BlocConsumer<AddProductCubit, AddProductState>(
              listener: (context, state) {
                if (state.product != null && state.isLoading == false) {
                  NavigationUtil.pop(context,
                      previousScreen: RouteConstants.addProductScreen);
                }
              },
              builder: (context, state) {
                return Form(
                  key: formkey,
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        children: [
                          SizedBoxConstants.fortyH(),
                          TextFieldComponent(
                            titleController,
                            lableText: StringConstants.name,
                          ),
                          TextFieldComponent(
                            priceController,
                            lableText: StringConstants.price,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                          ),
                          TextFieldComponent(
                            descriptionController,
                            lableText: StringConstants.description,
                            keyboardType: TextInputType.multiline,
                            minLines: 3,
                            maxLines: 6,
                          ),
                          ButtonComponent(
                              title: StringConstants.addProduct.toUpperCase(),
                              loading: state.isLoading,
                              onpressed: () {
                                context.read<AddProductCubit>().addProduct({
                                  "title": titleController.text,
                                  "description": descriptionController.text,
                                  "price": priceController.text,
                                }, context);
                              })
                        ],
                      )),
                );
              },
            )));
  }
}
