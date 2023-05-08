import 'package:abergymmobile/AGM.Animations/FadeAnimation.dart';
import 'package:abergymmobile/AGM.Home/Layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  final Color lightblue = const Color.fromARGB(255, 42, 195, 255);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.lightBlue[900]!,
              Colors.lightBlue[800]!,
              Colors.lightBlue[400]!,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bewertung:',
                style: GoogleFonts.montserrat(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                maxRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemSize: 70,
                itemBuilder: (context, _) => const Icon(Icons.star,
                    color: Color.fromARGB(255, 255, 191, 0)),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: _commentController,
                  maxLines: 5,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Kommentar hinzufügen',
                    labelStyle: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: 25),
                    hintText: 'Geben Sie hier Ihren Kommentar ein',
                    hintStyle: GoogleFonts.montserrat(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          child: const Layout(),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          "Speichern",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          child: const Layout(),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          "Abbrechen",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
