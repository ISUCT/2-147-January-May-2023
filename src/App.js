import './App.scss';

import Header from './Components/Header/Header';
import Forum from './Components/body/Forum';
import Border from './Components/Border/Border';

function App() {
  return (
    <div className="app-wrapper">
      <Header />
      <Border />
      <div className='app-wrapper-content'>
        <Forum />
      </div>
    </div>
  );
}

export default App;
