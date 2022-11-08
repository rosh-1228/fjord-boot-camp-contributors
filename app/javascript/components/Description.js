import React from 'react'
import Modal from 'react-modal'

const customStyles = {
  content : {
    top                   : '50%',
    left                  : '50%',
    right                 : 'auto',
    bottom                : 'auto',
    marginRight           : 'auto',
    transform             : 'translate(-50%, -50%)'
  }
}

class Description extends React.Component {
  constructor() {
    super();
    this.state = {
      modalIsOpen: false
    }

    this.openModal = this.openModal.bind(this)
    this.closeModal = this.closeModal.bind(this)
  }

  openModal() {
    this.setState({modalIsOpen: true})
  }

  closeModal() {
    this.setState({modalIsOpen: false})
  }

  render() {
    return (
      <>
        <a onClick={this.openModal} className='header__nav-item-link is-about is-hidden-mobile'>About</a>
        <a onClick={this.openModal} className='header__about-link is-hidden-tablet'><i className='fas fa-question-circle'></i></a>
        <Modal
          isOpen={this.state.modalIsOpen}
          onRequestClose={this.closeModal}
          style={customStyles}
          contentLabel='Modal'
          className='modal__content'
          overlayClassName='modal__overlay'
        >
          <div className='modal-content'>
            <h2 className='modal-content__title'>bootcamp の Commit ランキングサイト</h2>
            <p>FBC Contributors は、<a href='https://github.com/fjordllc/bootcamp' target='_blank' rel='noopner'>bootcamp repository</a> の Main Branch に Merge された Commit 数を集計し、ランキング表示をします。</p>
            <p>
              就職活動の際、自身が行った Commit 一覧を企業に提出するとき、
              他の人がどんな Commit を行ったか、どれくらい Commit を確認したいときに便利です。
            </p>
            <h3 className='modal-content__sub-title'>ランキング更新タイミング</h3>
            <p>毎日 0 時、6 時、12 時、18 時の 4 回ランキングを更新します。</p>
            <h3 className='modal-content__sub-title'>操作方法</h3>
            <p>
              タブからランキングの期間を選択できます。
              <br />
              Contributor 名をクリックすると、その Contributor が行った Commit 一覧ページに遷移します。
              <br />
              検索ボックスから、Contirbutor の検索もできます。
            </p>
            <h3 className='modal-content__sub-title'>作者について</h3>
            <p>rosh-1228</p>
            <ul className='inline-list'>
              <li className='inline-list__item'>
                <a href='https://github.com/rosh-1228/fjord-boot-camp-contributors' target='_blank' rel='noopner'>
                  <i className='fa-brands fa-github'></i>
                </a>
              </li>
              <li className='inline-list__item'>
                <a href='https://twitter.com/rosh_1228' target='_blank' rel='noopner'>
                  <i className='fa-brands fa-twitter'></i>
                </a>
              </li>
              <li className='inline-list__item'>
                <a href='https://rosh-1228.hatenablog.com/' target='_blank' rel='noopner'>
                  <img src='/assets/hatenablog-logo.svg' alt='はてなブログロゴマーク' />
                </a>
              </li>
            </ul>
          </div>
        </Modal>
      </>
    )
  }
}

export default Description
