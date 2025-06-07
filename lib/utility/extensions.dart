part of 'utility.dart';

// extension UrlStringExtensions on String {
//   String attachHost() {
//     return "${Keys.apiBaseUrlV1}$this";
//   }

//   String attachQueryParams(Map<String, String> params) {
//     if (params.isEmpty) return "";
//     final queryString = params.entries
//         .map(
//           (entry) =>
//               "${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}",
//         )
//         .join("&");
//     return "$this?$queryString";
//   }

//   String attachRouteParams(Map<String, String> routeParams) {
//     var updatedUrl = this;
//     routeParams.forEach((key, value) {
//       updatedUrl = updatedUrl.replaceAll(':$key', Uri.encodeComponent(value));
//     });
//     return updatedUrl;
//   }
// }

extension MapExtensions on Map<String, dynamic> {
  Map<String, dynamic> clean() {
    removeWhere((key, value) => value == null || value == '');
    return this;
  }
}

extension BoolExtensions on bool {
  int toInt() {
    return this ? 1 : 0;
  }
}
