import React from "react"

class Search extends React.Component {
  constructor(props){
    super(props)
    this.state = {contributors: []}
  }

  onChangeName(event) {
    this.setState({name : event.target.value})
  }

  render() {
    return (
      <div className="entry">
        <div> <input type="search" value={this.state.name} name="name" onChange={(e) => this.onChangeName(e)} placeholder="ユーザー名を入力して検索" /> </div>
        <div><a href={'/contributors/search?name='+this.state.name}>検索</a></div>
      </div>
    )
  }
}

export default Search
