import styled from "styled-components";
const FlexContainer = styled.div`
  display: flex;
  flex-direction: ${props => props.direction || "row"};
  justify-content: ${props => props.justifyContent || "flex-start"};
  align-items: ${props => props.alignItems || "flex-start"};
  flex-wrap: ${props => props.flexWrap || "nowrap"};
  width: ${props => props.width || "100%"};
`
export default FlexContainer;
