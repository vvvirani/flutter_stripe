class HeaderBuilder {
  final Map<String, String> _header;

  HeaderBuilder._(this._header);

  static HeaderBuilder builder() => HeaderBuilder._({});

  HeaderBuilder setContentType(String type) {
    _header['Content-Type'] = type;
    return this;
  }

  HeaderBuilder setBearerToken(String token) {
    _header['Authorization'] = 'Bearer $token';
    return this;
  }

  HeaderBuilder setExtra(String key, String? value) {
    if (value != null) _header[key] = value;
    return this;
  }

  Map<String, String> build() => _header;
}
