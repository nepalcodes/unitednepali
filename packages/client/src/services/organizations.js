
const getOrganizations = async () => {
  const url = 'https://firestore.googleapis.com/v1/projects/united-nepali/databases/(default)/documents/api/v1/organizations';
  const response = await fetch(url);
  const result = await response.json();
  const { documents } = result;

  const organizations = documents.map((document) => {
    const fieldKeys = Object.keys(document.fields);
    const fields = {};
    fieldKeys.forEach((fieldKey) => {
      const tempVal = Object.values(document.fields[fieldKey])[0];
      fields[fieldKey] = tempVal;
    });

    return {
      ...fields,
      id: document.name,
    };
  });

  return organizations;
};

export default getOrganizations;
