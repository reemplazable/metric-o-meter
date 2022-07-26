import GoogleChart from './GoogleChart.vue';
import MeasureForm from './MeasureForm.vue'
export default {
  template: /*html*/ `
  <aside>
  <p>Measure names</p>
  <select @change="changeMeasure($event)">
    <option>Select here</option>
    <option v-for="measure in measures">{{ measure }}</option>
  </select>
  </aside>
  <GoogleChart />
  <MeasureForm />`,
  name: 'App',
  components: {
    GoogleChart,
    MeasureForm
  },
  data() {
    return {
      measures: []
    }
  },
  methods: {
    async getMeasureTypes(){
      const response = await fetch('/api/v0/measures/types', { method: 'GET', headers: { 'ACCEPT': 'application/json' } });
      const data = await response.json();
      this.measures = data;
    },
    changeMeasure(event) {
      this.emitter.emit('measure-type-changed', event.target.value);
    }
  },
  mounted: function() {
    this.getMeasureTypes();
  }
};
