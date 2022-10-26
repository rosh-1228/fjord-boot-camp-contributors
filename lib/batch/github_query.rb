# frozen_string_literal: true

module GithubQuery
  def create_query
    FjordBootCampContributors::Client.parse <<-GRAPHQL
      query($after: String){
        repository(owner: "fjordllc", name: "bootcamp") {
          ref(qualifiedName: "main") {
            target {
              ... on Commit {
                history(first: 100, after: $after) {
                  pageInfo {
                    hasNextPage
                    endCursor
                  }
                  totalCount
                  edges {
                    node {
                      oid
                      message
                      author {
                        date
                        name
                        user {
                          login
                          avatarUrl
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    GRAPHQL
  end
end
