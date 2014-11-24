// Copyright the project authors, 2014.
// Distributed under the MIT License.
// See accompanying file LICENSE or copy at
// http://opensource.org/licenses/MIT

library bootstrap;

import 'package:html5lib/parser.dart' show parse;
import 'package:html5lib/dom.dart' show Document;
import 'package:barback/barback.dart'
  show Asset, Transform, Transformer, BarbackSettings, BarbackMode;
import 'dart:async' show Future;


class BootstrapUrlTransformer extends Transformer {
  static const String _BASE_URL = 'packages/bootstrap/';

  bool releaseMode;
  String bootstrapUrl;

  String get allowedExtensions => '.html';

  BootstrapUrlTransformer.asPlugin(BarbackSettings settings) {
    releaseMode = settings.mode == BarbackMode.RELEASE;
    bootstrapUrl = settings.configuration['url'];
    var version = settings.configuration['version'];
    if (bootstrapUrl != null) {
      if (bootstrapUrl.contains('{{version}}') && version != null) {
        bootstrapUrl = bootstrapUrl.replaceAll('{{version}}', '$version');
      }
      if (!bootstrapUrl.endsWith('/')) bootstrapUrl += '/';
    }
  }

  Future apply(Transform transform) {
    if (releaseMode) {
      var id = transform.primaryInput.id;

      return transform.primaryInput.readAsString().then((html) =>
          transform.addOutput(new Asset.fromString(id, _rewriteHtml(html))));
    }
    // Let barback know there is nothing more to do when not in release mode
    return null;
  }

  String _rewriteHtml(String html) {
    Document doc = parse(html);

    doc.querySelectorAll('script[src^="$_BASE_URL"]').forEach((tag) {
      var src = tag.attributes['src'];
      if (!src.endsWith('.min.js')) src = src.replaceAll(new RegExp(r'\.js$'), '.min.js');
      if (bootstrapUrl != null) {
        src = src.replaceAll(_BASE_URL, bootstrapUrl);
      }
      tag.attributes['src'] = src;
    });

    doc.querySelectorAll('link[href^="$_BASE_URL"]').forEach((tag) {
      var href = tag.attributes['href'];
      if (!href.endsWith('.min.css')) href = href.replaceAll(new RegExp(r'\.css$'), '.min.css');
      if (bootstrapUrl != null) {
        href = href.replaceAll(_BASE_URL, bootstrapUrl);
      }
      tag.attributes['href'] = href;
    });

    return doc.outerHtml;
  }
}