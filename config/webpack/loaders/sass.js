const MiniCssExtractPlugin = require(`mini-css-extract-plugin`);
const { env } = require('../configuration.js')
const devMode = process.env.NODE_ENV !== 'production'

// this will apply to both plain `.css` files
// AND `<style>` blocks in `.vue` files
module.exports = {
  test: /\.(scss|sass|css)$/i,

  use: [
    devMode ? 'vue-style-loader' : MiniCssExtractPlugin.loader,
    { loader: 'css-loader' },
    { loader: 'postcss-loader', options: { sourceMap: true } },
    { loader: 'sass-loader', options: { sourceMap: true, indentedSyntax: true } }
  ],
}
