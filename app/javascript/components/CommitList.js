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
      <Commits commits={this.state.commits} />
    )
  }
}

const Commits = (props) => { 
  return (
    <div className='showing_comitts'>
      <p className="commits_count">Showing {props.commits.length} commits</p>
      <table className="commits_table">
        <thead>
          <tr>
            <th className='table_header'>Hash</th>
            <th className='table_header'>Date</th>
            <th className='table_header'>Message</th></tr>
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
    <tr className='commit_table-row'>
      <td className='commit_hash'><a href={'https://github.com/fjordllc/bootcamp/commit/'+hash}>{hash.substring(1, 7)}</a></td>
      <td className='commit_since'>{committed_on}</td>
      <td className='commit_message_row'><p className='commit_message'>{message}</p></td>
    </tr>
  )
}

CommitInfo.propTypes = {
  commit: PropTypes.object.isRequired
}

export default CommitList
