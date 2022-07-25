import { createApp } from 'vue'

createApp({
  data() {
    return {
      name: null,
      timestamp: null,
      value: null
    }
  },
  methods: {
    saveMeasure(event) {
      if (this.$refs.measureForm.checkValidity()) {
        fetch('/api/v0/measures',{
          method:  'POST',
          headers: {
            'Content-Type': 'application/json',
            'ACCEPT': 'application/json'
          },
          body: JSON.stringify({
            name: this.name,
            timestamp:  this.timestamp,
            value:   this.value
          })
        }).then(function( response ) {
          if( response.status != 200 ){
              response.json().then( function( data ){
                alert('error data: ' + data.error_message);
            }.bind(this));
          } else {
            window.alert('created new meassure');
            this.reset();
          }});
        }
        // event.preventDefault();
      }
    }
  },
).mount('#app')
