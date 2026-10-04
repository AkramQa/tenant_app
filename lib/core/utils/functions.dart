DateTime? convertStringToDate(String? dateAsString) => DateTime.tryParse(dateAsString ?? '');

String? convertDateToString(DateTime? date) => date?.toIso8601String();

DateTime convertStringToRequiredDate(String dateAsString) => DateTime.parse(dateAsString);

String convertRequiredDateToString(DateTime date) => date.toIso8601String();
