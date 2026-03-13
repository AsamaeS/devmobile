import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/guides/domain/entities/guide_entity.dart';
import 'package:flutter_clean_architecture/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:flutter_clean_architecture/features/reviews/presentation/cubit/reviews_state.dart';
import 'package:flutter_clean_architecture/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ReviewsPage extends StatefulWidget {
  final GuideEntity guide;

  const ReviewsPage({super.key, required this.guide});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ReviewsCubit>().loadReviewsForGuide(widget.guide.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        centerTitle: true,
      ),
      body: BlocConsumer<ReviewsCubit, ReviewsState>(
        listener: (context, state) {
          if (state is ReviewSubmitSuccess) {
            // Reload reviews after submitting one
            context.read<ReviewsCubit>().loadReviewsForGuide(widget.guide.id);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Review added successfully!'), backgroundColor: Colors.green),
            );
          }
        },
        builder: (context, state) {
          if (state is ReviewsLoading || state is ReviewsInitial || state is ReviewSubmitting) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReviewsError) {
            return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)));
          } else if (state is ReviewsLoaded) {
            final reviews = state.reviews;
            
            if (reviews.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.rate_review_outlined, size: 64, color: Colors.grey.withOpacity(0.5)),
                    const SizedBox(height: 16),
                    const Text('No reviews yet.', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: reviews.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10, offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(review.touristName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                              const SizedBox(width: 4),
                              Text(review.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(DateFormat('MMMM d, yyyy').format(review.date), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 12),
                      Text(review.comment),
                    ],
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(Routes.addReview, extra: widget.guide);
        },
        icon: const Icon(Icons.add_comment_rounded),
        label: const Text('Add Review'),
      ),
    );
  }
}
