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
    console.log(result.results)
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
    return (
      <div>
        <ResultsList results={this.state.results} />
      </div>
    )
  }
}
