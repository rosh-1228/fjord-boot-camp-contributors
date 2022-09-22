import React from "react"
import PropTypes from "prop-types"
class CommitList extends React.Component {
  constructor(props){
    super(props)
    this.state = {initialCommits: this.props.commits, commits:[]}
  }

  componentDidMount() { 
    this.setState({commits: this.state.initialCommits})
  }

  render() {
    return (
      <div>
        <Commits commits={this.state.commits} />
      </div>
    )
  }
}

const Commits = (props) => { 
  return (
    <div>
      <p className="commits_count">Showing {props.commits.length} commits</p>
      <table className="commits">
        <thead  data-type="ok">
          <tr><th>Hash</th><th>Date</th><th>Message</th></tr>
        </thead>
        <tbody>
          {props.commits.map((commit) =>
            < CommitInfo commit={commit} key={commit.id} /> )}
        </tbody>
      </table>
    </div>
  )
}

Commits.propTypes = {
  commits: PropTypes.array.isRequired
}

const  CommitInfo = (props) => {
  const {hash, committed_on, message} = props.commit
  return (
    <tr>
      <td><a href={'https://github.com/fjordllc/bootcamp/commit/'+hash}>{hash.substr(0, 7)}</a></td>
      <td>{committed_on}</td>
      <td>{(message.length > 60) ? message.substr(0, 60)+'...' : message }</td>
    </tr>
  )
}

CommitInfo.propTypes = {
  commit: PropTypes.object.isRequired
}

export default CommitList
