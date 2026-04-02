import 'package:flutter_datetime_picker_plus/src/date_format.dart';
import 'package:flutter_datetime_picker_plus/src/datetime_util.dart';
import 'package:flutter_datetime_picker_plus/src/date_model.dart';
import 'package:flutter_datetime_picker_plus/src/i18n_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('calcDateCount 大月 31 天', () {
    expect(calcDateCount(2024, 1), 31);
    expect(calcDateCount(2024, 3), 31);
    expect(calcDateCount(2024, 12), 31);
  });

  test('calcDateCount 小月 30 天', () {
    expect(calcDateCount(2024, 4), 30);
    expect(calcDateCount(2024, 6), 30);
  });

  test('calcDateCount 二月 闰年 29 天', () {
    expect(calcDateCount(2024, 2), 29);
    expect(calcDateCount(2000, 2), 29);
  });

  test('calcDateCount 二月 平年 28 天', () {
    expect(calcDateCount(2023, 2), 28);
    expect(calcDateCount(1900, 2), 28);
  });

  test('DatePickerModel finalTime 返回当前时间', () {
    final now = DateTime(2024, 6, 15);
    final model = DatePickerModel(currentTimeParam: now);
    expect(model.finalTime(), now);
  });

  test('formatDate digits dayInYear', () {
    final d = DateTime(2024, 6, 15);
    expect(formatDate(d, [yyyy], LocaleType.zh), '2024');
    expect(formatDate(d, [mm], LocaleType.zh), '06');
    expect(formatDate(d, [dd], LocaleType.zh), '15');
    expect(digits(5, 2), '05');
    expect(dayInYear(DateTime(2024, 1, 1)), 0);
    expect(dayInYear(DateTime(2024, 2, 29)), 59);
  });
}
