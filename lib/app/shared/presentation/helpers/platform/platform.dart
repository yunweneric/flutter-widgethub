// `dart.library.js_interop` rather than `dart.library.html`: the html
// libraries do not exist in a `--wasm` build, so keying on them sent the
// web app to the stub, where every call threw.
export 'platform_stub.dart'
    if (dart.library.io) 'platform_io.dart'
    if (dart.library.js_interop) 'platform_web.dart';
