class Results extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      results: this.props.results
    }
  }

  render () {
    return (
      <div>
        <ResultsList results={this.state.results} />
      </div>
    )
  }
}
