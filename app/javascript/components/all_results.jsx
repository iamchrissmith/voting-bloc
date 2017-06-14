import React from 'react'
import ResultsList from './results_list'
import { VictoryPie, VictoryLabel, VictoryLegend } from 'victory'
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
      <svg viewBox="0 0 400 400" >
        <VictoryPie
          standalone={false}
          width={400} height={400}
          innerRadius={70} labelRadius={100}
          data={this.state.results.results}
          x="name"
          y="votes"
          labels={(datum) => datum.x + ": " + datum.y}
          style={{ labels: { fontSize: 15, fill: "white"}}}
        />
        <circle cx="200" cy="200" r="65" fill="none" stroke="black" strokeWidth={3}/>
        <circle cx="200" cy="200" r="155" fill="none" stroke="black" strokeWidth={3}/>
        <VictoryLabel
          textAnchor="middle" verticalAnchor="middle"
          x={200} y={200}
          style={{fontSize: 30}}
          text="Votes"
        />
        <VictoryLegend
          data={this.state.results.results}
          labelComponent={
            <VictoryLabel
              data={this.state.results.results}
              text={(datum) => console.log(datum)}
            />
          }
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
