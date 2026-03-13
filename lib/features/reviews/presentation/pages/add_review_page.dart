import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/guides/domain/entities/guide_entity.dart';
import 'package:flutter_clean_architecture/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:flutter_clean_architecture/features/reviews/presentation/cubit/reviews_state.dart';
import 'package:go_router/go_router.dart';

class AddReviewPage extends StatefulWidget {
  final GuideEntity guide;

  const AddReviewPage({super.key, required this.guide});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  void _submit() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a star rating.'), backgroundColor: Colors.red),
      );
      return;
    }

    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a comment.'), backgroundColor: Colors.red),
      );
      return;
    }

    context.read<ReviewsCubit>().submitReview(
          guideId: widget.guide.id,
          touristName: 'Jane Doe', // Mock logged in user
          rating: _rating,
          comment: _commentController.text.trim(),
        );
  }

  Widget _buildStar(int index) {
    Icon icon;
    if (index >= _rating) {
      icon = const Icon(Icons.star_border_rounded, color: Colors.amber, size: 48);
    } else if (index > _rating - 1 && index < _rating) {
      icon = const Icon(Icons.star_half_rounded, color: Colors.amber, size: 48);
    } else {
      icon = const Icon(Icons.star_rounded, color: Colors.amber, size: 48);
    }
    return IconButton(
      onPressed: () => setState(() => _rating = index + 1.0),
      icon: icon,
      padding: EdgeInsets.zero,
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave a Review'),
        centerTitle: true,
      ),
      body: BlocConsumer<ReviewsCubit, ReviewsState>(
        listener: (context, state) {
          if (state is ReviewSubmitSuccess) {
            context.pop(); // Go back to ReviewsPage after success
          } else if (state is ReviewsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          final isSubmitting = state is ReviewSubmitting;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.guide.profileImage),
                ),
                const SizedBox(height: 16),
                Text(
                  'How was your trip with ${widget.guide.name}?',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) => _buildStar(index)),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _commentController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Share details of your experience...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Submit Review', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
