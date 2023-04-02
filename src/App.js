import './App.scss';
import Border from './Components/molecules/Border/Border';
import Forum from './Components/molecules/Forum/Forum';

import Header from './Components/molecules/Header/Header';


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
