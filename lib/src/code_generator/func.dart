// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:ffigen/src/code_generator.dart';
import 'package:meta/meta.dart';

import 'binding.dart';
import 'binding_string.dart';
import 'type.dart';
import 'utils.dart';
import 'writer.dart';

/// A binding for C function.
///
/// For a C function -
/// ```c
/// int sum(int a, int b);
/// ```
/// The Generated dart code is -
/// ```dart
/// int sum(int a, int b) {
///   return _sum(a, b);
/// }
///
/// final _dart_sum _sum = _dylib.lookupFunction<_c_sum, _dart_sum>('sum');
///
/// typedef _c_sum = ffi.Int32 Function(ffi.Int32 a, ffi.Int32 b);
///
/// typedef _dart_sum = int Function(int a, int b);
/// ```
class Func extends LookUpBinding {
  final Type returnType;
  final List<Parameter> parameters;

  /// [originalName] is looked up in dynamic library, if not
  /// provided, takes the value of [name].
  Func({
    @required String name,
    String originalName,
    String dartDoc,
    @required this.returnType,
    List<Parameter> parameters,
  })  : parameters = parameters ?? [],
        super(
            originalName: originalName ?? name, name: name, dartDoc: dartDoc) {
    for (var i = 0; i < this.parameters.length; i++) {
      if (this.parameters[i].name == null ||
          this.parameters[i].name.trim() == '') {
        this.parameters[i].name = 'arg$i';
      }
    }
  }

  List<Typedef> _typedefDependencies;
  @override
  List<Typedef> getTypedefDependencies(Writer w) {
    if (_typedefDependencies == null) {
      _typedefDependencies = <Typedef>[];

      /// Ensure name conflicts are resolved for [cType] and [dartType] typedefs.
      cType.name = _uniqueTypedefName(cType.name, w);
      dartType.name = _uniqueTypedefName(dartType.name, w);

      // Add typedef's required by parameters.
      for (final p in parameters) {
        final base = p.type.getBaseType();
        if (base.broadType == BroadType.NativeFunction) {
          // Resolve name conflicts in typedef's required by parameters before using.
          base.nativeFunc.name = _uniqueTypedefName(base.nativeFunc.name, w);
          _typedefDependencies.add(base.nativeFunc);
        }
      }
      // Add C function typedef.
      _typedefDependencies.add(cType);
      // Add Dart function typedef.
      _typedefDependencies.add(dartType);
    }
    return _typedefDependencies;
  }

  /// Checks if typedef name is unique in both top level and wrapper level.
  /// And only marks it as used at top-level.
  String _uniqueTypedefName(String name, Writer w) {
    final base = name;
    var uniqueName = name;
    var suffix = 0;
    while (w.topLevelUniqueNamer.isUsed(uniqueName) ||
        w.wrapperLevelUniqueNamer.isUsed(uniqueName)) {
      suffix++;
      uniqueName = base + suffix.toString();
    }
    w.topLevelUniqueNamer.markUsed(uniqueName);
    return uniqueName;
  }

  Typedef _cType, _dartType;
  Typedef get cType => _cType ??= Typedef(
        name: '_c_$name',
        returnType: returnType,
        parameters: parameters,
        typedefType: TypedefType.C,
      );
  Typedef get dartType => _dartType ??= Typedef(
        name: '_dart_$name',
        returnType: returnType,
        parameters: parameters,
        typedefType: TypedefType.Dart,
      );

  @override
  BindingString toBindingString(Writer w) {
    final s = StringBuffer();
    final enclosingFuncName = name;
    final funcVarName = w.wrapperLevelUniqueNamer.makeUnique('_$name');

    if (dartDoc != null) {
      s.write(makeDartDoc(dartDoc));
    }

    // Write enclosing function.
    s.write('${returnType.getDartType(w)} $enclosingFuncName(\n');
    for (final p in parameters) {
      s.write('  ${p.type.getDartType(w)} ${p.name},\n');
    }
    s.write(') {\n');
    s.write(
        "$funcVarName ??= ${w.dylibIdentifier}.lookupFunction<${cType.name},${dartType.name}>('$originalName');\n");

    s.write('  return $funcVarName(\n');
    for (final p in parameters) {
      s.write('    ${p.name},\n');
    }
    s.write('  );\n');
    s.write('}\n');

    // Write function variable.
    s.write('${dartType.name} $funcVarName;\n\n');

    return BindingString(type: BindingStringType.func, string: s.toString());
  }
}

/// Represents a Function's parameter.
class Parameter {
  String name;
  final Type type;

  Parameter({this.name, @required this.type});
}
