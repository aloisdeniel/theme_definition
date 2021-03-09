const defaultYaml = '''
name: Example
colors:
  light:
    accent: '#FFFF3E9A'
    foreground: '#FF000000'
    background: '#FFFFFFFF'
  dark:
    accent: '#FFFF3E9A'
    foreground: '#FFFFFFFF'
    background: '#FF000000'
spacing:
  regular: 
    small: 4
    regular: 20
    big: 32
radiuses:
  regular: 
    small: 2
    regular: 4
    big: 12
fontSizes:
  regular:
    medium: 10
    regular: 12
  big:
    medium: 15
    regular: 22
sizes:
  regular:
    avatar: 24
  big:
    avatar: 
      width: 42
      height: 42
fontStyles:
  regular:
    title:
      source: GoogleFonts
      fontFamily: 'Montserrat'
      decoration: none
      fontWeight: 700
      letterSpacing: -0.1
    content: 
      fontFamily: 'Roboto'
      decoration: none
      fontWeight: 400
  handwritten:
    title: 
      source: GoogleFonts
      fontFamily: 'Architects Daughter'
      decoration: none
      fontWeight: 400
      letterSpacing: -0.1
    content: 
      source: GoogleFonts
      fontFamily: 'Yantramanav'
      decoration: none
      fontWeight: 400
durations:
  regular:
    quick: 100
    regular: 200
    slow: 
      seconds: 1
  slow:
    quick: 300
    regular: 500
    slow: 
      seconds: 4
icons:
  lines:
    sun: 
      <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M16.0005 2C16.5528 2 17.0005 2.44772 17.0005 3V5C17.0005 5.55228 16.5528 6 16.0005 6C15.4482 6 15.0005 5.55228 15.0005 5V3C15.0005 2.44772 15.4482 2 16.0005 2ZM26.2071 7.20711C26.5977 6.81658 26.5977 6.18342 26.2071 5.79289C25.8166 5.40237 25.1835 5.40237 24.7929 5.79289L23.2929 7.29289C22.9024 7.68342 22.9024 8.31658 23.2929 8.70711C23.6835 9.09763 24.3166 9.09763 24.7071 8.70711L26.2071 7.20711ZM5.79289 5.79293C6.18341 5.4024 6.81658 5.4024 7.20711 5.79291L8.70711 7.29287C9.09764 7.68339 9.09765 8.31656 8.70713 8.70709C8.31661 9.09762 7.68344 9.09763 7.29291 8.70711L5.79291 7.20715C5.40238 6.81663 5.40237 6.18346 5.79289 5.79293ZM9.00001 16C9.00001 12.134 12.134 9 16 9C19.866 9 23 12.134 23 16C23 19.866 19.866 23 16 23C12.134 23 9.00001 19.866 9.00001 16ZM16 11C13.2386 11 11 13.2386 11 16C11 18.7614 13.2386 21 16 21C18.7614 21 21 18.7614 21 16C21 13.2386 18.7614 11 16 11ZM26 16.0213C26 15.469 26.4478 15.0213 27 15.0213H29C29.5523 15.0213 30 15.469 30 16.0213C30 16.5736 29.5523 17.0213 29 17.0213H27C26.4478 17.0213 26 16.5736 26 16.0213ZM3 15C2.44772 15 2 15.4477 2 16C2 16.5523 2.44772 17 3 17H5C5.55229 17 6.00001 16.5523 6.00001 16C6.00001 15.4477 5.55229 15 5 15H3ZM23.2929 23.2929C23.6835 22.9023 24.3166 22.9023 24.7071 23.2929L26.2071 24.7929C26.5977 25.1834 26.5977 25.8166 26.2071 26.2071C25.8166 26.5976 25.1835 26.5976 24.7929 26.2071L23.2929 24.7071C22.9024 24.3166 22.9024 23.6834 23.2929 23.2929ZM8.70712 24.7071C9.09764 24.3166 9.09764 23.6834 8.70712 23.2929C8.31659 22.9023 7.68343 22.9023 7.2929 23.2929L5.7929 24.7929C5.40237 25.1834 5.40237 25.8166 5.7929 26.2071C6.18342 26.5976 6.81659 26.5976 7.20711 26.2071L8.70712 24.7071ZM16.9956 27.0192C16.9956 26.4669 16.5479 26.0192 15.9956 26.0192C15.4433 26.0192 14.9956 26.4669 14.9956 27.0192V29C14.9956 29.5523 15.4433 30 15.9956 30C16.5479 30 16.9956 29.5523 16.9956 29V27.0192Z" fill="#212121"/>
      </svg>
  filled:
    sun: 
      <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M16.0005 2C16.5528 2 17.0005 2.44772 17.0005 3V5C17.0005 5.55228 16.5528 6 16.0005 6C15.4482 6 15.0005 5.55228 15.0005 5V3C15.0005 2.44772 15.4482 2 16.0005 2ZM26.2071 7.20711C26.5977 6.81658 26.5977 6.18342 26.2071 5.79289C25.8166 5.40237 25.1835 5.40237 24.7929 5.79289L23.2929 7.29289C22.9024 7.68342 22.9024 8.31658 23.2929 8.70711C23.6835 9.09763 24.3166 9.09763 24.7071 8.70711L26.2071 7.20711ZM5.79289 5.79293C6.18341 5.4024 6.81658 5.4024 7.20711 5.79291L8.70711 7.29287C9.09764 7.68339 9.09765 8.31656 8.70713 8.70709C8.31661 9.09762 7.68344 9.09763 7.29291 8.70711L5.79291 7.20715C5.40238 6.81663 5.40237 6.18346 5.79289 5.79293ZM16 9C12.134 9 9.00001 12.134 9.00001 16C9.00001 19.866 12.134 23 16 23C19.866 23 23 19.866 23 16C23 12.134 19.866 9 16 9ZM26 16.0213C26 15.469 26.4478 15.0213 27 15.0213H29C29.5523 15.0213 30 15.469 30 16.0213C30 16.5736 29.5523 17.0213 29 17.0213H27C26.4478 17.0213 26 16.5736 26 16.0213ZM3 15C2.44772 15 2 15.4477 2 16C2 16.5523 2.44772 17 3 17H5C5.55229 17 6.00001 16.5523 6.00001 16C6.00001 15.4477 5.55229 15 5 15H3ZM23.2929 23.2929C23.6835 22.9023 24.3166 22.9023 24.7071 23.2929L26.2071 24.7929C26.5977 25.1834 26.5977 25.8166 26.2071 26.2071C25.8166 26.5976 25.1835 26.5976 24.7929 26.2071L23.2929 24.7071C22.9024 24.3166 22.9024 23.6834 23.2929 23.2929ZM8.70712 24.7071C9.09764 24.3166 9.09764 23.6834 8.70712 23.2929C8.31659 22.9023 7.68343 22.9023 7.2929 23.2929L5.7929 24.7929C5.40237 25.1834 5.40237 25.8166 5.7929 26.2071C6.18342 26.5976 6.81659 26.5976 7.20711 26.2071L8.70712 24.7071ZM16.9956 27.0192C16.9956 26.4669 16.5479 26.0192 15.9956 26.0192C15.4433 26.0192 14.9956 26.4669 14.9956 27.0192V29C14.9956 29.5523 15.4433 30 15.9956 30C16.5479 30 16.9956 29.5523 16.9956 29V27.0192Z" fill="#212121"/>
      </svg>

configuration:
  dev:
    host: https://dev.example.com/api
    maps:
      server: 'https://maps.com/tiles'
  prerelease:
    host: https://pre.example.com/api
    maps:
      server: 'https://maps.com/tiles'
  release:
    host: https://example.com/api
    maps:
      server: 'https://maps.com/tiles'
labels: 
  fr:
    dates:
      weekday:
        monday: lundi
        tuesday: mardi
        wednesday: mercredi
    templated:
      hello: Bonjour {{first_name}}!
      contact: 
        cases:
          Gender.male: M. {{last_name}}
          Gender.female: Mme. {{last_name}}
      numbers:
        count: Il y a {{count:int}} éléments.
        simple: Le prix est de {{price:double}}€
        formatted: Le prix est de {{price:double[compactCurrency]}}
      date:
        simple: "Aujourd'hui : {{date:DateTime}}"
        pattern: "Aujourd'hui : {{date:DateTime[EEE, M/d/y]}}"
    plurals:
      man:
        cases:
          Plural.zero: hommes
          Plural.one: homme
          Plural.multiple: hommes
    multiline:
      C'est

      une

      exemple multiligne.
  en:
    dates:
      weekday:
        monday: monday
        tuesday: tuesday
        wednesday: wednesday
    templated:
      hello: Hello {{first_name}}!
      contact: 
        cases:
          Gender.male: Mr {{last_name}}
          Gender.female: Mrs {{last_name}}
      numbers:
        count: There are {{count:int}} items.
        simple: The price is {{price:double}}\$
        formatted: The price is {{price:double[compactCurrency]}}
      date:
        simple: "Today : {{date:DateTime}}"
        pattern: "Today : {{date:DateTime[EEE, M/d/y]}}"
    plurals:
      man:
        cases:
          Plural.zero: man
          Plural.one: man
          Plural.multiple: men
    multiline:
      This is

      a

      multiline example.à
''';
