/// AUTO GENERATED FILE, DO NOT EDIT.
///
/// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

/// Holds the Dynamic library.
ffi.DynamicLibrary _dylib;

/// Initialises the Dynamic library.
void init(ffi.DynamicLibrary dylib) {
  _dylib = dylib;
}

double Function1Double(
  double x,
) {
  return _Function1Double(
    x,
  );
}

final _dart_Function1Double _Function1Double =
    _dylib.lookupFunction<_c_Function1Double, _dart_Function1Double>(
        'Function1Double');

typedef _c_Function1Double = ffi.Double Function(
  ffi.Double x,
);

typedef _dart_Function1Double = double Function(
  double x,
);

double Function1Float(
  double x,
) {
  return _Function1Float(
    x,
  );
}

final _dart_Function1Float _Function1Float = _dylib
    .lookupFunction<_c_Function1Float, _dart_Function1Float>('Function1Float');

typedef _c_Function1Float = ffi.Float Function(
  ffi.Float x,
);

typedef _dart_Function1Float = double Function(
  double x,
);

int Function1Int16(
  int x,
) {
  return _Function1Int16(
    x,
  );
}

final _dart_Function1Int16 _Function1Int16 = _dylib
    .lookupFunction<_c_Function1Int16, _dart_Function1Int16>('Function1Int16');

typedef _c_Function1Int16 = ffi.Int16 Function(
  ffi.Int16 x,
);

typedef _dart_Function1Int16 = int Function(
  int x,
);

int Function1Int32(
  int x,
) {
  return _Function1Int32(
    x,
  );
}

final _dart_Function1Int32 _Function1Int32 = _dylib
    .lookupFunction<_c_Function1Int32, _dart_Function1Int32>('Function1Int32');

typedef _c_Function1Int32 = ffi.Int32 Function(
  ffi.Int32 x,
);

typedef _dart_Function1Int32 = int Function(
  int x,
);

int Function1Int64(
  int x,
) {
  return _Function1Int64(
    x,
  );
}

final _dart_Function1Int64 _Function1Int64 = _dylib
    .lookupFunction<_c_Function1Int64, _dart_Function1Int64>('Function1Int64');

typedef _c_Function1Int64 = ffi.Int64 Function(
  ffi.Int64 x,
);

typedef _dart_Function1Int64 = int Function(
  int x,
);

int Function1Int8(
  int x,
) {
  return _Function1Int8(
    x,
  );
}

final _dart_Function1Int8 _Function1Int8 = _dylib
    .lookupFunction<_c_Function1Int8, _dart_Function1Int8>('Function1Int8');

typedef _c_Function1Int8 = ffi.Int8 Function(
  ffi.Int8 x,
);

typedef _dart_Function1Int8 = int Function(
  int x,
);

int Function1IntPtr(
  int x,
) {
  return _Function1IntPtr(
    x,
  );
}

final _dart_Function1IntPtr _Function1IntPtr =
    _dylib.lookupFunction<_c_Function1IntPtr, _dart_Function1IntPtr>(
        'Function1IntPtr');

typedef _c_Function1IntPtr = ffi.IntPtr Function(
  ffi.IntPtr x,
);

typedef _dart_Function1IntPtr = int Function(
  int x,
);

int Function1Uint16(
  int x,
) {
  return _Function1Uint16(
    x,
  );
}

final _dart_Function1Uint16 _Function1Uint16 =
    _dylib.lookupFunction<_c_Function1Uint16, _dart_Function1Uint16>(
        'Function1Uint16');

typedef _c_Function1Uint16 = ffi.Uint16 Function(
  ffi.Uint16 x,
);

typedef _dart_Function1Uint16 = int Function(
  int x,
);

int Function1Uint32(
  int x,
) {
  return _Function1Uint32(
    x,
  );
}

final _dart_Function1Uint32 _Function1Uint32 =
    _dylib.lookupFunction<_c_Function1Uint32, _dart_Function1Uint32>(
        'Function1Uint32');

typedef _c_Function1Uint32 = ffi.Uint32 Function(
  ffi.Uint32 x,
);

typedef _dart_Function1Uint32 = int Function(
  int x,
);

int Function1Uint64(
  int x,
) {
  return _Function1Uint64(
    x,
  );
}

final _dart_Function1Uint64 _Function1Uint64 =
    _dylib.lookupFunction<_c_Function1Uint64, _dart_Function1Uint64>(
        'Function1Uint64');

typedef _c_Function1Uint64 = ffi.Uint64 Function(
  ffi.Uint64 x,
);

typedef _dart_Function1Uint64 = int Function(
  int x,
);

int Function1Uint8(
  int x,
) {
  return _Function1Uint8(
    x,
  );
}

