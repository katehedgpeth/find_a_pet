import React, { Dispatch, FC, SetStateAction } from "react";

interface Props {
  isSelected: boolean;
  name: string;
  setSelected: Dispatch<SetStateAction<string>>
  slug: string;

}

const className = (isSelected: boolean): string[] => {
  const always = ["btn", "m-1"]
  return isSelected ? ["btn-primary", ...always] : always
}

const AnimalTypeButton: FC<Props> = ({ isSelected, name, setSelected, slug }) => (
  <button
    className={className(isSelected).join(" ")}
    onClick={() => setSelected(slug)}
  >
    {name}
  </button>
)

export default AnimalTypeButton;