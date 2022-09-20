import React, { Component }  from "react"
import PropTypes from "prop-types"
class Search extends React.Component {
  constructor(props){
    super(props)
    this.state = {initialContributors: this.props.ranks, ranks:[]}
  }

  componentDidMount() { 
    this.setState({ranks: this.state.initialContributors})
  }

  searchByName(name) { 
    const result = this.state.initialContributors.filter((contributor) => {
      return contributor.name.toLowerCase().search( name.toLowerCase()) !== -1;
    })
    this.setState({ranks: result})
  }

  render() {
    return (
      <div>
        <FilterForm search={(name) => this.searchByName(name)} />
        <ContributorList ranks={this.state.ranks} />
      </div>
    )
  }
}

class FilterForm extends Component{

  constructor(props){
    super(props)
    this.state = {name: ''}
  }

  onChangeName(event) {
    this.setState({name : event.target.value})
  }

  onClickSearch() {
    this.props.search(this.state.name)
  }

  render() {
    return (
      <div className="entry">
        <fieldset>
          <div> <input type="text" value={this.state.name} name="name" onChange={(e) => this.onChangeName(e)} placeholder="ユーザー名を入力して検索" /> </div>
          <div> <input type="submit" value="検索" onClick={(e) => this.onClickSearch(e)} /> </div>
        </fieldset>
      </div>
    )
  }
}

const ContributorList = (props) => { 
  return (
    <div>
      <table className="contributor">
        <thead  data-type="ok">
          <tr><th>  </th><th>Avatar</th><th>Name</th><th>Commits</th></tr>
        </thead>
        <tbody>
          {props.ranks.map((contributor) =>
            < ContributorInfo contributor={contributor} key={contributor.id} /> )}
        </tbody>
      </table>
    </div>
  )
}

ContributorList.propTypes = {
  ranks: PropTypes.array.isRequired
}

const  ContributorInfo = (props) => {
  const {rank, avatar_url, path, name, commits} = props.contributor
  return (
    <tr>
      <td>#{rank}</td>
      <td><img src={avatar_url} width="30" height="30" /></td>
      <td><a href={path}>  {name}  </a></td>
      <td>{commits}</td>
    </tr>
  )
}

ContributorInfo.propTypes = {
  contributor: PropTypes.object.isRequired
}

export default Search
