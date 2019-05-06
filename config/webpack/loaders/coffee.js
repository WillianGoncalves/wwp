// this will apply to both plain `.coffee` files
// AND `<script lang="coffee">` blocks in `.vue` files
module.exports = {
  test: /\.coffee$/,
  loader: 'coffee-loader'
}
