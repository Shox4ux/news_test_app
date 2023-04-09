import '../../../utils/constants/nums.dart';
import '../../../utils/constants/strings.dart';

class BreakingNewsRequest {
  final String apiKey;
  final int page;
  final String query;
  final int pageSize;

  BreakingNewsRequest({
    this.apiKey = defaultApiKey,
    this.query = "apple",
    this.page = 1,
    this.pageSize = defaultPageSize,
  });
}
