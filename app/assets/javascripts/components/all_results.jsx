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
    const results = React.addons.update(this.state.results, { $push: [result]});
    this.setState({
      results: results.sort(function(a,b){
        return a - b;
      })
    });
  }

  setupSubscription(){
    App.results = App.cable.subscriptions.create("ResultsChannel", {
      result_id: this.state.result,
      connected: function(){
        setTimeout(() => this.perform('follow', {result_id: this.result_id}), 1000);
      },

      received: function(data) {
        this.updateResults(data.result);
      },

      updateResults: this.updateResults
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
