class Config {
  static const String _baseUrlKey = 'baseUrl';
  static const String _supabaseKey = 'supabaseKey';
  static const String _supabaseAnonKey = 'supabaseAnonKey';

  static final _dev = {
    _baseUrlKey: 'team-sphere-backend.vercel.app/',
    _supabaseKey: 'https://gqrrkswdhnhahfvgjzkj.supabase.co',
    _supabaseAnonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdxcnJrc3dkaG5oYWhmdmdqemtqIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyNDg1ODk3NSwiZXhwIjoyMDQwNDM0OTc1fQ.j28iabgnc4hJwOD0EC_QsV2DnLk0UYelPm6FAfU4fAU',
  };

  static String get baseUrl => _dev[_baseUrlKey] as String;
  static String get supabaseKey => _dev[_supabaseKey] as String;
  static String get supabaseAnonKey => _dev[_supabaseAnonKey] as String;
}
