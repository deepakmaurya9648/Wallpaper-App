import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/constant.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [gradientStartColor, gradientEndColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.7])),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wallpaper',
              style: GoogleFonts.roboto(
                  fontSize: 40,
                  color: Colors.white.withOpacity(1),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '6 wallpapers available',
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: gradientEndColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 90,
            ),
            Container(
              height: 400,
              child: Swiper(
                itemCount: 6,
                itemWidth: MediaQuery.of(context).size.width - 2 * 50,
                layout: SwiperLayout.STACK,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Stack(
                      children: [
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                'https://images.unsplash.com/photo-1603145733171-50beca024bed?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8aG9tZXNjcmVlbnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                                fit: BoxFit.fill,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          left: 90,
                          bottom: 30,
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                                color: gradientEndColor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20)),
                            child: IconButton(
                              icon: Icon(
                                Icons.zoom_out_map,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )),
    ));
  }
}
