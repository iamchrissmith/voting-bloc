import React from 'react'
import ResultsList from './results_list'
import { VictoryPie, VictoryLabel, VictoryLegend, VictoryTheme } from 'victory'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class Results extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      // results: this.props.results
      results: JSON.parse(this.props.results)
    }
  }

  componentDidMount() {
    this.setupSubscription();
  }

  updateResults(result) {
    // console.log(result.results)
    this.setState({
      results:result
    })
    // const results = React.addons.update(this.state.results, { $push:[result.results]});
    // this.setState({
    //   results: results.sort(function(a,b){
    //     return a - b;
    //   })
    // });
  }

  setupSubscription(){
    App.results = App.cable.subscriptions.create("ResultsChannel", {
      results: this.state.results,
      connected: function(){
        setTimeout(() => this.perform('follow', {results: this.results.results}), 1000);
      },

      received: function(data) {
        this.updateResults(JSON.parse(data.result));
      },

      updateResults: this.updateResults.bind(this)
    });
  }

  render () {
    console.log(this.state.results);
    // return (
    //   <VictoryChart
    //     // domainPadding will add space to each side of VictoryBar to
    //     // prevent it from overlapping the axis
    //     domainPadding={20}
    //   >
    //     <VictoryAxis
    //       // tickValues specifies both the number of ticks and where
    //       // they are placed on the axis
    //       tickValues={this.state.results.keys}
    //       tickFormat={this.state.results.keys}
    //     />
    //     <VictoryAxis
    //       dependentAxis
    //       tickValues={this.state.results.values}
    //       tickFormat={(tick) => parseInt(tick)}
    //       tickCount={this.state.results.results.length}
    //     />
    //     <VictoryBar
    //       data={this.state.results.results}
    //       x="candidate"
    //       y="votes"
    //     />
    //   </VictoryChart>
    // )
    return (
      <svg viewBox="0 0 500 500" >
        <VictoryPie
          standalone={false}
          width={500} height={500}
          innerRadius={50} labelRadius={95}
          theme={VictoryTheme.material}
          data={this.state.results.results}
          x="name"
          y="votes"
          labels={(datum) => datum.x.split(" ")[0] + "\n" + datum.x.split(" ")[1] + "\n" + datum.y + " Vote/s"}
          style={{ labels: { fontSize: 17, fill: "black"}}}
        />
        <circle cx="250" cy="250" r="45" fill="none" stroke="black" strokeWidth={3}/>
        <circle cx="250" cy="250" r="205" fill="none" stroke="black" strokeWidth={3}/>
        <VictoryLabel
          textAnchor="middle" verticalAnchor="middle"
          x={250} y={250}
          style={{fontSize: 30}}
          text="Votes"
        />
      </svg>
    )
    // return (
    //   <div>
    //     <ResultsList results={this.state.results} />
    //   </div>
    // )
  }
}

export default Results;
