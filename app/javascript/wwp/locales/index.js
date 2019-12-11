import Vue from 'vue';
import VueI18n from 'vue-i18n';
import ptBR from './pt-BR.js';

Vue.use(VueI18n)

const messages = {
  'pt-BR': { ...ptBR }
}

export default new VueI18n({
  locale: 'pt-BR',
  messages: messages,
})
