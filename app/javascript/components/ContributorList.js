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
    <div className="contributors">
      <div className="contributors__body">
        <div className="container">
          <div className="contributors__body-inner is-table-container">
            <table className="contributors__list">
              <thead>
                <tr>
                  <th className="contributors__label is-rank">Rank</th>
                  <th className="contributors__label is-name">Showing {props.ranks.length} contributors</th>
                  <th className="contributors__label is-commits">Commits</th></tr>
              </thead>
              <tbody>
                {props.ranks.map((contributor) =>
                  <ContributorInfo contributor={contributor} key={contributor.id} topCommits={props.ranks[0].commits} /> )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  )
}

Contributors.propTypes = {
  ranks: PropTypes.array.isRequired
}

const ContributorInfo = (props) => {
  const {rank, avatar_url, path, name, first_committed_on, commits} = props.contributor
  const width = (rank === 1) ? { width: '100%'} : { width: ((commits/props.topCommits)*100)+'%'}

  return (
    <tr className='contributors-contributor'>
      <td >
        <div className='contributors-contributor__rank is-text-align-center'>#{rank}</div>
      </td>
      <td>
        <div className='contributors-contributor__metas'>
          <div className='contributors-contributor__avatar'>
            <img className='contributors-contributor__avatar-image' src={avatar_url} />
          </div>
          <div className='contributors-contributor__attributes'>
            <h2 className='contributors-contributor__name'>
              <a className='contributors-contributor__name-link' href={path}>{name}</a>
            </h2>
            <p className='contributors-contributor__since'>since {first_committed_on}</p>
          </div>
        </div>
      </td>
      <td className='contributors-contributor__activity'>
        <p className='contributors-contributor__commit-count is-nowrap'>{commits}</p>
        <div className="contributors-contributor__activity-graph" style={width}>
        </div>
      </td>
    </tr>
  )
}

ContributorInfo.propTypes = {
  contributor: PropTypes.object.isRequired
}

export default ContributorList
