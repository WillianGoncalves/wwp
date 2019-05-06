module.exports = {
  test: /\.vue(\.erb)?$/,
  use: [
    {
      loader: 'vue-loader',
      options: {
        extractCSS: true,
        loaders: {
          // A configuração a seguir fará com que todas as tags `<script>` sem
          // o atributo `lang` sejam carregadas com `coffee-loader`
          //js: 'coffee-loader',
          file: 'file-loader'
        }
      }
    }
  ]
}
