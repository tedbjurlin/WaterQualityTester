/// A range-based standard for determining the validity of measurements of a
/// given chemical.
class ChemicalStandard {
  const ChemicalStandard({
    required this.name,
    required this.lo,
    required this.hi,
    required this.description,
    this.units,
  });

  /// The chemical name for this standard, e.g. 'Lead' or 'pH'.
  final String name;

  /// The range of values accepted by this standard.
  ///
  /// Any chemical measurement (measured in the appropriate [units]) less than
  /// [lo] or greater than [hi] is considered invalid by this standard.
  final double lo, hi;

  /// A detailed description/explanation of this standard.
  final String? description;

  /// The units of measurement in use.
  ///
  /// If left `null`, then it is assumed that no units are necessary, such as
  /// for pH.
  final String? units;

  /// Returns `true` if [value] is within the acceptable range for this
  /// standard (inclusive of endpoints).
  ///
  /// Assumes that the given value is measured in the correct [units].
  bool isValueInRange(double value) => value >= lo && value <= hi;
}

/// The EPA drinking water standards for each of the chemicals tested by the
/// app.
///
/// Ranges and descriptions come from the Varify EPA Standards Reference Sheet,
/// which can be found in the assets folder at `assets/EPA Standards Reference
/// Sheet.pdf`.
final epaStandards = List<ChemicalStandard>.unmodifiable(const [
  ChemicalStandard(
    name: "pH",
    lo: 6.5,
    hi: 8.5,
    description: "EPA recommended limit: 6.5 - 8.5\n\n"
        "Water with a pH lower than 7 is considered acidic, and water with a "
        "pH above 8.5 is considered basic. A pH of 7 is considered pure, and a "
        "range of 6.5 to 8.5 is recommended.",
  ),
  ChemicalStandard(
    name: "Hardness",
    units: "mg/L",
    lo: 0.0,
    hi: 425.0,
    description: "EPA recommended limit: 425 mg/L\n\n"
        "Hardness is the amount of dissolved calcium and magnesium. Soft water "
        "can cause corrosion of your plumbing and appliances. Hard water can "
        "cause residue buildup and difficulties using soap.",
  ),
  ChemicalStandard(
    name: "Hydrogen Sulfide",
    units: "mg/L",
    lo: 0.0,
    hi: 0.0,
    description: "EPA recommended limit: 0 mg/L\n\n"
        "Hydrogen Sulfide gas occurs naturally in some groundwater through "
        "decomposing organic matter such as plant decay. Drinking water with "
        "high levels of hydrogen sulfide produces a pungent rotten egg smell. "
        "This can lead to nausea and stomach pain.",
  ),
  ChemicalStandard(
    name: "Iron",
    units: "mg/L",
    lo: 0.0,
    hi: 0.3,
    description: "EPA recommended limit: 0.3 mg/L\n\n"
        "Iron is a naturally occuring mineral that can enter your well water "
        "through surrounding soil. It does not pose a threat to your health, "
        "but can cause various complications with your appliances.",
  ),
  ChemicalStandard(
    name: "Copper",
    units: "mg/L",
    lo: 0.0,
    hi: 1.0,
    description: "EPA recommended limit: 1.3 mg/L\n\n"
        "Copper can enter your drinking water through corrosion of pipes or "
        "direct contamination. High levels can cause nausea, vomiting, and "
        "diarrhea.",
  ),
  ChemicalStandard(
    name: "Lead",
    units: "mg/L",
    lo: 0.0,
    hi: 15.0,
    description: "EPA recommended limit: 15 mg/L\n\n"
        "Lead can enter drinking water when your plumbing that contains lead "
        "corrodes. Corrosion of pipes can be caused by acidic water (low pH). "
        "Side effects include damage to the nervous system, infertility, and "
        "decreased kidney function.",
  ),
  ChemicalStandard(
    name: "Manganese",
    units: "mg/L",
    lo: 0.0,
    hi: 0.1,
    description: "EPA recommended limit: 0.1 mg/L\n\n"
        "Manganese occurs naturally in surface water, although human "
        "activities are also responsible for manganese in drinking water. "
        "Possible side effects are stained clothes/appliances and nerve "
        "damage.",
  ),
  ChemicalStandard(
    name: "Total Chlorine",
    units: "mg/L",
    lo: 0.0,
    hi: 3.0,
    description: "EPA recommended limit: 3 mg/L\n\n"
        "Chlorine is added to drinking water to kill disease causing "
        "pathogens. Total chlorine is the amount of Free Chlorine + Used "
        "Chlorine (Chloramines) in your water. Nausea, diarrhea, and vomiting "
        "are common side effects of ingesting too much chlorine.",
  ),
  ChemicalStandard(
    name: "Mercury",
    units: "mg/L",
    lo: 0.0,
    hi: 0.002,
    description: "EPA recommended limit: 0.002 mg/L\n\n"
        "Mercury is a natrually occuring element that occurs from the "
        "degassing of the earth's crust. High levels can cause kidney damage.",
  ),
  ChemicalStandard(
    name: "Nitrate",
    units: "mg/L",
    lo: 0.0,
    hi: 10.0,
    description: "EPA recommended limit: 10 mg/L\n\n"
        "Nitrate is one of the most common groundwater contaminants in "
        "drinking water. It most commonly comes from fertilizer runoff. Excess "
        "amounts can cause blue baby disease - a lack of oxygen to the brain.",
  ),
  ChemicalStandard(
    name: "Nitrite",
    units: "mg/L",
    lo: 0.0,
    hi: 1.0,
    description: "EPA recommended limit: 1 mg/L\n\n"
        "Nitrites come from fertilizers through the runoff of water and sewage "
        "deposits. They can stimulate the growth of harmful bacterias.",
  ),
  ChemicalStandard(
    name: "Sulfate",
    units: "mg/L",
    lo: 0.0,
    hi: 200.0,
    description: "EPA recommended limit: 200 mg/L\n\n"
        "Sulfate is naturally occuring in the earth's sediment and can cause a "
        "laxative effect, as well as clogged plumbing.",
  ),
  ChemicalStandard(
    name: "Zinc",
    units: "mg/L",
    lo: 0.0,
    hi: 5.0,
    description: "EPA recommended limit: 5 mg/L\n\n"
        "Zinc is an essential nutrient for our bodies, usually introduced into "
        "water by products such as steel production. However, exposure to high "
        "levels can lead to stomach cramps, nausea, and vomiting.",
  ),
  ChemicalStandard(
    name: "Flouride",
    units: "mg/L",
    lo: 0.0,
    hi: 4.0,
    description: "EPA recommended limit: 4 mg/L\n\n"
        "Flouride is a natural compound found in many rocks and is added to "
        "public water sources to prevent cavities. Groundwater can contain "
        "high levels of flouride, which can cause dental flourosis and thyroid "
        "problems.",
  ),
  ChemicalStandard(
    name: "Sodium Chloride",
    units: "mg/L",
    lo: 0.0,
    hi: 250.0,
    description: "EPA recommended limit: 250 mg/L\n\n"
        "Sodium Chloride increases the electrical conductivity of water and "
        "thus increases its corrosivity. In metal pipes, chloride reacts with "
        "metal ions to form soluble salts, thus increasing levels of metals in "
        "drinking-water.",
  ),
  ChemicalStandard(
    name: "Total Alkalinity",
    units: "mg/L",
    lo: 40.0,
    hi: 180.0,
    description: "EPA recommended limit: 40 - 180 mg/L\n\n"
        "Alkalinity is the level of dissolved minerals in your water that help "
        "neutralize acidity. Water with low levels of alkalinity is more "
        "likely to be corrosive, and high levels can cause scaling.",
  ),
]);
