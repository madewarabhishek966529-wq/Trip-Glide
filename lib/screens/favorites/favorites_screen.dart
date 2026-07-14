import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../models/destination.dart';
import '../../providers/destination_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/destination_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/search_field.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String _query = '';

  void _openDestination(Destination destination) {
    context.read<DestinationProvider>().recordView(destination.id);
    Navigator.of(context).pushNamed(AppRoutes.details, arguments: destination.id);
  }

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoriteProvider>();
    final results = favorites.search(_query);

    return Scaffold(
      appBar: AppBar(title: Text('Favorites (${favorites.count})')),
      body: SafeArea(
        child: Column(
          children: [
            if (favorites.count > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg, vertical: AppConstants.spaceSm),
                child: SearchField(
                  hintText: 'Search your favorites',
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
            Expanded(
              child: favorites.count == 0
                  ? const EmptyState(
                      icon: Icons.favorite_border_rounded,
                      title: 'No favorites yet',
                      message: 'Tap the heart on any destination to save it here.',
                    )
                  : results.isEmpty
                      ? const EmptyState(
                          icon: Icons.search_off_rounded,
                          title: 'No matches',
                          message: 'Try a different search term.',
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(AppConstants.spaceLg),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: AppConstants.spaceMd,
                            crossAxisSpacing: AppConstants.spaceMd,
                            childAspectRatio: 0.72,
                          ),
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final destination = results[index];
                            return DestinationCard(
                              destination: destination,
                              width: double.infinity,
                              height: double.infinity,
                              onTap: () => _openDestination(destination),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
