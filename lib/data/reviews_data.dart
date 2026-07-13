import '../models/review.dart';

String _avatar(String seed) => 'https://picsum.photos/seed/$seed/200/200';

/// Seed reviews. A handful per destination is enough to make the reviews
/// tab and rating aggregation feel real without hand-writing hundreds.
List<Review> buildSeedReviews() {
  final entries = <List<dynamic>>[
    ['dest_rio', 'Camila Souza', 5.0, 'Copacabana at sunrise alone was worth the trip. Book the Sugarloaf cable car for early morning -- no lines.'],
    ['dest_rio', 'John Miller', 4.8, 'Incredible energy, incredible food. Just keep your valuables close in busier areas.'],
    ['dest_rio', 'Aiko Tanaka', 5.0, 'Christ the Redeemer at golden hour is unreal. Our guide made the history come alive.'],
    ['dest_machu_picchu', 'Priya Nair', 5.0, 'Did the 4-day Inca Trail. Exhausting but genuinely the best trip of my life.'],
    ['dest_machu_picchu', 'Tom Becker', 4.7, 'Train option is more comfortable if you are short on time and still stunning.'],
    ['dest_patagonia', 'Lucas Fischer', 4.9, 'The W Circuit tested us but the towers at sunrise made every blister worth it.'],
    ['dest_patagonia', 'Nora Ahlgren', 4.6, 'Bring proper wind gear. Weather changes in minutes, views are otherworldly.'],
    ['dest_paris', 'Emily Clarke', 4.9, 'Skipped the tourist traps and just wandered Le Marais -- best decision.'],
    ['dest_paris', 'Marco Rossi', 4.8, 'Musee d\'Orsay was quieter than the Louvre and just as impressive.'],
    ['dest_santorini', 'Helena Papas', 5.0, 'Oia sunset lives up to the hype. Book dinner reservations weeks ahead.'],
    ['dest_santorini', 'Daniel Cho', 4.7, 'Rented a quad bike to explore Red Beach and Akrotiri, highly recommend.'],
    ['dest_swiss_alps', 'Sophie Meier', 4.9, 'Gornergrat sunrise train is worth setting an alarm at 4am for.'],
    ['dest_kyoto', 'Wei Zhang', 5.0, 'Fushimi Inari before 7am means you get the gates almost to yourself.'],
    ['dest_kyoto', 'Grace Kim', 4.8, 'Arashiyama bamboo grove was more magical than photos suggest.'],
    ['dest_bali', 'Isabelle Novak', 4.6, 'Ubud rice terraces at dawn, waterfall hopping midday -- perfect combo.'],
    ['dest_bali', 'Ryan O\'Connell', 4.8, 'Ate at a warung the whole trip and never had a bad meal.'],
    ['dest_halong', 'Minh Tran', 4.5, 'Overnight junk boat with kayaking through the caves was the highlight.'],
    ['dest_banff', 'Olivia Bennett', 4.9, 'Canoed Moraine Lake at 6am before the tour buses arrived. Unreal color.'],
    ['dest_new_york', 'Marcus Reyes', 4.6, 'Walked the High Line into Chelsea Market, exactly the NYC day I wanted.'],
    ['dest_serengeti', 'Fatima Diallo', 5.0, 'Witnessed a river crossing during the migration. Genuinely emotional.'],
    ['dest_marrakech', 'Karim El Amrani', 4.5, 'Get lost in the medina on purpose, then let a local point you home.'],
    ['dest_queenstown', 'Jack Sullivan', 4.9, 'Did the bungy, then a quiet hike up Ben Lomond -- both unforgettable.'],
    ['dest_gold_coast', 'Chloe Anderson', 4.4, 'Surf lessons at Snapper Rocks were a great way to start each morning.'],
  ];

  return List.generate(entries.length, (i) {
    final e = entries[i];
    return Review(
      id: 'review_${i + 1}',
      destinationId: e[0] as String,
      userName: e[1] as String,
      userAvatar: _avatar('avatar-${i + 1}'),
      rating: e[2] as double,
      comment: e[3] as String,
      createdAt: DateTime.now().subtract(Duration(days: (i + 1) * 6)),
    );
  });
}
