// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:ffigen/src/code_generator/utils.dart';
import 'package:meta/meta.dart';

import 'binding.dart';
import 'typedef.dart';

/// To store generated String bindings.
class Writer {
  final String header;

  /// Holds bindings, which lookup symbols.
  final List<Binding> lookUpBindings;

  /// Holds bindings which don't lookup symbols.
  final List<Binding> noLookUpBindings;

  String _className;
  final String classDocComment;

  String _ffiLibraryPrefix;
  String get ffiLibraryPrefix => _ffiLibraryPrefix;

  String _dylibIdentifier;
  String get dylibIdentifier => _dylibIdentifier;

  /// Initial namers set after running constructor. Namers are reset to this
  /// initial state everytime [generate] is called.
  UniqueNamer _initialTopLevelUniqueNamer, _initialWrapperLevelUniqueNamer;

  /// Used by [Binding]s for generating required code.
  UniqueNamer _topLevelUniqueNamer, _wrapperLevelUniqueNamer;
  UniqueNamer get topLevelUniqueNamer => _topLevelUniqueNamer;
  UniqueNamer get wrapperLevelUniqueNamer => _wrapperLevelUniqueNamer;

  String _arrayHelperClassPrefix;

  /// Guaranteed to be a unique prefix.
  String get arrayHelperClassPrefix => _arrayHelperClassPrefix;

  /// [_usedUpNames] should contain names of all the declarations which are
  /// already used. This is used to avoid name collisions.
  Writer({
    @required this.lookUpBindings,
    @required this.noLookUpBindings,
    @required String className,
    this.classDocComment,
    this.header,
  }) : assert(className != null) {
    final globalLevelNameSet = noLookUpBindings.map((e) => e.name).toSet();
    final wrapperLevelNameSet = lookUpBindings.map((e) => e.name).toSet();
    final allNameSet = <String>{}
      ..addAll(globalLevelNameSet)
      ..addAll(wrapperLevelNameSet);

    _initialTopLevelUniqueNamer = UniqueNamer(globalLevelNameSet);
    _initialWrapperLevelUniqueNamer = UniqueNamer(wrapperLevelNameSet);
    final allLevelsUniqueNamer = UniqueNamer(allNameSet);

    /// Wrapper class name must be unique among all names.
    _className = allLevelsUniqueNamer.makeUnique(className);
    _initialWrapperLevelUniqueNamer.markUsed(_className);
    _initialTopLevelUniqueNamer.markUsed(_className);

    /// [_ffiLibraryPrefix] should be unique in top level.
    _ffiLibraryPrefix = _initialTopLevelUniqueNamer.makeUnique('ffi');

    /// [_dylibIdentifier] should be unique in top level.
    _dylibIdentifier = _initialTopLevelUniqueNamer.makeUnique('_dylib');

    /// Finding a unique prefix for Array Helper Classes and store into
    /// [_arrayHelperClassPrefix].
    final base = 'ArrayHelper';
    _arrayHelperClassPrefix = base;
    var suffixInt = 0;
    for (var i = 0; i < allNameSet.length; i++) {
      if (allNameSet.elementAt(i).startsWith(_arrayHelperClassPrefix)) {
        // Not a unique prefix, start over with a new suffix.
        i = -1;
        suffixInt++;
        _arrayHelperClassPrefix = '${base}${suffixInt}';
      }
    }

    _resetUniqueNamersNamers();
  }

  /// Resets the namers to initial state. Namers are reset before generating.
  void _resetUniqueNamersNamers() {
    _topLevelUniqueNamer = _initialTopLevelUniqueNamer.clone();
    _wrapperLevelUniqueNamer = _initialWrapperLevelUniqueNamer.clone();
  }

  /// Writes all bindings to a String.
  String generate() {
    final s = StringBuffer();

    // Reset unique namers to initial state.
    _resetUniqueNamersNamers();

    // Write file header (if any).
    if (header != null) {
      s.write(header);
      s.write('\n');
    } else {
      // Write default header, in case none was provided.
      s.write(makeDartDoc(
          'AUTO GENERATED FILE, DO NOT EDIT.\n\nGenerated by `package:ffigen`.'));
    }

    // Write neccesary imports.
    s.write("import 'dart:ffi' as $ffiLibraryPrefix;\n");
    s.write('\n');

    final dependencies = <Typedef>[];

    /// Get typedef dependencies, these will be written at the end.
    for (final b in lookUpBindings) {
      dependencies.addAll(b.getTypedefDependencies(this));
    }
    for (final b in noLookUpBindings) {
      dependencies.addAll(b.getTypedefDependencies(this));
    }

    /// Write [lookUpBindings].
    if (lookUpBindings.isNotEmpty) {
      // Write doc comment for wrapper class.
      if (classDocComment != null) {
        s.write(makeDartDoc(classDocComment));
      }
      // Write wrapper classs.
      s.write('class $_className{\n');
      // Write dylib.
      s.write('/// Holds the Dynamic library.\n');
      s.write('final $ffiLibraryPrefix.DynamicLibrary ${dylibIdentifier};\n');
      s.write('\n');
      //Write doc comment for wrapper class constructor.
      s.write(makeDartDoc('The symbols are looked up in [dynamicLibrary].'));
      // Write wrapper class constructor.
      s.write(
          '${_className}($ffiLibraryPrefix.DynamicLibrary dynamicLibrary): $dylibIdentifier = dynamicLibrary;\n\n');
      for (final b in lookUpBindings) {
        s.write(b.toBindingString(this).string);
      }
      s.write('}\n\n');
    }

    /// Write [noLookUpBindings].
    for (final b in noLookUpBindings) {
      s.write(b.toBindingString(this).string);
    }

    // Write typedef dependencies.
    for (final d in dependencies) {
      s.write(d.toTypedefString(this));
    }

    return s.toString();
  }
}
