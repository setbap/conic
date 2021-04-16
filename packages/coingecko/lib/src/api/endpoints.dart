class Endpoints {
  // ping
  static String ping() => '/ping';

  // simple
  static String simplePrice() => '/simple/price';
  static String simpleTokenPriceId({required String id}) =>
      '/simple/token_price/$id';

  // coins
  static String simpleSupportVsCurrencies() =>
      '/simple/supported_vs_currencies';
  static String coinsMarkets() => '/coins/markets';
  static String coinsId({required String id}) => '/coins/$id';
  static String coinsIdTickers({required String id}) => '/coins/$id/tickers';
  static String coinsIdHistory({required String id}) => '/coins/$id/history';
  static String coinsIdMarketChart({required String id}) =>
      '/coins/$id/market_chart';
  static String coinsIdMarketChartRange({required String id}) =>
      '/coins/$id/market_chart/range';
  static String coinsIdStatusUpdates({required String id}) =>
      '/coins/$id/status_updates';
  static String coinsIdOHLC({required String id}) => '/coins/$id/ohlc';

  // contract
  static String coinsIdContractAddress({
    required String id,
    required String contractAddress,
  }) =>
      '/coins/$id/contract/$contractAddress';

  static String coinsIdContractAddressMarketChart({
    required String id,
    required String contractAddress,
  }) =>
      '/coins/$id/contract/$contractAddress/market_chart/';

  static String coinsIdContractAddressMarketChartRange({
    required String id,
    required String contractAddress,
  }) =>
      '/coins/$id/contract/$contractAddress/market_chart/Range';

  // Exchanges
  static String exchanges() => '/exchanges';
  static String exchangesList() => '/exchanges/list';
  static String exchangesId({required String id}) => '/exchanges/$id';
  static String exchangesIdTickers({required String id}) =>
      '/exchanges/$id/tickers';
  static String exchangesIdStatusUpdate({required String id}) =>
      '/exchanges/$id/status_updates';

  static String exchangesIdVolumeChart({required String id}) =>
      '/exchanges/$id/volume_chart';

  // Finance
  static String financePlatforms() => '/finance_platforms';
  static String financeProducts() => '/finance_products';

  // indexes
  static String indexes() => '/indexes';
  static String indexesMarketsIdId({
    required String id,
    required String marketId,
  }) =>
      '/indexes/$marketId/$id';
  static String indexesList() => '/indexes/list';
  static String indexesListMarketsIdId({
    required String id,
    required String marketId,
  }) =>
      '/indexes/list_by_market_and_id/$marketId/$id';

// Derivatives
  // Exchanges
  static String derivatives() => '/derivatives';
  static String derivativesExchanges() => '/derivatives/exchanges';
  static String derivativesExchangesId({required String id}) =>
      '/derivatives/exchanges/$id';
  static String derivativesExchangesList({required String id}) =>
      '/derivatives/exchanges/list';

// status_updates
  static String statusUpdates() => '/status_updates';

// events
  static String events() => '/events';
  static String eventsCountries() => '/events/countries';
  static String eventsTypes() => '/events/types';

  // exchange_rates
  static String exchangeRates() => '/exchange_rates';

  // trending
  static String searchTrending() => '/search/trending';

  // global
  static String global() => '/global';
  static String globalDecentralizedFinanceDefi() =>
      '/global/decentralized_finance_defi';
}
