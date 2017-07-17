exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: {
        'js/app.js': [
          'node_modules/**',
          'web/static/js/share/*.js',
          'web/static/js/app/*.js',
        ],
        'js/frontend.js': /^(web\/static\/js\/frontend)/,
        'js/backend.js': /^(web\/static\/js\/backend)/,
      }
    },
    stylesheets: {
      joinTo: {
        'css/app.css': [
          'node_modules/**',
          'web/static/css/app/*',
        ],
        //'css/frontend.css': /^(web\/static\/css\/frontend)/,
        'css/backend.css': /^(web\/static\/css\/backend)/,
        'css/login.css': "web/static/css/pages/login.scss"
      }
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/web/static/assets". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(web\/static\/assets)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: [
      // static file
      "web/static",
      "test/static"
    ],

    // Where to compile files to
    public: "priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/web\/static\/vendor/]
    },
    sass: {
      options:{
        includePaths: [
          "node_modules/bootstrap-sass/assets/stylesheets",
          "node_modules/font-awesome/scss",
          "node_modules/toastr",
          "node_modules/jquery-ui/themes/base",
          "node_modules/bootstrap-colorpicker/src/sass"
        ], // tell sass-brunch where to look for files to @import
      },
      precision: 8 // minimum precision required by bootstrap-sass
    },
    copycat: {
        // copy bower_components/bootstrap-sass/assets/fonts/bootstrap/* to priv/static/fonts/
      "fonts": [
        "node_modules/bootstrap-sass/assets/fonts/bootstrap",
        "node_modules/font-awesome/fonts"
      ]
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["web/static/js/app/app"]
    }
  },

  npm: {
    enabled: true,
    styles: {
      // "bootstrap-datepicker": [
      //   'node_modules/dist/css/bootstrap-datepicker3.min.css'
      // ]
    },

    // Whitelist the npm deps to be pulled in as front-end assets.
    // All other deps in package.json will be excluded from the bundle.
    globals: {
      $: "jquery",
      jQuery: "jquery",
      jquery_ui: "jquery-ui",
      toastr: "toastr",
      meitsmenu: "metismenu",
      jquery_slimscroll: "jquery-slimscroll",
      //bootstrap_colorpicker: "bootstrap-colorpicker"
    },
    static: [
      //"node_modules/bootstrap-datepicker/dist/js/bootstrap-datepicker.js",
    ],
    whitelist: ["phoenix", "phoenix_html"]
  }
}
