# Introduction

## Agenda
- [ ] Getting to know each other
- [ ] The Syllabus
- [ ] Science ?
- [ ] Hack-time
    - Groups & Planning
    - LLMs, VS Code, Typst, Git/GitHub...
    - Getting started with Milestone 1
- [ ] For next time
    - Finish Milestone 1

---

## Science & The Scientific Method

![](../images/coffee.jpg){: style="height:175px" align=right}

1. Goal is inference: We seek to learn about the world from data.
2. Procedures are public: Methods and materials should be transparent and reproducible.
3. Conclusions are uncertain: We quantify uncertainty and avoid overclaiming.
4. The content is the method: The contribution lies in clear, defensible procedures.

### [Is a literature review a contribution?](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/00B62000B6760AB78E1BD27E32A94C9F/S1049096506060264a.pdf/doing-a-literature-review.pdf?casa_token=szUhrJK1G30AAAAA:yj5nqRIULvP0oFEmACEq9AkAIZPdF8YBt9xWDetabQJwdKzVTZQ3yZvbGszZMNoesDnYgFtim2AA)


# A Cutting-Edge Toolbox

!!! warning inline end 

    **Getting started is the hardest part!** Setting up your tools is tedious, but once everything is in place, your research workflow will continuously improve, and will can elevate your work to new highs. Invest the effort now, and your future self will thank you!

## :fontawesome-solid-wand-magic-sparkles: A quick word about ChatGPT and other LLMs 

### What are they? What is the intuition behind it? 

ChatGPT is a Large Language Model (LLM) designed to generate human-like text based on the input it receives. It is part of the GPT (Generative Pre-trained Transformer) family of models and relying on deep learning algorithms to generate coherent and contextually relevant responses in a conversational format.

- [The intuition behind word embeddings](https://www.cs.cmu.edu/~dst/WordEmbeddingDemo/)
- [The intuition behind LLM's](https://ig.ft.com/generative-ai/)

![](https://upload.wikimedia.org/wikipedia/commons/a/a3/Gradient_descent.gif)

### Using LLMs as a learning tool
1. **Ask Open-Ended Questions**: Instead of seeking direct answers, pose open-ended questions that encourage exploration of concepts. For example, ask, *"What factors influence voter behavior in elections?" to gain a deeper understanding of political behavior.*

2. **Request Explanations and Summaries**: Use ChatGPT to explain complex topics in simpler terms or to summarize articles and books. For instance, you might ask, "Can you summarize the main theories of public opinion formation?" to clarify your understanding of how public opinion is shaped.

3. **Engage in Discussion**: Treat your interaction as a conversation. Ask follow-up questions, such as, "How do social media platforms impact public opinion during elections?" This encourages critical thinking and helps you explore the nuances of political behavior.

4. **Seek Practical Examples**: When learning new concepts, ask for real-world applications or examples. You could inquire, "Can you provide examples of how political campaigns have successfully influenced public opinion?" This contextualizes your knowledge and makes it more relatable.

5. **Reflect and Review**: After receiving information, take time to reflect on what you've learned. For example, summarize the key factors that affect public opinion in your own words, or discuss with ChatGPT how these factors might apply to current political events to solidify your understanding.

## Other Tools: What They Are & Why They Matter

### Hacking with **:fontawesome-solid-laptop-code: VS Code**

VS Code is a free code editor that helps you write and organize your project files in one place. Beyond coding, you can use it to manage documents, run scripts, and integrate extensions for Python, Git, Typst, and more, essentially making it your all-in-one research workspace.

### Collaborating on **:fontawesome-brands-github: GitHub**

Git provides version control to track changes to your files, while GitHub hosts your projects online, making it easy to share, collaborate, and back up your work. Using Git and GitHub ensures reproducibility, maintains a history of your work, and simplifies collaboration with anyone around the globe.

### Writing with **:fontawesome-solid-quote-left: Typst**

Typst is a lightweight, open-source tool for creating clean, formatted documents. Think of it as a text editor made for Scientific papers, notes, or reports which include figures, citations, or even math. Combined with Git, your research becomes reproducible, versionable, and easy to manage.


# Hack-Time: Setup + Your First Lines of Code 

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

## Put your paper on GitHub
- In GitHub 
  - Create a new public or private repository.
  - Upload the pdf.
  - Add a commit changes: “My first commit, horray!”
  - Push your changes to GitHub.

## Package Manager Setup:  
- This will make installing software much easier!
    - **Windows**: [Chocolatey](https://chocolatey.org/install)  
    - **Mac**: [Homebrew](https://brew.sh/)  
    - **Linux**: You already have a package manager (e.g., `apt`, `dnf`, `pacman`).  
- Can you install :fontawesome-brands-python: Python using your package manager ?

![This is Fine...](../images/fine.jpg)

---


### The Assignment 

<!-- TODO: Add COX article about 5 questions! [--](--.md)-->
- [**Getting started with Assignments (Milestones)**](/activities/challenges.md)
- :fontawesome-solid-award: Link to [**Milestone 1**](https://colab.research.google.com/github/mickaeltemporao/data-analysis/blob/main/materials/assignment-1.ipynb)
- Google Scholar & Annual Reviews

## For next time
- :fontawesome-solid-award: **Complete** [**Milestone 1**](https://colab.research.google.com/github/mickaeltemporao/data-analysis/blob/main/materials/assignment-1.ipynb)
- :fontawesome-solid-book: Mandatory Reading, Reading Note & Presentation
    - [Dassonneville, R., & McAllister, I. (2018). Gender, political knowledge, and descriptive representation: The impact of long‐term socialization. American Journal of Political Science, 62(2), 249-265.](https://onlinelibrary.wiley.com/doi/epdf/10.1111/ajps.12353)
- :fontawesome-solid-house-laptop: Recommended Practice
    - [:fontawesome-brands-markdown: Markdown Tutorial](https://commonmark.org/help/tutorial/)
    - [:fontawesome-solid-file-code: Python Exercises](https://www.hackinscience.org/exercises/)



## For next time
- :fontawesome-solid-award: **Complete** [**Milestone 1**](https://colab.research.google.com/github/mickaeltemporao/data-analysis/blob/main/materials/assignment-1.ipynb)
- :fontawesome-solid-book: Mandatory Reading, Reading Note & Presentation
    - [Dassonneville, R., & McAllister, I. (2018). Gender, political knowledge, and descriptive representation: The impact of long‐term socialization. American Journal of Political Science, 62(2), 249-265.](https://onlinelibrary.wiley.com/doi/epdf/10.1111/ajps.12353)
- :fontawesome-solid-house-laptop: Recommended Practice
    - [:fontawesome-brands-markdown: Markdown Tutorial](https://commonmark.org/help/tutorial/)
    - [:fontawesome-solid-file-code: Python Exercises](https://www.hackinscience.org/exercises/)

- :fontawesome-solid-brain: Start thinking about a topic/concept that your group might be interested in and consider how it can impact citizens' political attitudes and behaviors in the context of electoral campaigns.
    - Looking for inspiration? Check published "Journal Articles" in the [ANES Bibliography](https://electionstudies.org/papers-documents/anes-bibliography/)

