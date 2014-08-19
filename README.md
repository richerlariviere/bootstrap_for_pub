# Bootstrap for Pub

Just a pub package of Bootstrap,
"The most popular front-end framework
for developing responsive, mobile first
projects on the web."

Currently contains Bootstrap 3.2.

## Installation

See the [install instructions][install].

## Usage

You can include the bootstrap stylesheets and script once you have added this package as a 
dependency to your application:

```html
    <!-- include the stylesheets -->
    <link rel="stylesheet" href="packages/bootstrap_for_pub/css/bootstrap.css">
    <link rel="stylesheet" href="packages/bootstrap_for_pub/css/bootstrap-theme.css">
    
    <!-- include the javascript -->
    <script src="packages/bootstrap_for_pub/js/bootstrap.js"></script>
```

Note that the versions in the snippets above are the non-minified version. The transformer available
in this package will automatically rewrite the URI to point to the minified versions when pub is 
invoked in release mode.

To activate the transformer, update your `pubspec.yaml`

```json
transformers:
- bootstrap_for_pub:
    url: //maxcdn.bootstrapcdn.com/bootstrap/{{version}}
    version: 3.2.0    
```

The transformer takes up to two optional parameters:
- `url`: when specified the local base url (`packages/bootstrap_for_pub/`) will be replaced by the
  given url. This is useful to automatically switch to using a CDN for your production environment.
- `version`: when specified, the sub-string "{{version}}" in the `url` parameter will be replaced 
   with its value.

## Learn more

Visit the official [Bootstrap homepage][bs] for docs and more.

See LICENSE.

[install]: http://pub.dartlang.org/packages/bootstrap_for_pub#installing
[bs]: http://getbootstrap.com/
