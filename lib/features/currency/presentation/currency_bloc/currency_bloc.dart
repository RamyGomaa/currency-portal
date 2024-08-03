import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:currency_converter/features/currency/domain/usecases/get_currency_list_usecase.dart';
import 'package:currency_converter/shared/domain/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import '../../domain/entities/currency_entity.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  GetCurrencyListUsecase getCurrencyListUsecase;

  CurrencyBloc(
    this.getCurrencyListUsecase,
  ) : super(CurrencyInitial()) {
    on<CurrencyEvent>((event, emit) async {
      if (event is GetCurrencyListEvent) {
        emit(CurrencyLoading());
        var res = await getCurrencyListUsecase(NoParams());
        res.fold(
          (l) => emit(CurrencyError(message: l.message)),
          (r) => emit(CurrencyLoaded(currencyData: r)),
        );
      }
    });
  }
  Future<File> loadBase64Image(String base64Image, String currencyCode) async {
    try {
      // Get the temporary directory of the app
      Directory tempDir = await getTemporaryDirectory();

      // Create a temporary file in the directory
      String fileName = '${currencyCode}_cached_base64_image.png';
      File file = File(path.join(tempDir.path, fileName));
      // Check if the file already exists
      if (await file.exists()) {
        return file;
      }

      // Decode the base64 string
      Uint8List bytes = base64Decode(base64Image.split(',').last);
      // Ensure that bytes are not empty
      if (bytes.isEmpty) {
        throw Exception('Empty image data');
      }
      // Write the bytes to the file
      await file.writeAsBytes(bytes);

      return file;
    } catch (e) {
      rethrow;
    }
  }
}
