<template>
  <section>
    <h2>Measure Creation</h2>
    <form ref="measureForm" @submit.prevent="onSubmit">
      <p><label for="name">Name:</label> <input type="text" v-model="name" name="name" id="name" placeholder="name" required></p>
      <p><label for="timestamp">TimeStamp:</label> <input type="datetime-local" v-model="timestamp" name="timestamp" id="timestamp" required></p>
      <p><label for="value">Value:</label> <input type="number" v-model="value" name="value" id="value" required></p>
      <button @click="saveMeasure" >Save measure</button>
    </form>
  </section>
</template>

<script>
export default {
  data() {
    return {
      name: null,
      timestamp: null,
      value: null
    }
  },
  methods: {
    async saveMeasure(event) {
      if (this.$refs.measureForm.checkValidity()) {
        const response = await fetch('/api/v0/measures', { 
          method:  'POST',
          headers: { 'Content-Type': 'application/json', 'ACCEPT': 'application/json' },
          body: JSON.stringify({
              name: this.name,
              timestamp:  this.timestamp,
              value:   this.value
            })
        });
        if( response.status == 200 ) {
          this.emitter.emit("measure-created");
          this.$refs.measureForm.reset();
          event.preventDefault();
          alert('New measure created');
        } else {
          alert('Something happened: check the logs');
          console.log(await response.json());
        }
      }
    }
  }
}

</script>
