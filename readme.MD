
# Jahia Store Locator

The **Jahia Store Locator** module provides a fully configurable and translatable content structure for managing physical store locations with geolocation, address, opening hours, and search capability.

## ✨ Features

- Custom content types for stores (`slocnt:store`)
- Mixins for address and geo-location (`slocmix:address`, `slocmix:geo`)
- Multi-language support
- Structured content for opening hours
- Support for amenity listing, image, contact, and web links
- Ready for GraphQL querying
- Includes UI field labels and tooltips in English and French

## 📦 Content Types

- **`slocnt:store`**: Main content type for a store location

## 🧩 Mixins

- **`slocmix:storeLocator`**: Tags the content as a store for locator usage
- **`slocmix:address`**: Common address fields (street, city, postal code, etc.)
- **`slocmix:geo`**: Latitude and longitude support

## 🔤 Translations

UI labels are provided in:
- English (`messages.properties`)
- French (`messages_fr.properties`)

## ⚙️ Usage

1. Deploy the module in your Jahia environment
2. Add `slocnt:store` content types to your content tree
3. Use GraphQL or REST APIs to fetch and display store data
4. Optionally connect with a React/Vite frontend or embedded iframe

## 📂 Files Included

- `definitions.cnd`: JCR node type definitions
- `messages.properties`: English labels
- `messages_fr.properties`: French labels
- `store-locator.json`: Example structured store content
- `graphql/queries`: GraphQL examples for querying stores

## 🗺️ Example GraphQL Query

```graphql
query GetStores($language: String!) {
  jcr {
    nodesByCriteria(criteria: {nodeType: "slocnt:store"}) {
      nodes {
        uuid
        displayName(language: $language)
        name: property(name: "name", language: $language) { value }
        ...
      }
    }
  }
}
```

## 📞 Support

For improvements or contributions, feel free to submit issues or pull requests on the repository.
