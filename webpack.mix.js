const mix = require('laravel-mix');

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */

mix.js('resources/js/app.js', 'public/js').extract(['vue']);
mix.sass('resources/sass/app.scss', 'public/css');

mix.version();

mix.browserSync({
    proxy: 'http://localhost/',
    // ui: false,
    // injectChanges: true,
    // open: true,
    watchOptions: {
        usePolling: true,
        interval: 500
    }
});
