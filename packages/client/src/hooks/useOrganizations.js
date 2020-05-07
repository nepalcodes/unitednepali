import { useState } from 'react';
import { useAsyncEffect } from 'use-async-effect';
import getOrganizations from '../services/organizations';

export default function useOrganizations() {
  const [organizations, setOrganizations] = useState([]);

  useAsyncEffect(async () => {
    const orgs = await getOrganizations();
    setOrganizations(orgs);
  }, []);

  return organizations;
}
