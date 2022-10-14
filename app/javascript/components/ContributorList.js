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
          <tr><th>  </th><th>Name</th><th>Commits</th></tr>
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
  const {rank, avatar_url, path, name, commits} = props.contributor
  const width = {width: (commits/10)+'px'}
  return (
    <tr>
      <td>#{rank}</td>
      <td><img src={avatar_url} width="30" height="30" /><a href={path}>  {name}  </a></td>
      <td><span className="horizontal_bar" style={width}>{commits}</span></td>
    </tr>
  )
}

ContributorInfo.propTypes = {
  contributor: PropTypes.object.isRequired
}

export default ContributorList
