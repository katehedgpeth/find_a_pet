import React, { Dispatch, FC, SetStateAction } from "react";

interface Props {
  isSelected: boolean;
  name: string;
  setSelected: Dispatch<SetStateAction<string>>

}

const className = (isSelected: boolean): string[] => {
  const always = ["btn", "m-1"]
  return isSelected ? ["btn-primary", ...always] : always
}

const AnimalTypeButton: FC<Props> = ({ name, setSelected, isSelected }) => (
  <button
    className={className(isSelected).join(" ")}
    onClick={() => setSelected(name)}
  >
    {name}
  </button>
)

export default AnimalTypeButton;