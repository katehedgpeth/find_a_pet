import React, { FC } from "react";
import Axios from "axios";
import useSWR, { Fetcher } from "swr";
import TraitFilter from "./TraitFilter";

export interface TypeData {
  name: string;
  slug: string;
  coats?: string[];
  colors?: string[];
  genders?: string[];
}

interface Props {
  data?: TypeData
}

const isValidFilter = ([, options]: [string, string | string[]]) =>
  typeof options !== "string" && options.length > 0

const TraitFilters: FC<Props> = ({ data }) => {
  if (!data) return null;

  return <div>
    <h3>Refine results:</h3>
    <div>
      {Object.entries(data)
        .filter(isValidFilter)
        .map(([filterName, options]) => (
          <TraitFilter name={filterName} options={options} key={filterName} />)
        )}
    </div>
  </div>
}

export default TraitFilters;