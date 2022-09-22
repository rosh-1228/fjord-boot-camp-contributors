import React from "react"
import PropTypes from "prop-types"
class SearchResult extends React.Component {
  constructor(props){
    super(props)
    this.state = {initialContributors: this.props.contributor, contributor:[]}
  }

  componentDidMount() { 
    this.setState({contributor: this.state.initialContributors})
  }

  render() {
    return (
      <div>
        <Contributors contributor={this.state.contributor} />
      </div>
    )
  }
}

const Contributors = (props) => { 
  return (
    <div>
      <table className="contributors">
        <thead  data-type="ok">
          <tr><th>Name</th><th>Commits</th></tr>
        </thead>
        <tbody>
          {props.contributor.map((contributor) =>
            < ContributorInfo contributor={contributor} key={contributor.id} /> )}
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
    <tr>
      <td><img src={avatar_url} width="30" height="30" /><a href={path}>  {name}  </a></td>
      <td>{commits}</td>
    </tr>
  )
}

ContributorInfo.propTypes = {
  contributor: PropTypes.object.isRequired
}

export default SearchResult
