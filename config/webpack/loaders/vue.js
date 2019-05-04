module.exports = {
  test: /\.vue(\.erb)?$/,
  use: [
    {
      loader: 'vue-loader',
      options: {
        extractCSS: true,
        loaders: {
          //js: 'babel-loader',
          // A configuração a seguir fará com que todas as tags `<script>` sem
          // o atributo `lang` sejam carregadas com `coffee-loader`
          js: 'coffee-loader',
          file: 'file-loader',
          scss: 'vue-style-loader!css-loader!postcss-loader!sass-loader',
          sass: 'vue-style-loader!css-loader!postcss-loader!sass-loader?indentedSyntax'
        }
      }
    }
  ]
}
