# Writing

## Guidelines
- **1 page** = Roughly 5 paragraphs.
- **1 paragraph** = Roughly 5 sentences = 1 idea.
    - The first sentence in a paragraph introduces the idea.
    - Followed by three sentences written has arguments supporting the idea.
    - The last sentence concludes the idea.
- **1 sentence** = Roughly 20 words.

## typst

Typst is a lightweight, open-source tool for creating clean, formatted documents. Think of it as a text editor made for Scientific papers, notes, or reports which include figures, citations, or even math. Combined with Git, your research becomes reproducible, versionable, and easy to manage.

## First Typst document
- Create a document named `paper.typ` with the following contents:

```
= Some Random Text

This document was produced with Typst.
We computed the average penguin body mass by species. See the figure below.
#image("find_some_figure.png", width: 80%)
```
- Compile (export as pdf).

You should get paper.pdf.

## 📚 Academic Citations in Typst

When writing academic papers, it is essential to cite your sources properly. Typst makes this easy by allowing you to manage references with a **BibTeX file** (`.bib`).  

A `.bib` file is simply a text file that stores bibliographic information (author, title, year, publisher, etc.) in a structured format. Each entry has a unique **key** that you use to cite the work in your document.

### 1. Create a `.bib` file from Google Scholar
1. Go to [Google Scholar](https://scholar.google.com).  
2. Search for an article or book you want to cite.  
3. Under the result, click **“Cite”** (the quotation mark icon).  
4. In the popup, click **“BibTeX”** → copy the text.  
5. Paste it into a text file (e.g., `refs.bib`).  

**Example entry in `refs.bib`:**

```bibtex
@book{putnam1994making,
  title={Making Democracy Work: Civic Traditions in Modern Italy},
  author={Putnam, Robert D. and Leonardi, Robert and Nanetti, Raffaella Y.},
  year={1994},
  publisher={Princeton University Press}
}
```

Here, the key is `putnam1994making`, that is the text right after the `{`. This the key you use to make citations and give credit to the original source.

### 2. Cite Sources  in Typst
To use your new `.bib` file in a Typst document (`.typ`), you need to **link** the typst document with your references file. You can do so by including the following line, adjusted for the name of your reference file (in this example `refs.bib`):

```
#bibliography("refs.bib")
```

Then, you can cite the book or article in your typst document using the `@key` like this:

```
Civic traditions strongly shape institutional performance @putnam1994making.
```
At the end of your document, Typst will automatically generate a bibliography using the entries in .bib file:

You can also change citation style to suit your submission requirements.

```
#bibliography("refs.bib", style: "chicago-author-date")
```