final _dart_Function1Uint8 _Function1Uint8 = _dylib
    .lookupFunction<_c_Function1Uint8, _dart_Function1Uint8>('Function1Uint8');

typedef _c_Function1Uint8 = ffi.Uint8 Function(
  ffi.Uint8 x,
);

typedef _dart_Function1Uint8 = int Function(
  int x,
);

class Struct1 extends ffi.Struct {
  @ffi.Int8()
  int a;

  @ffi.Int32()
  int _data_item_0;
  @ffi.Int32()
  int _data_item_1;
  @ffi.Int32()
  int _data_item_2;
  @ffi.Int32()
  int _data_item_3;
  @ffi.Int32()
  int _data_item_4;
  @ffi.Int32()
  int _data_item_5;

  /// Helper for array `data`.
  ArrayHelper_Struct1_data_level0 get data =>
      ArrayHelper_Struct1_data_level0(this, [3, 1, 2], 0, 0);
}

/// Helper for array `data` in struct `Struct1`.
class ArrayHelper_Struct1_data_level0 {
  final Struct1 _struct;
  final List<int> dimensions;
  final int level;
  final int _absoluteIndex;
  int get length => dimensions[level];
  ArrayHelper_Struct1_data_level0(
      this._struct, this.dimensions, this.level, this._absoluteIndex);
  void _checkBounds(int index) {
    if (index >= length || index < 0) {
      throw RangeError(
          'Dimension $level: index not in range 0..${length} exclusive.');
    }
  }

  ArrayHelper_Struct1_data_level1 operator [](int index) {
    _checkBounds(index);
    var offset = index;
    for (var i = level + 1; i < dimensions.length; i++) {
      offset *= dimensions[i];
    }
    return ArrayHelper_Struct1_data_level1(
        _struct, dimensions, level + 1, _absoluteIndex + offset);
  }
}

/// Helper for array `data` in struct `Struct1`.
class ArrayHelper_Struct1_data_level1 {
  final Struct1 _struct;
  final List<int> dimensions;
  final int level;
  final int _absoluteIndex;
  int get length => dimensions[level];
  ArrayHelper_Struct1_data_level1(
      this._struct, this.dimensions, this.level, this._absoluteIndex);
  void _checkBounds(int index) {
    if (index >= length || index < 0) {
      throw RangeError(
          'Dimension $level: index not in range 0..${length} exclusive.');
    }
  }

  ArrayHelper_Struct1_data_level2 operator [](int index) {
    _checkBounds(index);
    var offset = index;
    for (var i = level + 1; i < dimensions.length; i++) {
      offset *= dimensions[i];
    }
    return ArrayHelper_Struct1_data_level2(
        _struct, dimensions, level + 1, _absoluteIndex + offset);
  }
}

/// Helper for array `data` in struct `Struct1`.
class ArrayHelper_Struct1_data_level2 {
  final Struct1 _struct;
  final List<int> dimensions;
  final int level;
  final int _absoluteIndex;
  int get length => dimensions[level];
  ArrayHelper_Struct1_data_level2(
      this._struct, this.dimensions, this.level, this._absoluteIndex);
  void _checkBounds(int index) {
    if (index >= length || index < 0) {
      throw RangeError(
          'Dimension $level: index not in range 0..${length} exclusive.');
    }
  }

  int operator [](int index) {
    _checkBounds(index);
    switch (_absoluteIndex + index) {
      case 0:
        return _struct._data_item_0;
      case 1:
        return _struct._data_item_1;
      case 2:
        return _struct._data_item_2;
      case 3:
        return _struct._data_item_3;
      case 4:
        return _struct._data_item_4;
      case 5:
        return _struct._data_item_5;
      default:
        throw Exception('Invalid Array Helper generated.');
    }
  }

  void operator []=(int index, int value) {
    _checkBounds(index);
    switch (_absoluteIndex + index) {
      case 0:
        _struct._data_item_0 = value;
        break;
      case 1:
        _struct._data_item_1 = value;
        break;
      case 2:
        _struct._data_item_2 = value;
        break;
      case 3:
        _struct._data_item_3 = value;
        break;
      case 4:
        _struct._data_item_4 = value;
        break;
      case 5:
        _struct._data_item_5 = value;
        break;
      default:
        throw Exception('Invalid Array Helper generated.');
    }
  }
}

ffi.Pointer<Struct1> getStruct1() {
  return _getStruct1();
}

final _dart_getStruct1 _getStruct1 =
    _dylib.lookupFunction<_c_getStruct1, _dart_getStruct1>('getStruct1');

typedef _c_getStruct1 = ffi.Pointer<Struct1> Function();

typedef _dart_getStruct1 = ffi.Pointer<Struct1> Function();
