import React from "react";
import { render } from "@testing-library/react"
import { describe, it, expect } from "vitest";

import App from "./App";

describe("App", () => {
  it("renders", () => {
    const screen = render(<App />, { wrapper: ({ children }) => children });
    expect(screen.getByText("Hello from the react app!")).toBeInTheDocument();
  });
});