#import "@preview/starter-journal-article:0.4.0": article, author-meta

#show: article.with(
  title: "The Title of Your Article",
  authors: (
    "Author One": author-meta(
      "SPB", "OTH"
    ),
    "Author Two": author-meta(
      "OTH", 
    ),
    "Author Three": author-meta(
      "OTH"
    ),
    "Author Four": author-meta(
      "OTH"
    )
  ),
  affiliations: (
    "SPB": "Sciences Po Bordeaux, 11 allée Ausone, Pessac 36000, France",
    "OTH": "Some Other Institution, 00 Sesame Street, City 12345, Country"
  ),
  abstract: [
    Write a *150–200 word abstract* summarising your research question, theoretical motivation, main variables, and expected contribution. The abstract *does not count* toward the 1500-word limit.
  ],
)

= Introduction

Introduce your research question here. Explain why it matters, provide brief context, and develop your core hypothesis.
- This section sets up the full paper. Be explicit about the causal relationship or mechanism you expect.
- Remember: *Your current milestone 3 article must remain under 1500 words, excluding the abstract.*

== Subsection: Dependent Variable (Rename this section)

Briefly introduce your dependent variable in conceptual terms.

== Subsection: Main Independent Variable (Rename this section)

Explain the main explanatory factor you expect to influence your DV.

== Subsection: Control Variables (Rename this section)

List and justify the control variables you plan to include later in the course.

= Data

Write a short paragraph describing the *ANES 2020 dataset*: what it is, why it is relevant, and how it allows you to test your hypothesis.

== Dependent Variable (Rename)

Describe the DV you selected:

- What is the variable name in the ANES dataset?
- How was it measured?
- Why is it an appropriate operationalisation of your concept?

=== IMPORTANT

- In this typst file, you need to include *a figure* visualising the DV distribution.
- The code to create the figure must be saved in a `m3-notebook.ipynb` using Python.
- Export the figure as a PNG and insert it here.
  - Make sure to look up and use the appropriate `typst` syntax to insert the figure into this document.

Write a short paragraph interpreting the distribution.

== Main Independent Variable (Rename)

Describe the main IV you selected:

- What is the variable name in the ANES dataset?
- How was it measured?
- Why is it theoretically meaningful?

=== IMPORTANT

- Include *one figure* visualising the IV distribution.
- The figure must be generated in `notebook.ipynb` using Python.
- Export the figure as a PNG and insert it here.
  - Make sure to look up and use the appropriate `typst` syntax to insert the figure into this document.

Write a short paragraph interpreting the distribution.

= Discussion

Provide a concise paragraph discussing your *preliminary findings* from exploring your variables. Mention any patterns or surprises that relate to your hypothesis.

=== IMPORTANT

- You need to cite work from your bibliography file and have your references automatically generated.
  - Use the "chicago-author-date" citation style.
  - You are responsible to look up and use the appropriate `typst` syntax to link and load your bibliography file.
- Only use parenthetical citations, and avoid using narrative citations (eg. There are risks inherent in using LLMs without verification `@richards2025llms`)
  - Parenthetical citations are the default in `typst` so you simply have to add your key (eg. `@author1234key`) at the end of the sentence.

