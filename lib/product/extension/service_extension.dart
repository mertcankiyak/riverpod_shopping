import '../enums/service_enum.dart';

extension ServiceEnumExtension on ServiceEndpointEnum {
  String get rawValue {
    switch (this) {
      case ServiceEndpointEnum.getProductDetail:
        return "/api/2025-01/graphql.json";
    }
  }
}
