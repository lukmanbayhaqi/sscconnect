import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/components/form-input-checkbox.dart';
import 'package:sscconnect/components/form-input-date-slider.dart';
import 'package:sscconnect/components/form-input-datetime-slider.dart';
import 'package:sscconnect/components/form-input-radio-btn.dart';
import 'package:sscconnect/components/form-input-time-slider.dart';
import 'package:sscconnect/components/form-input-money.dart';
import 'package:sscconnect/components/form-input-phone-number.dart';
import 'package:flutter/material.dart';

enum CInputType {
  text,
  textArea,
  password,
  number,
  phoneNumber,
  emailAddress,
  money,
  // DropDown,
  radioBtn,
  toggle,
  date,
  dateSlider,
  datetime,
  datetimeSlider,
  timeSlider,
  time,
  file,
  checkBox,
}

class CFormInput extends StatelessWidget {
  final bool? vIf;
  final String? label;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged? onChange;
  final CInputType inputType;
  final FocusNode? focusNode;
  final dynamic defaultValue;
  final DateTime? maxDate;
  final DateTime? minDate;
  final bool disabled;
  final double? borderRadius;
  final List<String>? items;
  final bool? isMandatory;

  const CFormInput({
    Key? key,
    this.vIf = true,
    this.label,
    this.description,
    this.invalidMessage,
    this.invalidMessages,
    this.onChange,
    this.inputType = CInputType.text,
    this.focusNode,
    this.defaultValue,
    this.maxDate,
    this.minDate,
    this.disabled = false,
    this.borderRadius,
    this.items,
    this.isMandatory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vIf != null) {
      if (vIf == false) {
        return SizedBox();
      }
    }

    if (inputType == CInputType.textArea) {
      return CFormInputTextarea(
        label: label,
        description: description,
        invalidMessage: invalidMessage,
        invalidMessages: invalidMessages,
        onChange: onChange,
        defaultValue: defaultValue,
      );
    }

    if (inputType == CInputType.toggle) {
      return CFormInputToggle(
        label: label,
        description: description,
        invalidMessage: invalidMessage,
        invalidMessages: invalidMessages,
        onChange: onChange,
      );
    }

    if (inputType == CInputType.checkBox) {
      return CFormInputCheckBox(
        label: label,
        description: description,
        invalidMessage: invalidMessage,
        invalidMessages: invalidMessages,
        onChange: onChange,
        defaultValue: defaultValue,
        disabled: disabled,
      );
    }

    if (inputType == CInputType.dateSlider) {
      return CFormInputDateSlider(
        label: label,
        description: description,
        invalidMessage: invalidMessage,
        invalidMessages: invalidMessages,
        defaultValue: defaultValue,
        onChange: onChange,
        minDate: minDate,
        maxDate: maxDate,
        disabled: disabled,
        borderRadius: borderRadius,
      );
    }

    if (inputType == CInputType.datetimeSlider) {
      return CFormInputDateTimeSlider(
        label: label,
        description: description,
        invalidMessage: invalidMessage,
        invalidMessages: invalidMessages,
        defaultValue: defaultValue,
        onChange: onChange,
        minDate: minDate,
        maxDate: maxDate,
        disabled: disabled,
      );
    }

    if (inputType == CInputType.timeSlider) {
      return CFormInputTimeSlider(
        label: label,
        description: description,
        invalidMessage: invalidMessage,
        invalidMessages: invalidMessages,
        defaultValue: defaultValue,
        onChange: onChange,
        minDate: minDate,
        maxDate: maxDate,
        disabled: disabled,
      );
    }

    if (inputType == CInputType.phoneNumber) {
      return CFormInputPhoneNumber(
        label: label,
        description: description,
        invalidMessage: invalidMessage,
        invalidMessages: invalidMessages,
        onChange: onChange,
        defaultValue: defaultValue,
      );
    }

    if (inputType == CInputType.file) {
      return CFormInputFile(
        label: label,
        description: description,
        invalidMessage: invalidMessage,
        invalidMessages: invalidMessages,
        onChange: onChange,
      );
    }

    if (inputType == CInputType.password) {
      return CFormInputPassword(
        label: label,
        description: description,
        invalidMessage: invalidMessage,
        invalidMessages: invalidMessages,
        onChange: onChange,
      );
    }

    if (inputType == CInputType.number) {
      return CFormInputNumber(
        label: label,
        description: description,
        invalidMessage: invalidMessage,
        invalidMessages: invalidMessages,
        onChange: onChange,
        defaultValue: defaultValue,
      );
    }

    if (inputType == CInputType.money) {
      return CFormInputMoney(
        label: label,
        description: description,
        invalidMessage: invalidMessage,
        invalidMessages: invalidMessages,
        onChange: onChange,
        defaultValue: defaultValue,
        borderRadius: borderRadius,
      );
    }

    if (inputType == CInputType.radioBtn) {
      return CFormInputRadioBtn(
        label: label,
        description: description,
        invalidMessage: invalidMessage,
        invalidMessages: invalidMessages,
        onChange: onChange,
        defaultValue: defaultValue,
        items: items ?? [],
      );
    }

    // if(inputType == CInputType.DropDown) {
    //   return CFormInputDropdown(
    //     label: label,
    //     description: description,
    //     invalidMessage: invalidMessage,
    //     invalidMessages: invalidMessages,
    //     onChange: onChange,
    //     itemBuilder: (a, i) => SizedBox(),
    //   );
    // }

    return CFormInputText(
      label: label,
      description: description,
      invalidMessage: invalidMessage,
      invalidMessages: invalidMessages,
      onChange: onChange,
      defaultValue: defaultValue,
      isMandatory: isMandatory,
    );
  }
}
