import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanit/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[700],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage()),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.lightBlue[700],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 320,
          height: 300,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Url",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                          )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(15),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[400], width: 2),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width-50,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Text(
                                      qrText,
                                      style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.grey[400],fontSize: 15))
                                  ),
                                ),
                                VerticalDivider(
                                  color: Colors.grey,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: MaterialButton(
                                      shape: CircleBorder(),
                                      onPressed: (){
                                        Clipboard.setData(new ClipboardData(text: qrText));
                                      },
                                      child: Icon(Icons.copy,color: Colors.deepPurple[300],)
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Neumorphic(
                      style: NeumorphicStyle(
                        lightSource: LightSource.topLeft,
                        color: Colors.white10,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(


                        ),
                        child: SizedBox(
                          width: 100,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: FlatButton(onPressed: () async {
                              String url = qrText;

                              if (await canLaunch(url)) {
                                await launch(url, forceSafariVC: false);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                              child: Text("Open in browser",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.deepPurple[400],
                                        fontSize: 15
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(
                        lightSource: LightSource.topLeft,
                        color: Colors.white10,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                      ),
                      child: SizedBox(
                        width: 100,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(onPressed: () {
                            Share.share(qrText);
                          },
                            child: Text("Share",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.deepPurple[400],
                                      fontSize: 15
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
