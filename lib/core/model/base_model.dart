
import 'error_model.dart';

abstract class BaseModel<T> {
  ErrorModel? error;
  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json);
}
