import React, { FC } from "react";

interface Props {
  name: string;
  options: string[];
}

const TraitFilter: FC<Props> = ({ name, options }) => (
  <div>
    {name}:
    {options.map((option) => <button className="btn btn-xs m-1" key={option}>{option}</button>)}

  </div>
)

export default TraitFilter;