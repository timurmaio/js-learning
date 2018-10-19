/**
 * Created by ridel1e on 17/09/16.
 */

'use strict';

const webpack = require('webpack');
const NODE_ENV = process.env.NODE_ENV || 'development';

module.exports = {
  entry: './app/index.js',

  output: {
    path: __dirname + '/build',
    filename: 'bundle.js'
  },

  watch: NODE_ENV === 'development',

  watchOptions: {
    aggregateTimeout: 100
  },

  devtool: NODE_ENV === 'development' ? "cheap-inline-module-source-map": null,

  plugins: [
    new webpack.DefinePlugin({
      NODE_ENV: JSON.stringify(NODE_ENV),
      __dirname: JSON.stringify(__dirname)
    })
  ],

  resolve: {
    modulesDirectories: ['node_modules', 'app'],
    extensions: ['', '.js']
  },

  resolveLoader: {
    modulesDirectories: ['node_modules'],
    moduleTemplates: ['*-loader', '*'],
    extensions: ['', '.js']
  },

  module: {
    loaders: [{
      test: /\.js$/,
      include: __dirname + '/app',
      loader: 'babel-loader',
      query: {
        presets: ['es2015']
      }
    }, {
      test: /\.json$/,
      loader: 'json'
    }],
  },

  target: "node",
};

if(NODE_ENV === 'production') {
  module.exports.plugins.push(
    new webpack.optimize.UglifyJsPlugin({
      warnings: false,
      drop_console: true,
      unsafe: true
    })
  );
}