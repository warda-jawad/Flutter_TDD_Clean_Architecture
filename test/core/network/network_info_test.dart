import 'package:connectivity/connectivity.dart';
import 'package:connectivity/connectivity.dart';
import 'package:first_tdd_app/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:connectivity/connectivity.dart';

class MockDataConnectionChecker extends Mock implements Connectivity {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(' should forward the call to Connectivity', () async {
      if (mockDataConnectionChecker.checkConnectivity().toString() != null) {
        final tHasConnectionFuture = Future.value(true);
        final connectionResult = await (Connectivity().checkConnectivity());
        // there is two result here for connectionResult : ConnectivityResult.mobile & ConnectivityResult.wifi
        final tHasConnection = Future.value(ConnectivityResult.mobile);
        //arrang
        ConnectivityResult connectivityResult =
            await (new Connectivity().checkConnectivity());
        print(connectivityResult);
        print("llllll");
        when(mockDataConnectionChecker.checkConnectivity())
            .thenAnswer((_) async => tHasConnection);
        //act
        // NOTIC: We're NoT awaiting the result;
        final result = networkInfo.isConnected;

        //  assert
        verify(mockDataConnectionChecker.checkConnectivity());
        //Utilizing Dart's default referential equality.
        //Only references to the same object are equal.
        expect(result, tHasConnection);
      }
    });
  });
}
