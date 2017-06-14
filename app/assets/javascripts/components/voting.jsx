class Voting extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      user: this.props.user,
      vote_status: this.props.vote_status,
      election: this.props.election,
      results: this.props.results,
      candidates: this.props.candidates
    }
  }

  render () {
    return (
      <div>
        
      </div>
    )
  }
}
