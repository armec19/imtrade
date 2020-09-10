new Vue({
  el: '#app',
   data () {
    return {
      search: '',
      headers: [
        { text: 'ID', value: 'id' },
        { text: 'Name', value: 'name' },
        { text: 'Email', value: 'email' },
        { text: 'Website', value: 'website' },
        { text: 'Action', value: 'action', sortable: false }
      ],
      items: []
    }
  },
  created: function(){
      this.getData()
  },
  methods: {
      getData(){
          axios.get('https://jsonplaceholder.typicode.com/users').then(response => {
                    //console.log(response.data);
                    this.items = response.data;
                });                            

      }
  },
   
   /* https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js
   https://unpkg.com/babel-polyfill/dist/polyfill.min.js
   https://unpkg.com/vue/dist/vue.js
   https://unpkg.com/vuetify@1.0.4/dist/vuetify.min.js
   */
})