import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data.dart';
import '../domain.dart';
import '../presentation.dart';

/// Core Feature Providers
class CoreProviders {
  
  // Data
  
  
  /// Local Datasource
  static final Provider<CoreDatasource> coreLocalDatasource =
      Provider((ref) => CoreLocalDatasource());
  
  /// Remote Datasource
  static final Provider<CoreDatasource> coreRemoteDatasource =
      Provider((ref) => CoreRemoteDatasource());

  // Domain
  /// Repository
  static final Provider<CoreRepository> coreRepository =
      Provider((ref) => CoreRepositoryImpl());

  // Presentation
  /// Controller
  static final Provider<CoreController> coreController =
      Provider((ref) => CoreController());

}
