import './App.scss';
import { Footer } from './Components/cells/Footer/Footer';
import { Header } from './Components/cells/Header';
import { MainOrganism } from './Components/organisms/MainOrganism/MainOrganism';

function App() {
  return (
    <div className='app-wrapper'>
      <Header />
      <MainOrganism />
      <Footer />
    </div>
  );
}

export default App;
