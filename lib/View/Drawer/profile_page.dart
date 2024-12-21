import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Services/storage_sevices.dart';
import 'package:goolu/Utils/font_styles.dart';

import '../../Components/app_custom_button.dart';
import '../../Components/app_form_field.dart';
import '../../Components/app_form_field_phone.dart';
import '../../Controller/SideDrawerController/side_drawer_controller.dart';
import '../../Model/UserModel/usersModel.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SideDrawerController sideDrawerController = Get.find<SideDrawerController>();
  @override
  void initState() {
    sideDrawerController.usernameCtrl.text =
        AppStorage.getUserData()?.username ?? '';
    sideDrawerController.iqamaNumberCtrl.text =
        AppStorage.getUserData()?.iqamaNumber ?? '';
    sideDrawerController.phoneNumberCtrl.text =
        AppStorage.getUserData()?.phoneNumber ?? '';
    sideDrawerController.dateOfBirthCtrl.text =
        AppStorage.getUserData()?.dob ?? '';
    sideDrawerController.selectedItem =
        AppStorage.getUserData()?.country ?? 'USA';
    sideDrawerController.selectedGenderItem =
        AppStorage.getUserData()?.gender ?? 'Male';
    sideDrawerController.addressCtrl.text =
        AppStorage.getUserData()?.address ?? '';
    sideDrawerController.emailCtrl.text = AppStorage.getUserData()?.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: Scaffold(
        appBar: AppBar(
            // automaticallyImplyLeading: false,
            // leading: SvgPicture.asset(
            //   '$gooluLogoUrl$dotGooluLogo',
            //   height: 30,
            //   width: 30,
            // ),
            // title: Row(
            //   children: [SvgPicture.asset('$gooluLogoUrl$dotGooluLogo')],
            // ),
            ),
        body: GetBuilder<SideDrawerController>(
            builder: (SideDrawerController sideDrawerCtrl) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(
                    vertical: SizesDimensions.height(3),
                    horizontal: SizesDimensions.width(3),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft:
                            Radius.circular(Dimensions.radiusDoubleExtraLarge),
                        topRight:
                            Radius.circular(Dimensions.radiusDoubleExtraLarge)),
                    color: kLightYellow.withOpacity(0.3),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: customText(
                            text: 'Edit profile',
                            textStyle: bold18NavyBlue,
                          ),
                        ),
                        size20h,
                        AppFormField(
                          padding: EdgeInsets.zero,
                          controller: sideDrawerCtrl.usernameCtrl,
                          labelText: 'User name',
                          hintText: 'Puerto Rico',
                          keyboardType: TextInputType.text,
                          // contextMenuBuilder: true,
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return 'Full name required';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            sideDrawerCtrl.update();
                          },
                        ),
                        size20h,
                        AppFormField(
                          fieldBgColor: kF8F9FF,
                          borderColor: kDarkGreen5b99a5,
                          controller: sideDrawerCtrl.iqamaNumberCtrl,
                          labelText: 'Iqama Number',
                          hintText: '1234567890',
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return 'Iqama number required';
                            }
                            return null;
                          },
                        ),
                        size20h,
                        AppFormField(
                            fieldBgColor: kF8F9FF,
                            borderColor: kDarkGreen5b99a5,
                            controller: sideDrawerCtrl.emailCtrl,
                            labelText: 'Email',
                            hintText: 'accountname@domain.com',
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? v) {
                              if (v!.isEmpty) {
                                return 'Email required';
                              }
                              return null;
                            }),
                        size20h,
                        AppFormFieldPhone(
                          padding: EdgeInsets.zero,
                          controller: sideDrawerCtrl.phoneNumberCtrl,
                          labelText: 'Phone number',
                          hintText: '516497520',
                          keyboardType: TextInputType.number,
                          // contextMenuBuilder: true,
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return 'Phone number required';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            sideDrawerCtrl.update();
                          },
                        ),
                        size20h,
                        AppFormField(
                          controller: sideDrawerCtrl.dateOfBirthCtrl,
                          labelText: 'dateOfBirth'.tr,
                          hintText: 'dateOfBirth'.tr,
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          onTap: () {
                            sideDrawerCtrl.selectedDate(context);
                          },
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return 'dateOfBirthRequired'.tr;
                            }
                            return null;
                          },
                          onChanged: (v) {
                            sideDrawerCtrl.update();
                          },
                        ),
                        size20h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: SizesDimensions.height(6.0),
                              width: SizesDimensions.width(45.0),
                              margin: EdgeInsets.only(
                                bottom: SizesDimensions.height(0.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: customText(
                                        text: 'Country',
                                        textStyle: regular14NavyBlue.copyWith(
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                      )),
                                  items: sideDrawerCtrl.countryList.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: customText(
                                        text: e,
                                        textStyle: bold14NavyBlue.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  value: sideDrawerCtrl.selectedItem,
                                  onChanged: (String? value) {
                                    setState(() {
                                      sideDrawerCtrl.selectedItem = value;
                                      // Print selected key and value
                                      if (value != null) {
                                        debugPrint('Selected key: $value');
                                        debugPrint(
                                            'Selected value: ${sideDrawerCtrl.selectedItem}');
                                      }
                                    });
                                  },
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: SizesDimensions.height(50.0),
                                    width: SizesDimensions.width(50.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Theme.of(context)
                                          .dialogBackgroundColor,
                                    ),
                                    offset: const Offset(-5, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness: WidgetStateProperty.all(6),
                                      thumbVisibility:
                                          WidgetStateProperty.all(true),
                                    ),
                                  ),
                                  buttonStyleData: ButtonStyleData(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radiusDefault)),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: SizesDimensions.width(2.0),
                                    ),
                                    height: SizesDimensions.height(6.0),
                                    width: Get.width,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: SizesDimensions.height(6.0),
                              width: SizesDimensions.width(45.0),
                              margin: EdgeInsets.only(
                                bottom: SizesDimensions.height(0.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: customText(
                                      text: 'Gender',
                                      textStyle: regular14NavyBlue.copyWith(
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color),
                                    ),
                                  ),
                                  items: sideDrawerCtrl.genderList.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: customText(
                                        text: e,
                                        textStyle: bold14NavyBlue.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  value: sideDrawerCtrl.selectedGenderItem,
                                  onChanged: (String? value) {
                                    setState(() {
                                      sideDrawerCtrl.selectedGenderItem = value;
                                      // Print selected key and value
                                      if (value != null) {
                                        debugPrint('Selected key: $value');
                                        debugPrint(
                                            'Selected value: ${sideDrawerCtrl.selectedGenderItem}');
                                      }
                                    });
                                  },
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: SizesDimensions.height(50.0),
                                    width: SizesDimensions.width(50.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Theme.of(context)
                                          .dialogBackgroundColor,
                                    ),
                                    offset: const Offset(-5, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness: WidgetStateProperty.all(6),
                                      thumbVisibility:
                                          WidgetStateProperty.all(true),
                                    ),
                                  ),
                                  buttonStyleData: ButtonStyleData(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radiusDefault)),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: SizesDimensions.width(2.0),
                                    ),
                                    height: SizesDimensions.height(6.0),
                                    width: Get.width,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        size20h,
                        AppFormField(
                          padding: EdgeInsets.zero,
                          controller: sideDrawerCtrl.addressCtrl,
                          labelText: 'Address',
                          hintText: 'H#123',
                          keyboardType: TextInputType.text,
                          // contextMenuBuilder: true,
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return 'Address required';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            sideDrawerCtrl.update();
                          },
                        ),
                        size70h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppCustomButton(
                              title: customText(
                                text: 'Submit',
                                textStyle: regular14White,
                              ),
                              onTap: () async {
                                showProgress();
                                UserModel updatedUser = UserModel(
                                  username: sideDrawerCtrl.usernameCtrl.text,
                                  userId:
                                      AppStorage.getUserData()?.userId ?? '',
                                  dob: sideDrawerCtrl.dateOfBirthCtrl.text,
                                  email: sideDrawerCtrl.emailCtrl.text,
                                  phoneNumber:
                                      sideDrawerCtrl.phoneNumberCtrl.text,
                                  iqamaNumber:
                                      sideDrawerCtrl.iqamaNumberCtrl.text,
                                  profilePicture: '',
                                  country: sideDrawerCtrl.selectedItem ?? 'USA',
                                  gender: sideDrawerCtrl.selectedGenderItem ??
                                      'Male',
                                  address: sideDrawerCtrl.addressCtrl.text,
                                  packageStartDate: AppStorage.getUserData()
                                          ?.packageStartDate ??
                                      '',
                                  packageEndExpiry: AppStorage.getUserData()
                                          ?.packageEndExpiry ??
                                      '',
                                  isPackage:
                                      AppStorage.getUserData()?.isPackage ?? '',
                                  packageType:
                                      AppStorage.getUserData()?.packageType ??
                                          '',
                                );

                                sideDrawerCtrl.updateUserData(updatedUser);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
