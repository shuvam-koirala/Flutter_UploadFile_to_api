import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photofilterdata/apimanager.dart';
import 'package:photofilterdata/apimodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<FilterModel>> _filterModel;
  PickedFile image;
  File selected;

  @override
  void initState() {
    super.initState();
    // _filterModel = ApiManager().getFilter();
  }

  // Widget showPhoto() {
  //   _filterModel.map(
  //     (e) => ListView.builder(
  //       itemCount: _filterModel.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Image.network(e.file);
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera),
          onPressed: () async {
            var imagePicker =
                await ImagePicker().getImage(source: ImageSource.gallery);

            if (imagePicker != null) {
              setState(() {
                image = imagePicker;
                selected = File(image.path);
              });
              ApiManager().uploadFile(selected);
            }
          }),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("photos"),
            // FutureBuilder<List<FilterModel>>(
            //   future: _filterModel,
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     if (snapshot.hasData) {
            //       print(snapshot.data.length);
            //       return ListView.builder(
            //         scrollDirection: Axis.vertical,
            //         shrinkWrap: true,
            //         itemCount: snapshot.data.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           try {
            //             return Container(
            //                 height: 50,
            //                 width: 40,
            //                 child: Image.network(snapshot
            //                     .data[snapshot.data.length - index - 1]
            //                     .processedImage));
            //           } catch (e) {
            //             print(e.toString());
            //           }
            //         },
            //       );
            //     } else {
            //       return Center(child: CircularProgressIndicator());
            //     }
            //   },
            // ),
            Center(
                child: Container(
                    // height: 100,
                    // width: 100,
                    child: image == null
                        ? Text("no image selected!")
                        : Image.file(selected))),
          ],
        ),
      ),
    );
  }
}
