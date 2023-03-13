// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:thinkthat/Services/Community.dart';
import 'package:thinkthat/Services/GenPrompt.dart';
import 'package:thinkthat/Models/PromptModel.dart';
import 'package:thinkthat/Screens/HomeScreen/home.dart';
import 'package:thinkthat/Screens/ImageScreen/components/imageLayout.dart';

import '../../utils/constant.dart';

class CreatePrompt extends StatefulWidget {
  const CreatePrompt({super.key});

  @override
  State<CreatePrompt> createState() => _CreatePromptState();
}

class _CreatePromptState extends State<CreatePrompt> {
  bool isGenerating = false;
  bool isSharing = false;
  bool isShared = false;
  bool isGenerated = false;
  String name = '';
  String prompt = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController promptController = TextEditingController();
  var bytes;
  String responsePrompt = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildAppBar(size.height),
            SizedBox(
              height: size.height - (size.height / 10),
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Create imaginative and visually stunning images through ThinkThat AI and share them with the community.\n',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: size.height / 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14.0),
                              child: CustomTextField(
                                title: 'Name',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 14.0),
                              child: CustomTextField(
                                  title: 'Prompt', isPrompt: true),
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    int randomIndex = Random()
                                        .nextInt(surpriseMePrompts.length);
                                    prompt = surpriseMePrompts[randomIndex];
                                    promptController.text = prompt;
                                  });
                                },
                                child: const Text('Surprize me')),
                            SizedBox(
                              height: size.height / 20,
                            ),
                            // false
                            isGenerating || isGenerated
                                ? isGenerated
                                    ? ImageLayout(
                                        post: Post(imageUrl: responsePrompt),
                                        isSearching: false,
                                        isCreatePrompt: true)
                                    : const SizedBox(
                                        height: 300,
                                        width: 300,
                                        child: Center(
                                            child: CircularProgressIndicator()))
                                : Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      color: Colors.grey,
                                    )),
                                    child: Image.asset(
                                        'assets/images/sampleImage.png')),
                            SizedBox(
                              height: size.height / 20,
                            ),
                            SizedBox(
                              height: 35,
                              child: ElevatedButton(
                                  onPressed: isGenerating ||
                                          prompt == '' ||
                                          prompt.isEmpty
                                      ? null
                                      : () async {
                                          bool isDone = false;
                                          try {
                                            if (!isDone) {
                                              setState(() {
                                                isDone = false;
                                                isGenerated = false;
                                                isGenerating = true;
                                              });
                                              var image = await GenPromptApi
                                                  .genPromptApi(prompt: prompt);
                                              if (image.isNumericOnly) {
                                                Get.snackbar("Alert",
                                                    "Status Code : ${image.toString()}");
                                              } else {
                                                setState(() {
                                                  responsePrompt = (jsonDecode(
                                                      image))['photo'];
                                                  bytes = base64
                                                      .decode(responsePrompt);
                                                });
                                              }
                                            }
                                            setState(() {
                                              isDone = true;
                                              isGenerated = true;
                                              isGenerating = false;
                                            });
                                          } catch (e) {
                                            setState(() {
                                              isDone = false;
                                              isGenerated = false;
                                              isGenerating = false;
                                            });
                                          }
                                        },
                                  child: Text(isGenerating
                                      ? 'Generating...'
                                      : 'Generate')),
                            ),
                            SizedBox(
                              height: size.height / 30,
                            ),
                            const Text(
                                'Once you have created the image you want, you can share it with others in the community'),
                            SizedBox(
                              height: size.height / 30,
                            ),
                            SizedBox(
                              height: 35,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: name == '' ||
                                          name.isEmpty ||
                                          !isGenerated ||
                                          isSharing
                                      ? null
                                      : () async {
                                          bool isDone = false;
                                          try {
                                            if (!isDone) {
                                              setState(() {
                                                isDone = false;
                                                isShared = false;
                                                isSharing = true;
                                              });
                                              String base64String =
                                                  "data:image/jpeg;base64,$responsePrompt";
                                              bool isPosted = await CommunityApi
                                                  .postPromptApi(Post(
                                                      imageUrl: base64String,
                                                      title: name,
                                                      prompt: prompt));
                                              setState(() {
                                                isDone = true;
                                                isShared = true;
                                                isSharing = false;
                                              });
                                              if (isPosted) {
                                                Get.off(const HomeScreen(),
                                                    transition: Transition
                                                        .circularReveal);
                                              }
                                            }
                                          } catch (e) {
                                            setState(() {
                                              isDone = false;
                                              isShared = false;
                                              isSharing = false;
                                            });
                                          }
                                        },
                                  child: Text(isSharing
                                      ? 'Sharing with Community...'
                                      : 'Share with Community')),
                            ),
                            SizedBox(
                              height: size.height / 10,
                            ),
                          ]),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(height) {
    return Container(
      height: height / 10,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "Create",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              // appbarTextStyle,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 16.0),
          CloseButton(
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  Widget CustomTextField({String title = '', bool isPrompt = false}) {
    return CupertinoSearchTextField(
      controller: isPrompt ? promptController : nameController,
      placeholder: title,
      padding: !isPrompt
          ? const EdgeInsetsDirectional.fromSTEB(5.5, 15, 5.5, 15)
          : const EdgeInsetsDirectional.fromSTEB(5.5, 25, 5.5, 25),
      prefixIcon: Container(),
      onChanged: (value) {
        setState(() {
          if (isPrompt) {
            prompt = value;
          } else {
            name = value;
          }
        });
      },
      autocorrect: true,
    );
  }
}
