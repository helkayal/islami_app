import 'package:flutter/material.dart';
import 'package:islami_app/core/theming/constants.dart';
import 'package:uni_country_city_picker/uni_country_city_picker.dart';

class TopCard extends StatefulWidget {
  final String city;
  final String country;
  final String hijriDate;
  final String gregorianDate;

  const TopCard({
    super.key,
    required this.city,
    required this.country,
    required this.hijriDate,
    required this.gregorianDate,
  });

  @override
  State<TopCard> createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  final UniCountryServices _uniCountryServices = UniCountryServices.instance;

  List<Country> countriesAndCities = [];
  String? translatedCity;
  String? translatedCountry;

  @override
  void initState() {
    super.initState();
    _fetchCountriesAndCities();
  }

  /// Fetch countries and cities dynamically
  Future<void> _fetchCountriesAndCities() async {
    countriesAndCities = await _uniCountryServices.getCountriesAndCities();

    setState(() {
      // Find the country in the list
      final country = countriesAndCities.firstWhere(
        (c) => c.nameEn.toLowerCase() == widget.country.toLowerCase(),
        orElse: () => Country(
          name: widget.country,
          nameEn: widget.country,
          isoCode: 'UNKNOWN',
          dialCode: '',
          flag: '',
          cities: [],
          phoneDigitsLength: 0,
          phoneDigitsLengthMax: 0,
        ),
      );

      // Always display the Arabic country name
      translatedCountry = country.name;

      // Always display the Arabic city name
      final city = country.cities.firstWhere(
        (city) => city.nameEn.toLowerCase() == widget.city.toLowerCase(),
        orElse: () => City(
          name: widget.city,
          nameEn: widget.city,
          code: 'UNKNOWN',
        ),
      );

      translatedCity = city.name; // Arabic city name
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: 140.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('assets/images/prayer_timing.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 12,
            top: 6.0,
            child: Container(
              padding: const EdgeInsets.all(AppConstants.defaultPadding * .5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Text(
                '${translatedCity ?? widget.city} - ${translatedCountry ?? widget.country}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.hijriDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.gregorianDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
