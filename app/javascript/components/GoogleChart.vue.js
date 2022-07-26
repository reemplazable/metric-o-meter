import { GChart } from 'vue-google-charts';

const chartCols = [{ id: 'timestamp', label: 'Timestamp', type: 'datetime' },
{ id: 'avgPerSecond', label: 'Average Per Second', type: 'number' },
{ id: 'avgPerMinute', label: 'Average Per Minute', type: 'number' },
{ id: 'avgPerHour', label: 'Average Per Hour', type: 'number' }];

export default {
  template: `
  <h2>Averages</h2>
  <GChart type="LineChart" :data="chartData" :options="chartOptions"/>`,
  components: {
    GChart
  },
  data() {
    return {
      chartData: {
        cols: chartCols,
        rows: []
      },
      chartOptions: {
        chart: {
          title: 'Averages',
          interpolateNulls: true
        },
      },
      measureType: null
    }
  },
  methods: {
    async getChartRows(){
      const response = await fetch('/api/v0/statistics?' + new URLSearchParams({name: this.measureType}), { method: 'GET', headers: { 'ACCEPT': 'application/json' } });
      const data = await response.json();
      this.chartData.rows = data;
    }
  },
  mounted: function() {
    this.emitter.on("measure-created", _measureCreated => { this.getChartRows();});
    this.emitter.on('measure-type-changed', measureType => { this.measureType = measureType;
                                                             this.getChartRows();});
  }
}
