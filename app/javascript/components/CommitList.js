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
    <div className='commits__table-wrapper'>
      <table className="commits__list">
        <thead>
          <tr>
            <th className='commits__label is-hash'>Hash</th>
            <th className='commits__label is-date'>Date</th>
            <th className='commits__label is-massage'>Showing {props.commits.length} commits</th></tr>
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
    <tr className='commits-commit'>
      <td className='commits-commit__hash'><a href={'https://github.com/fjordllc/bootcamp/commit/'+hash} className='commits-commit__hash-link'>{hash.substring(1, 7)}</a></td>
      <td className='commits-commit__date is-nowrap'>{committed_on}</td>
      <td className='commits-commit__message'><a href={'https://github.com/fjordllc/bootcamp/commit/'+hash} className='commits-commit__message-link'>{message}</a></td>
    </tr>
  )
}

CommitInfo.propTypes = {
  commit: PropTypes.object.isRequired
}

export default CommitList
