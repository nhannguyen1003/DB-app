import "./App.css";
import { useEffect, useState } from "react";
import LoadingIndicator from "./components/LoadingIndicator";
import Routing from "./Routing";

function Authenticating({ children }: { children: React.ReactNode }) {
  const [isAuthenticating, setIsAuthenticating] = useState<boolean>(true);

  useEffect(() => {
    setTimeout(() => {
      setIsAuthenticating(!isAuthenticating);
    }, 1000);
  }, []);

  if (isAuthenticating) {
    return (
      <>
        <LoadingIndicator />
      </>
    );
  }
  return <>{children}</>;
}

function App() {
  return (
    <div className="App">
      <Authenticating>
        <Routing />
      </Authenticating>
    </div>
  );
}

export default App;
