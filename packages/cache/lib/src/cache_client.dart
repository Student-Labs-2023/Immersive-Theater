abstract class CacheClient {
  void write<T extends Object>({required String key, required T value});

  T? read<T extends Object>({required String key});
}
