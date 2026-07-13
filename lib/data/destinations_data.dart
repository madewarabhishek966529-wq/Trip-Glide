import '../models/destination.dart';

/// Deterministic placeholder photography (picsum.photos, seeded so the same
/// destination always gets the same image) stands in for a real photo CMS.
/// Swap [_img] for a real asset/CDN pipeline when connecting a photo
/// service -- nothing else in the app needs to change since destinations are
/// always accessed through [DestinationRepository].
String _img(String seed, {int w = 900, int h = 700}) => 'https://picsum.photos/seed/$seed/$w/$h';

List<String> _gallery(String base, int count) =>
    List.generate(count, (i) => _img('$base-$i', w: 1000, h: 750));

/// Seed catalog of destinations. Loaded into Hive once by [SeedService] on
/// first app launch; after that, everything (favorites, edits, new
/// destinations if you ever add an admin CRUD screen) lives in Hive only.
final List<Destination> seedDestinations = [
  Destination(
    id: 'dest_rio',
    city: 'Rio de Janeiro',
    country: 'Brazil',
    categoryId: 'cat_south_america',
    coverImage: _img('rio-cover'),
    gallery: _gallery('rio', 5),
    rating: 5.0,
    reviewCount: 143,
    price: 659,
    description:
        "Rio de Janeiro, often simply called Rio, is one of Brazil's most iconic cities, renowned for its dramatic "
        "coastline, Christ the Redeemer, and the rhythm of samba spilling out of every neighborhood. Spend mornings "
        "hiking Sugarloaf Mountain, afternoons on Copacabana or Ipanema beach, and evenings wandering the colorful "
        "streets of Santa Teresa. The city blends natural beauty with an energy you feel the moment you land.",
    latitude: -22.9068,
    longitude: -43.1729,
    tags: const ['Beach', 'Mountains', 'Nightlife', 'Culture'],
  ),
  Destination(
    id: 'dest_machu_picchu',
    city: 'Machu Picchu',
    country: 'Peru',
    categoryId: 'cat_south_america',
    coverImage: _img('machu-cover'),
    gallery: _gallery('machu', 5),
    rating: 4.9,
    reviewCount: 210,
    price: 780,
    description:
        "Perched high in the Andes, Machu Picchu is the best-preserved citadel of the Inca Empire. Reaching it -- "
        "whether by scenic train or the multi-day Inca Trail -- is part of the experience. Terraced stone "
        "agriculture, temples aligned to the solstices, and cloud forest views make this one of the most "
        "photographed and least fully understood ruins on Earth.",
    latitude: -13.1631,
    longitude: -72.5450,
    tags: const ['Mountains', 'History', 'Hiking'],
  ),
  Destination(
    id: 'dest_patagonia',
    city: 'Torres del Paine',
    country: 'Chile',
    categoryId: 'cat_south_america',
    coverImage: _img('patagonia-cover'),
    gallery: _gallery('patagonia', 5),
    rating: 4.8,
    reviewCount: 96,
    price: 890,
    description:
        "Patagonia's Torres del Paine National Park is a wilderness of granite towers, turquoise glacial lakes, "
        "and wind-scoured steppe. Multi-day treks like the W Circuit reward hikers with condors overhead, guanaco "
        "herds, and glaciers calving into milky lakes. Pack layers -- the weather changes as fast as the views.",
    latitude: -50.9423,
    longitude: -73.4068,
    tags: const ['Mountains', 'Hiking', 'Wildlife'],
  ),
  Destination(
    id: 'dest_paris',
    city: 'Paris',
    country: 'France',
    categoryId: 'cat_europe',
    coverImage: _img('paris-cover'),
    gallery: _gallery('paris', 5),
    rating: 4.9,
    reviewCount: 312,
    price: 540,
    description:
        "Paris needs little introduction: the Eiffel Tower at dusk, Seine river walks, Montmartre cafes, and world"
        "-class museums packed into a city built for wandering. Beyond the icons, quiet courtyard gardens and "
        "neighborhood bakeries reward travelers who slow down and explore beyond the main boulevards.",
    latitude: 48.8566,
    longitude: 2.3522,
    tags: const ['City', 'Culture', 'Food'],
  ),
  Destination(
    id: 'dest_santorini',
    city: 'Santorini',
    country: 'Greece',
    categoryId: 'cat_europe',
    coverImage: _img('santorini-cover'),
    gallery: _gallery('santorini', 5),
    rating: 4.9,
    reviewCount: 268,
    price: 610,
    description:
        "Whitewashed villages cling to volcanic cliffs above the Aegean in Santorini, one of the most photographed "
        "islands in the world. Watch the sunset from Oia, swim at the Red Beach, and sample crisp Assyrtiko wine "
        "grown in ash-rich volcanic soil found almost nowhere else on the planet.",
    latitude: 36.3932,
    longitude: 25.4615,
    tags: const ['Beach', 'Island', 'Romantic'],
  ),
  Destination(
    id: 'dest_swiss_alps',
    city: 'Zermatt',
    country: 'Switzerland',
    categoryId: 'cat_europe',
    coverImage: _img('zermatt-cover'),
    gallery: _gallery('zermatt', 5),
    rating: 4.8,
    reviewCount: 154,
    price: 920,
    description:
        "Zermatt sits directly beneath the Matterhorn's unmistakable pyramid peak, car-free and framed by some of "
        "the best skiing and alpine hiking in Europe. Ride the Gornergrat railway at sunrise for a view over 29 "
        "peaks above 4,000 meters, then warm up with fondue in a centuries-old chalet.",
    latitude: 46.0207,
    longitude: 7.7491,
    tags: const ['Mountains', 'Skiing', 'Hiking'],
  ),
  Destination(
    id: 'dest_kyoto',
    city: 'Kyoto',
    country: 'Japan',
    categoryId: 'cat_asia',
    coverImage: _img('kyoto-cover'),
    gallery: _gallery('kyoto', 5),
    rating: 4.9,
    reviewCount: 289,
    price: 470,
    description:
        "Japan's former imperial capital holds over a thousand temples and shrines, from the golden pavilion of "
        "Kinkaku-ji to the endless vermillion gates of Fushimi Inari. Spring brings cherry blossoms along the "
        "Philosopher's Path; autumn sets the maple groves ablaze. Kyoto rewards a slow, deliberate visit.",
    latitude: 35.0116,
    longitude: 135.7681,
    tags: const ['City', 'Culture', 'History'],
  ),
  Destination(
    id: 'dest_bali',
    city: 'Ubud',
    country: 'Indonesia',
    categoryId: 'cat_asia',
    coverImage: _img('bali-cover'),
    gallery: _gallery('bali', 5),
    rating: 4.7,
    reviewCount: 401,
    price: 380,
    description:
        "Ubud is Bali's cultural heart -- terraced rice paddies, riverside yoga studios, and forests thick with "
        "temples and macaques. Beyond town, waterfalls, volcano sunrise hikes, and coastal surf towns make it easy "
        "to build an entire trip around this one small but endlessly varied island.",
    latitude: -8.5069,
    longitude: 115.2625,
    tags: const ['Culture', 'Wellness', 'Nature'],
  ),
  Destination(
    id: 'dest_halong',
    city: 'Ha Long Bay',
    country: 'Vietnam',
    categoryId: 'cat_asia',
    coverImage: _img('halong-cover'),
    gallery: _gallery('halong', 5),
    rating: 4.6,
    reviewCount: 178,
    price: 340,
    description:
        "Thousands of limestone karsts rise straight out of emerald water in Ha Long Bay, a UNESCO World Heritage "
        "site best explored by overnight junk boat. Kayak through hidden lagoons, visit floating fishing villages, "
        "and watch the karsts turn gold at sunset from the top deck.",
    latitude: 20.9101,
    longitude: 107.1839,
    tags: const ['Nature', 'Boat', 'Scenic'],
  ),
  Destination(
    id: 'dest_banff',
    city: 'Banff',
    country: 'Canada',
    categoryId: 'cat_north_america',
    coverImage: _img('banff-cover'),
    gallery: _gallery('banff', 5),
    rating: 4.8,
    reviewCount: 221,
    price: 520,
    description:
        "Banff National Park pairs glacier-fed turquoise lakes like Moraine and Louise with jagged Rocky Mountain "
        "peaks and abundant wildlife. Canoe at dawn before the crowds arrive, hike to a teahouse above Lake Louise, "
        "or soak in the Banff Upper Hot Springs after a day on the trails.",
    latitude: 51.4968,
    longitude: -115.9281,
    tags: const ['Mountains', 'Nature', 'Wildlife'],
  ),
  Destination(
    id: 'dest_new_york',
    city: 'New York City',
    country: 'United States',
    categoryId: 'cat_north_america',
    coverImage: _img('nyc-cover'),
    gallery: _gallery('nyc', 5),
    rating: 4.7,
    reviewCount: 512,
    price: 610,
    description:
        "From the High Line to Central Park, Brooklyn rooftops to Broadway marquees, New York packs an entire "
        "world of neighborhoods, cuisines, and skylines into five boroughs. It rewards travelers who pick a few "
        "neighborhoods and walk rather than trying to see everything on a checklist.",
    latitude: 40.7128,
    longitude: -74.0060,
    tags: const ['City', 'Nightlife', 'Food'],
  ),
  Destination(
    id: 'dest_serengeti',
    city: 'Serengeti',
    country: 'Tanzania',
    categoryId: 'cat_africa',
    coverImage: _img('serengeti-cover'),
    gallery: _gallery('serengeti', 5),
    rating: 4.9,
    reviewCount: 132,
    price: 1450,
    description:
        "The Serengeti's endless grassland is home to the Great Migration -- over a million wildebeest and zebra "
        "moving in step with the rains. Game drives here routinely turn up lion prides, elephant herds, and, with "
        "patience, a leopard draped over an acacia branch at golden hour.",
    latitude: -2.3333,
    longitude: 34.8333,
    tags: const ['Safari', 'Wildlife', 'Nature'],
  ),
  Destination(
    id: 'dest_marrakech',
    city: 'Marrakech',
    country: 'Morocco',
    categoryId: 'cat_africa',
    coverImage: _img('marrakech-cover'),
    gallery: _gallery('marrakech', 5),
    rating: 4.6,
    reviewCount: 187,
    price: 310,
    description:
        "Marrakech's medina is a maze of souks, riads, and spice stalls that opens onto the theatrical chaos of "
        "Jemaa el-Fnaa square each evening. Day trips reach the Atlas Mountains or the edge of the Sahara, making "
        "the Red City a natural base for both culture and desert adventure.",
    latitude: 31.6295,
    longitude: -7.9811,
    tags: const ['Culture', 'Desert', 'Markets'],
  ),
  Destination(
    id: 'dest_queenstown',
    city: 'Queenstown',
    country: 'New Zealand',
    categoryId: 'cat_oceania',
    coverImage: _img('queenstown-cover'),
    gallery: _gallery('queenstown', 5),
    rating: 4.8,
    reviewCount: 165,
    price: 700,
    description:
        "Queenstown is New Zealand's adventure capital, set on Lake Wakatipu beneath the jagged Remarkables range. "
        "Bungy jump where the sport was born, hike the Ben Lomond track, or simply take the gondola up for a view "
        "that explains why this small town punches so far above its weight.",
    latitude: -45.0312,
    longitude: 168.6626,
    tags: const ['Mountains', 'Adventure', 'Lake'],
  ),
  Destination(
    id: 'dest_gold_coast',
    city: 'Gold Coast',
    country: 'Australia',
    categoryId: 'cat_oceania',
    coverImage: _img('goldcoast-cover'),
    gallery: _gallery('goldcoast', 5),
    rating: 4.5,
    reviewCount: 143,
    price: 480,
    description:
        "Sixty kilometers of surf beaches meet rainforest hinterland on the Gold Coast. Surf at Snapper Rocks, "
        "spot wildlife in Lamington National Park, or ride the skyline of Surfers Paradise -- a rare mix of laid"
        "-back beach town and small city in one stretch of coast.",
    latitude: -28.0167,
    longitude: 153.4000,
    tags: const ['Beach', 'Surf', 'Nature'],
  ),
];
