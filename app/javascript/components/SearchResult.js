import React from "react"
import PropTypes from "prop-types"

class SearchResult extends React.Component {
  constructor(props){
    super(props)
    this.state = {initialContributors: this.props.contributors, contributors:[]}
  }

  componentDidMount() { 
    this.setState({contributors: this.state.initialContributors})
  }

  render() {
    return (
      <Contributors contributors={this.state.contributors} />
    )
  }
}

const Contributors = (props) => {
  return (
    <div className="contributors">
      <div className="contributors__body">
        <div className="container">
          <div className="contributors__body-inner">
            <table className="contributors__list">
              <thead>
                <tr>
                  <th className="contributors__label is-name">Showing {props.contributors.length} people</th>
                  <th className="contributors__label is-commits">Commits</th></tr>
              </thead>
              <tbody>
                {props.contributors.map((contributor) =>
                  <ContributorInfo contributor={contributor} key={contributor.id} topCommits={props.contributors[0].commits} /> )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  )
}

Contributors.propTypes = {
  contributors: PropTypes.array.isRequired
}

const ContributorInfo = (props) => {
  const {avatar_url, path, name, commits} = props.contributor

  return (
    <tr className='contributors-contributor'>
      <td>
        <div className='contributors-contributor__metas'>
          <div className='contributors-contributor__avatar'>
            <img className='contributors-contributor__avatar-image' src={avatar_url} />
          </div>
          <div className='contributors-contributor__attributes'>
            <h2 className='contributors-contributor__name'>
              <a className='contributors-contributor__name-link' href={path}>{name}</a>
            </h2>
          </div>
        </div>
      </td>
      <td className='contributors-contributor__activity'>
        <p className='contributors-contributor__commit-count'>{commits}</p>
      </td>
    </tr>
  )
}

ContributorInfo.propTypes = {
  contributor: PropTypes.object.isRequired
}

ContributorInfo.propTypes = {
  contributor: PropTypes.object.isRequired
}

export default SearchResult
