import React from "react"
import ReactDOM from "react-dom/client";
import App from "../App";

const domNode = document.getElementById("root");
if (!domNode) throw new Error("Cannot find #root element!");

const root = ReactDOM.createRoot(domNode);
root.render(<App />);
