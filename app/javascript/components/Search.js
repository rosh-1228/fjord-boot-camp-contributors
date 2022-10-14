import React from "react"

class Search extends React.Component {
  constructor(props){
    super(props)
    this.state = {contributors: []}
  }

  onChangeName(event) {
    this.setState({name : event.target.value})
  }

  searchNameurl(){
    location.href='/contributors/search?name='+this.state.name
  }

  render() {
    return (
      <div className="searchContributor">
        <form>
          <div className="field">
            <div className="control">
              <input
                className="search"
                type="text"
                value={this.state.name}
                name="name"
                onChange={e => this.onChangeName(e)}
                onKeyPress={e =>
                  {
                    if (e.key === 'Enter') {
                      e.preventDefault()
                      this.searchNameurl()
                    }
                  }
                }
                placeholder="ユーザー名を入力して検索"
              />
            </div>
          </div>
          <div>
            <input
              type="button"
              onClick={() => this.searchNameurl()}
              value="検索"
            />
          </div>
        </form>
      </div>
    )
  }
}

export default Search
