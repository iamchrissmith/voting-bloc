import React from 'react'
import ResultsList from './results_list'
// import { VictoryBar, VictoryChart, VictoryAxis } from 'victory'
// import ReactDOM from 'react-dom'
// import PropTypes from 'prop-types'

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
    //     <VictoryBar
    //       data={this.state.results}
    //       x="candidate"
    //       y="votes"
    //     />
    //   </VictoryChart>
    // )
    return (
      <div>
        <ResultsList results={this.state.results} />
      </div>
    )
  }
}

export default Results;
