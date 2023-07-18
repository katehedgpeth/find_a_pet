import React, { FC, useState, useEffect } from "react";
import useSWR, { Fetcher } from "swr";
import Axios from "axios";
import AnimalTypeButton from "./AnimalTypeButton";
import TraitFilters, { TypeData } from "./TraitFilters";
import LoadingSpinner from "./LoadingSpinner";



const fetcher: Fetcher<TypeData[]> = (endpoint: string) =>
  Axios.get(endpoint).then((res) => res.data)

const getSelectedData = (
  selected: string,
  data: TypeData[]
): TypeData | undefined => {
  return selected ? data.find(({ slug }) => slug === selected) : undefined
}

const AnimalTypes: FC = () => {
  const { data, error, isLoading } = useSWR<TypeData[], Error>(
    "/api/v1/animal_types",
    fetcher,
    { errorRetryCount: 0 }
  );

  const [selected, setSelected] = useState<string>("");
  const [selectedData, setSelectedData] = useState<TypeData | undefined>()

  useEffect(() => {
    data && setSelectedData(getSelectedData(selected, data))
  }, [selected])

  if (error) return <div>Sorry, there was an error. Please try again.</div>;
  if (isLoading) return <LoadingSpinner />
  if (!data) return null;

  return <div>
    <div>
      {data.map((typeData) => (
        <AnimalTypeButton
          name={typeData.name}
          slug={typeData.slug}
          isSelected={selected === typeData.name}
          setSelected={setSelected}
          key={typeData.name}
        />
      ))}
    </div>
    {<TraitFilters data={selectedData} />}
  </div>
}

export default AnimalTypes