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
    <div>
      <table className="search-result-contributor_table">
        <thead className='table_head'>
          <tr className='table_header_row'>
            <th className='table_header_name'>
              <p className='table_data_contributor-name'>Name</p>
            </th>
            <th className='table_header_commits'>Commits</th>
          </tr>
        </thead>
        <tbody className='table_body'>
          {props.contributors.map((contributor) =>
            <ContributorInfo contributor={contributor} key={contributor.id} /> )}
        </tbody>
      </table>
    </div>
  )
}

Contributors.propTypes = {
  contributor: PropTypes.array.isRequired
}

const  ContributorInfo = (props) => {
  const {avatar_url, path, name, commits} = props.contributor

  return (
    <tr className="contributor_result_table-row">
      <td className='table_data_info' >
        <div className='contributor_result_info'>
          <img className='contributor_result_avatar' src={avatar_url} />
          <a className='contributor_result_name' href={path}>  {name}  </a>
        </div>
      </td>
      <td className='table_data_commits'>
        <p className='contributor_result_commits'>{commits}</p>
      </td>
    </tr>
  )
}

ContributorInfo.propTypes = {
  contributor: PropTypes.object.isRequired
}

export default SearchResult
