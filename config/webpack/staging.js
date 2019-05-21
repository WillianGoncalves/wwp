// Note: You must restart bin/webpack-dev-server for changes to take effect

/* eslint global-require: 0 */

const webpack = require('webpack');
const merge = require('webpack-merge');
const TerserPlugin = require('terser-webpack-plugin');
const CompressionPlugin = require('compression-webpack-plugin');
const sharedConfig = require('./shared.js');

module.exports = merge(sharedConfig, {
  output: { filename: '[name]-[chunkhash].js' },
  devtool: 'source-map',

  stats: {
    errors: true,
    errorDetails: true
  },

  resolve: {
    alias: {
      vue: 'vue/dist/vue.min'
    } 
  },

  optimization: {
    minimizer: [ new TerserPlugin() ]
  },

  plugins: [
    new CompressionPlugin({
      filename: '[path].gz[query]',
      algorithm: 'gzip',
      test: /\.(js|css|html|json|ico|svg|eot|otf|ttf)$/
    }),

    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: '"staging"'
      }
    })
  ]
});
