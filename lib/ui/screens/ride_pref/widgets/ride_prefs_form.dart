import 'package:blablacar/ui/screens/ride_pref/widgets/ride_prefs_input.dart';
import 'package:blablacar/ui/theme/theme.dart';
import 'package:blablacar/ui/widgets/actions/bla_button.dart';
import 'package:blablacar/ui/widgets/display/bla_divider.dart';
import 'package:blablacar/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void onSwitchLocation() {
    setState(() {
      if (departure != null && arrival != null) {
        final temp = departure;
        departure = arrival;
        arrival = temp;
      }
    });
  }

  void onSubmit() {
    if (departure != null && arrival != null) {
      final pref = RidePref(
        departure: departure!,
        arrival: arrival!,
        departureDate: departureDate,
        requestedSeats: requestedSeats,
      );

      Navigator.pop(context, pref);
    }
  }

  bool get isValid =>
      departure != null && arrival != null && requestedSeats > 0;

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel => departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  final now = DateTime.now();
  String get dateLabel => (departureDate.year == now.year && departureDate.month == now.month && departureDate.day == now.day)
    ? "Today" 
    : DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [ 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              RidePrefsInput(
                isInput: showDeparturePLaceHolder,
                title: departureLabel,
                leftIcon: Icons.location_on,
                onPressed: () => {},
                rightIcon: switchVisible ? Icons.swap_vert : null,
                onRightIconPressed: switchVisible ? onSwitchLocation : null,
              ),
              const BlaDivider(),

              RidePrefsInput(
                isInput: showArrivalPLaceHolder,
                title: arrivalLabel,
                leftIcon: Icons.location_on,
                onPressed: () => {},
              ),
              const BlaDivider(),

              RidePrefsInput(
                title: dateLabel,
                leftIcon: Icons.calendar_month,
                onPressed: () => {},
              ),
              const BlaDivider(),

              RidePrefsInput(
                title: numberLabel,
                leftIcon: Icons.person_outlined,
                onPressed: () => {},
              ),
            ],
          ),
        ),

        BlaButton(type: ButtonType.primary, label: "Search", onTap: onSubmit)
      ]);
  }
}
