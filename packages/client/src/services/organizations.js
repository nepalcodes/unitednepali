
export async function getOrganizations() {

  const url = `https://firestore.googleapis.com/v1/projects/united-nepali/databases/(default)/documents/api/v1/organizations`;
  const response = await fetch(url);
  const result = await response.json();
  const documents = result.documents;


  // Get the fields in the proper format
  // BEFORE:
  // name:
  //   "projects/united-nepali/databases/(default)/documents/api/v1/organizations/4nLPJbNDxqyMR2PJXurk",
  // fields: {
  //   name: {
  //     stringValue: "NCCS"
  //   },
  //   phone: {
  //     stringValue: "647-760-4340"
  //   },
  //   description: {
  //     stringValue:
  //       "We are a nonprofit organization focused on helping make the world around us a better, happier place. With the help of our tireless staff, we organize fundraisers, community-building events, and in-depth training sessions for our volunteers."
  //   },
  //   link: {
  //     stringValue: "https://nccstoronto.org/contact-us"
  //   }
  // }

  // AFTER:
  // {
  //   "phone": "647-857-9841",
  //   "name": "NRNA Canada (NON-RESIDENT NEPALI ASSOCIATION CANADA)",
  //   "email": "nrn.canada08@gmail.com",
  //   "description": " Registered with the Government of Canada in March 2007 as a non-profit representative organization of the people of Nepalese origin living in Canada, NRN-Canada is primarily concerned in promoting the common interests of its members in Canada and Nepal",
  //   "link": "https://www.nrnacanada.org"
  // }

  const organizations = documents.map(document => {
    const fieldKeys = Object.keys(document.fields);
    const fields = {};
    fieldKeys.forEach(fieldKey => {
      fields[fieldKey] = Object.values(document.fields[fieldKey])[0];
    });

    console.log(JSON.stringify(fields, null, "\n"));
    return {
      ...fields,
      id: document.name
    };
  });

  return organizations;
}
