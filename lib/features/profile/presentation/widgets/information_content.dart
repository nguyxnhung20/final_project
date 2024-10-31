import 'package:final_project/features/profile/presentation/custom_title_and_content_in_item.dart';
import 'package:final_project/features/profile/presentation/information_section_widgets/date_picker_display.dart';
import 'package:final_project/features/profile/presentation/information_section_widgets/fullname_input.dart';
import 'package:final_project/features/profile/presentation/information_section_widgets/radio_gender_item.dart';
import 'package:final_project/features/profile/presentation/logic_holders/bloc/account_info_bloc.dart';
import 'package:final_project/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationContent extends StatefulWidget {
  const InformationContent({
    super.key,
  });

  @override
  State<InformationContent> createState() => _InformationContentState();
}

class _InformationContentState extends State<InformationContent> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final canUpdate =
        BlocProvider.of<AccountInfoBloc>(context, listen: true).canUpdate;

    return Column(
      children: [
        CustomTitleAndContentInItem(
          title: l10n.fullname,
          content: BlocSelector<AccountInfoBloc, AccountInfoState, String?>(
            selector: (state) {
              final fullnameFromFirestore =
                  state.accountDataFromFirestore?.fullName;
              final fullnameFromLocal = state.updatedLocalAccountData.fullName;
              return fullnameFromFirestore ?? fullnameFromLocal ?? '';
            },
            builder: (context, selectedValue) {
              return TextInput(
                currentValue: selectedValue,
                keyboardType: TextInputType.text,
                onChanged: (newValue) {
                  BlocProvider.of<AccountInfoBloc>(context)
                      .add(UpdateFullname(newName: newValue));
                },
                hintText: l10n.fullname,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        CustomTitleAndContentInItem(
          title: l10n.dateOfBirth,
          content: BlocSelector<AccountInfoBloc, AccountInfoState, DateTime?>(
            selector: (state) {
              final dobFromFirestore = state.accountDataFromFirestore?.dob;
              final dobFromLocal = state.updatedLocalAccountData.dob;
              return dobFromLocal ?? dobFromFirestore;
            },
            builder: (context, value) {
              return DatePickerDisplay(
                selectedDate: value,
                onTap: () async {
                  // Ensure `initialDate` is before or equal to `lastDate`
                  DateTime initialDate = value ?? DateTime.now();
                  DateTime lastDate = DateTime.now();

                  if (initialDate.isAfter(lastDate)) {
                    initialDate = lastDate;
                  }

                  final result = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime(1900),
                    lastDate: lastDate,
                  );

                  if (result != null && context.mounted) {
                    BlocProvider.of<AccountInfoBloc>(context)
                        .add(UpdateDob(newDob: result));
                  }
                },
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        CustomTitleAndContentInItem(
          title: l10n.phoneNumber,
          content: BlocSelector<AccountInfoBloc, AccountInfoState, String?>(
            selector: (state) {
              final phoneNumFromFirestore =
                  state.accountDataFromFirestore?.phoneNumber;
              final phoneNumFromLocal =
                  state.updatedLocalAccountData.phoneNumber;
              return phoneNumFromFirestore ?? phoneNumFromLocal ?? '';
            },
            builder: (context, selectedValue) {
              return TextInput(
                currentValue: selectedValue,
                keyboardType: TextInputType.phone,
                onChanged: (newValue) {
                  BlocProvider.of<AccountInfoBloc>(context)
                      .add(UpdatePhoneNum(newPhoneNum: newValue));
                },
                hintText: l10n.phoneNumber,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        CustomTitleAndContentInItem(
          title: l10n.email,
          content: BlocSelector<AccountInfoBloc, AccountInfoState, String?>(
            selector: (state) {
              final emailFromFirestore = state.accountDataFromFirestore?.email;
              final emailFromLocal = state.updatedLocalAccountData.email;
              return emailFromFirestore ?? emailFromLocal ?? '';
            },
            builder: (context, selectedValue) {
              return TextInput(
                currentValue: selectedValue,
                keyboardType: TextInputType.emailAddress,
                onChanged: (newValue) {
                  BlocProvider.of<AccountInfoBloc>(context)
                      .add(UpdateEmail(newEmail: newValue));
                },
                hintText: l10n.email,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        CustomTitleAndContentInItem(
          title: l10n.gender,
          content: BlocSelector<AccountInfoBloc, AccountInfoState, int?>(
            selector: (state) {
              final genderFromFirestore =
                  state.accountDataFromFirestore?.gender;
              final genderFromLocal = state.updatedLocalAccountData.gender;
              return genderFromLocal ?? genderFromFirestore;
            },
            builder: (context, selectedGender) {
              return Row(
                children: [
                  RadioGenderItem(
                    radioValue: 1,
                    selectedValue: selectedGender,
                    onTap: () {
                      BlocProvider.of<AccountInfoBloc>(context)
                          .add(UpdateGender(newGender: 1));
                    },
                  ),
                  const SizedBox(width: 4),
                  RadioGenderItem(
                    radioValue: 2,
                    selectedValue: selectedGender,
                    onTap: () {
                      BlocProvider.of<AccountInfoBloc>(context)
                          .add(UpdateGender(newGender: 2));
                    },
                  ),
                  const SizedBox(width: 4),
                  RadioGenderItem(
                    radioValue: 3,
                    selectedValue: selectedGender,
                    onTap: () {
                      BlocProvider.of<AccountInfoBloc>(context)
                          .add(UpdateGender(newGender: 3));
                    },
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            onPressed: canUpdate
                ? () {
                    FocusScope.of(context).unfocus();
                    BlocProvider.of<AccountInfoBloc>(context).add(SaveInfo());
                  }
                : null,
            style: ButtonStyle(
              backgroundColor:
                  canUpdate ? null : MaterialStateProperty.all(Colors.grey),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              ),
            ),
            child: Text(l10n.save, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

extension GenderExtension on int? {
  String toGenderString(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      1 => l10n.male,
      2 => l10n.female,
      3 => l10n.other,
      _ => l10n.unknown,
    };
  }
}
