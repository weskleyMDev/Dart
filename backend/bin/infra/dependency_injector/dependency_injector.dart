typedef InstanceCreator<T> = T Function();

class DependencyInjector {
  static final _singleton = DependencyInjector._();

  DependencyInjector._();

  factory DependencyInjector() => _singleton;

  //GUARDA AS INSTANCIAS GERADAS
  final _instanceMap = <Type, _InstanceGenerator<Object>>{};

  //REGISTRA OS OBJETOS GERADOS COMO SINGLETON OU FACTORY
  void register<T extends Object>(
    InstanceCreator<T> instance, {
    bool isSingleton = true,
  }) =>
      _instanceMap[T] = _InstanceGenerator(instance, isSingleton);

  //RETORNA O OBJETO REGISTRADO
  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();
    if (instance != null && instance is T) {
      return instance;
    }
    throw Exception("[ERROR] -> Instance ${T.toString()} not found!");
  }
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;
  final InstanceCreator<T> _instanceCreator;

  _InstanceGenerator(this._instanceCreator, bool isSingleton)
      : _isFirstGet = isSingleton;

  T? getInstance() {
    //GERA A INSTANCIA SE FOR UM SINGLETON
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }
    //SE NÃO FOR UM SINGLETON GERA AS FACTORYS DO OBJETO
    return (_instance != null) ? _instance : _instanceCreator();
  }
}
