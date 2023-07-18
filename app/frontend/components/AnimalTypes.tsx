import React, { FC, useState, useEffect } from "react";
import useSWR, { Fetcher } from "swr";
import Axios from "axios";
import AnimalTypeButton from "./AnimalTypeButton";


const fetcher: Fetcher<string[]> = (endpoint: string) =>
  Axios.get(endpoint).then((res) => res.data)

const AnimalTypes: FC = () => {
  const { data, error, isLoading } = useSWR<string[], Error>(
    "/api/v1/animal_types",
    fetcher,
    { errorRetryCount: 0 }
  );

  const [selected, setSelected] = useState<string>("");

  if (error) return <div>Sorry, there was an error. Please try again.</div>
  if (isLoading) return <div>Loading...</div>
  if (!data) throw new Error("not loading and not error, but data is undefined")

  return <div>
    {data.map((name) => (
      <AnimalTypeButton
        name={name}
        isSelected={selected === name}
        setSelected={setSelected}
        key={name}
      />
    ))}
  </div>
}

export default AnimalTypes