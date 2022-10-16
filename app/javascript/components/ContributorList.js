import React from "react"
import PropTypes from "prop-types"

class ContributorList extends React.Component {
  constructor(props){
    super(props)
    this.state = {initialContributors: this.props.ranks, ranks:[]}
  }

  componentDidMount() { 
    this.setState({ranks: this.state.initialContributors})
  }

  render() {
    return (
      <Contributors ranks={this.state.ranks} />
    )
  }
}

const Contributors = (props) => {
  return (
    <div className="showing_contributors">
      <p className="contributors_count">Showing {props.ranks.length} people</p>

      <table className="contributors_table">
        <thead>
          <tr><th className='table_header'>  </th><th className='table_header'>Name</th><th className='table_header'>Commits</th></tr>
        </thead>
        <tbody>
          {props.ranks.map((contributor) =>
            <ContributorInfo contributor={contributor} key={contributor.id} /> )}
        </tbody>
      </table>
    </div>
  )
}

Contributors.propTypes = {
  ranks: PropTypes.array.isRequired
}

const ContributorInfo = (props) => {
  const {rank, avatar_url, path, name, first_committed_on, commits} = props.contributor
  const width = {width: (commits/8)+'px'}
  return (
    <tr className="contributor_table-row">
      <td className='table_data_rank'>#{rank}</td>
      <td className='table_data_info' >
        <div className='contributor_info'>
          <img className='contributor_avatar' src={avatar_url} />
          <div className='contributor_name_since'>
            <a className='contributor_name' href={path}>  {name}  </a>
            <p className='contributor_since'>since {first_committed_on}</p>
          </div>
        </div>
      </td>
      <td className='table_data_graph'>
        <span className="contributor_horizontal_bar" style={width}>
          <p className='contributor_commits'>{commits}</p>
        </span>
      </td>
    </tr>
  )
}

ContributorInfo.propTypes = {
  contributor: PropTypes.object.isRequired
}

export default ContributorList
