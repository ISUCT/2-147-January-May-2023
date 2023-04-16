import './App.scss';
import { Header } from './Components/cells/Header';
import FlexContainer from './Components/common/FlexContainer/FlexContainer';
import { MainOrganism } from './Components/organisms/MainOrganism/MainOrganism';

function App() {
  return (
    <div className='app-wrapper'>
      <Header />
      <FlexContainer> body </FlexContainer>
      <FlexContainer>footer </FlexContainer>
    </div>
  );
}

export default App;
