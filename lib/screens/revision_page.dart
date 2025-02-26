import 'package:flutter/material.dart';
import '../widgets/category_card.dart';
import '../widgets/custom_app_bar.dart';
import 'home_page.dart';
import 'package:share_plus/share_plus.dart';
import 'revision_modules/squares_page.dart';
import 'revision_modules/cubes_page.dart';
import 'revision_modules/tables_page.dart';
import 'revision_modules/alphabets_page.dart';
import 'revision_modules/trigonometry_page.dart';
import 'revision_modules/pythagorean_triplets_page.dart';

class RevisionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '|  ',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'REVISION MODULES',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.2,
                children: [
                  CategoryCard(
                    title: 'Tables',
                    icon: Icons.table_chart,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TablesPage()),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Squares',
                    icon: Icons.exposure,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SquaresPage()),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Cubes',
                    icon: Icons.all_inclusive,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CubesPage()),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Trigonometry',
                    icon: Icons.functions,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TrigonometryPage()),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Pythagorean Triplets',
                    icon: Icons.change_history,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PythagoreanTripletsPage()),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Alphabets & Numbers',
                    icon: Icons.sort_by_alpha,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AlphabetsPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}