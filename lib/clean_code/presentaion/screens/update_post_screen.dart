// lib/presentation/screens/update_post_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/post_entity.dart';
import '../providers/post_future_provider/future_post_provider.dart';

class UpdatePostScreen extends ConsumerStatefulWidget {
  final PostEntity post;

  const UpdatePostScreen({super.key, required this.post});

  @override
  ConsumerState<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends ConsumerState<UpdatePostScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _bodyController = TextEditingController();

  FormGroup? form;

  @override
  void initState() {
    super.initState();

    form = fb.group({
      'title': FormControl<String>(
        value: widget.post.title,
        validators: [
          Validators.compose([Validators.required, Validators.minLength(3)])
        ],
      ),
      'body': FormControl<String>(
        value: widget.post.body,
        validators: [
          Validators.compose([Validators.required, Validators.minLength(3)])
        ],
      ),
    });
    // _titleController.text = widget.post.title;
    // _bodyController.text = widget.post.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: form!,
          child: Column(
            children: [
              ReactiveTextField(
                formControlName: 'title',
                decoration: const InputDecoration(
                  labelText: 'title',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validationMessages: {
                  'required': (error) => 'The title must not be empty',
                  ValidationMessage.minLength: (error) =>
                      'the min length is three ',
                },
              ),SizedBox(height: 16,),
              ReactiveTextField(
                formControlName: 'body',
                decoration: const InputDecoration(
                  labelText: 'body',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validationMessages: {
                  'required': (error) => 'The title must not be empty',
                  ValidationMessage.minLength: (error) =>
                      'the min length is three ',
                },
              ),
              SizedBox(height: 20),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return ElevatedButton(
                    onPressed: (!form.valid)
                        ? null
                        : () async {
                            final updatedPost = PostEntity(
                              userId: widget.post.userId,
                              id: widget.post.id,
                              title: _titleController.text,
                              body: _bodyController.text,
                            );

                            final result = await ref
                                .read(updatePostProvider(updatedPost).future);
                            if (result != null) {
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Failed to update post')));
                            }
                          },
                    child: Text('Update Post'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
