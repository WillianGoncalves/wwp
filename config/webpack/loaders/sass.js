const MiniCssExtractPlugin = require(`mini-css-extract-plugin`);
const { env } = require('../configuration.js')
const devMode = process.env.NODE_ENV !== 'production'

module.exports = {
  test: /\.(scss|sass|css)$/i,

  use: [
    devMode ? 'vue-style-loader' : MiniCssExtractPlugin.loader,
    { loader: 'css-loader', options: { minimize: env.NODE_ENV === 'production' } },
    { loader: 'postcss-loader', options: { sourceMap: true } },
    { loader: 'sass-loader', options: { sourceMap: true, indentedSyntax: true } }
  ],
}
