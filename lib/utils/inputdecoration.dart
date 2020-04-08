import 'package:flutter/material.dart';

const borderColor = Colors.green;

InputDecoration inputTextDoc = new InputDecoration(
  labelText: 'UserName',
  border: const OutlineInputBorder(
    borderSide: BorderSide(color: borderColor),
  ),
  enabledBorder:
      const OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: borderColor),
  ),
  labelStyle: const TextStyle(color: borderColor, fontWeight: FontWeight.w400),
);

const borderColor2 = Colors.white;

InputDecoration dailyTextDoc = new InputDecoration(
  labelText: 'Income',
  border: const OutlineInputBorder(
    borderSide: BorderSide(color: borderColor2),
  ),
  enabledBorder:
      const OutlineInputBorder(borderSide: BorderSide(color: borderColor2)),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: borderColor2),
  ),
  labelStyle: const TextStyle(color: borderColor2, fontWeight: FontWeight.w800),
);
