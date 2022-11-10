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
          <div className="contributors__body-inner is-table-container">
            <table className="contributors__list is-search-result">
              <thead>
                <tr>
                  <th className="contributors__label is-name">Showing {props.contributors.length} Contributors</th>
                </tr>
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
    <tr className='found-contributors-contributor'>
      <td>
        <div className='found-contributors-contributor__metas'>
          <div className='found-contributors-contributor__avatar'>
            <img className='found-contributors-contributor__avatar-image' src={avatar_url} />
          </div>
          <div className='found-contributors-contributor__attributes'>
            <h2 className='found-contributors-contributor__title'>
              <a className='found-contributors-contributor__title-link' href={path}>
                <span className='found-contributors-contributor__title-name'>{name}</span>
                <span className='found-contributors-contributor__title-commits'>{commits} commits</span>
              </a>
            </h2>
          </div>
        </div>
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
