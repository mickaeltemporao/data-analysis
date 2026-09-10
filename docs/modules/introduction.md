# Introduction

## Getting to know each other

Welcome to **Data Analysis in Political Science**! We'll start our first session by getting to know one another:

- Who you are and what topics in politics, society, or public policy fascinate you.
- Your prior experience (if any) with data, statistics, or programming. (No prior coding experience is required!)
- What you hope to build or investigate in your research project this year.

---

## The Syllabus

We will walk through the core structure, expectations, and roadmap of the course:

- **Structure:** 12 bi-weekly class meetings across two semesters (Fridays 08:00–11:15 in Salle A.116 Laboratoire).
- **Evaluation Breakdown:**
    - :fontawesome-solid-award: **50% Milestones:** 5 cumulative milestones (10% each) building your empirical research step-by-step.
    - :fontawesome-solid-chalkboard-user: **30% Participation:** Student Group Live Demos (2 per group), peer discussion ("I like, I wish, I wonder"), and class engagement.
    - :fontawesome-regular-file-code: **20% Research Paper:** An original, fully reproducible empirical paper (~4,000–5,000 words in Typst).
- Review the full course policies, objectives, and communication guidelines on the [📘 **Syllabus**](../syllabus.md).

---

## A Quick Word About LLMs (ChatGPT, Claude, Gemini, ...)

### What are they? What is the intuition behind it? 

ChatGPT is a Large Language Model (LLM) designed to generate human-like text based on the input it receives. It is part of the GPT (Generative Pre-trained Transformer) family of models and relies on deep learning algorithms to generate coherent and contextually relevant responses in a conversational format.

- [The intuition behind word embeddings](https://www.cs.cmu.edu/~dst/WordEmbeddingDemo/)
- [The intuition behind LLMs](https://ig.ft.com/generative-ai/)

![](https://upload.wikimedia.org/wikipedia/commons/a/a3/Gradient_descent.gif)

### Using LLMs as a learning tool

1. **Ask Open-Ended Questions**: Instead of seeking direct answers, pose open-ended questions that encourage exploration of concepts. For example, ask, *"What factors influence voter behavior in elections?"* to gain a deeper understanding of political behavior.
2. **Request Explanations and Summaries**: Use LLMs to explain complex topics in simpler terms or to summarize articles and books. For instance, you might ask, *"Can you summarize the main theories of public opinion formation?"* to clarify your understanding of how public opinion is shaped.
3. **Engage in Discussion**: Treat your interaction as a conversation. Ask follow-up questions, such as, *"How do social media platforms impact public opinion during elections?"* This encourages critical thinking and helps you explore the nuances of political behavior.
4. **Seek Practical Examples**: When learning new concepts, ask for real-world applications or examples. You could inquire, *"Can you provide examples of how political campaigns have successfully influenced public opinion?"* This contextualizes your knowledge and makes it more relatable.
5. **Reflect and Review**: After receiving information, take time to reflect on what you've learned. For example, summarize the key factors that affect public opinion in your own words, or discuss with the LLM how these factors might apply to current political events to solidify your understanding.

---

## Science & The Scientific Method

![](../images/coffee.jpg){: style="height:175px" align=right}

1. **Goal is inference**: We seek to learn about the world from data.
2. **Procedures are public**: Methods and materials should be transparent and reproducible.
3. **Conclusions are uncertain**: We quantify uncertainty and avoid overclaiming.
4. **The content is the method**: The contribution lies in clear, defensible procedures.

### [Is a literature review a contribution?](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/00B62000B6760AB78E1BD27E32A94C9F/S1049096506060264a.pdf/doing-a-literature-review.pdf?casa_token=szUhrJK1G30AAAAA:yj5nqRIULvP0oFEmACEq9AkAIZPdF8YBt9xWDetabQJwdKzVTZQ3yZvbGszZMNoesDnYgFtim2AA)

---

## A Cutting-Edge Toolbox

!!! warning inline end 

    **Getting started is the hardest part!** Setting up your tools is tedious, but once everything is in place, your research workflow will continuously improve and can elevate your work to new heights. Invest the effort now, and your future self will thank you!

### Writing with **:fontawesome-solid-quote-left: Typst**

Typst is a lightweight, open-source tool for creating clean, formatted documents. Think of it as a text editor made for scientific papers, notes, or reports which include figures, citations, or even math. Combined with Git, your research becomes reproducible, versionable, and easy to manage.

### Hacking with **:fontawesome-solid-laptop-code: VS Code**

VS Code is a free code editor that helps you write and organize your project files in one place. Beyond coding, you can use it to manage documents, run scripts, and integrate extensions for Python, Git, Typst, and more, essentially making it your all-in-one research workspace.

### Collaborating on **:fontawesome-brands-github: GitHub**

Git provides version control to track changes to your files, while GitHub hosts your projects online, making it easy to share, collaborate, and back up your work. Using Git and GitHub ensures reproducibility, maintains a history of your work, and simplifies collaboration with anyone around the globe.

---

## Hack-Time

![This is Fine...](../images/fine.jpg)

### First lines of code in Typst

Since we will use Typst from Day 1 for scientific writing and all milestone submissions, let's create your first document and try adding a citation!

1. Create a document named `paper.typ` on [Typst](https://typst.app/):

```typst
= Political Behavior & Public Opinion

This document was produced with Typst.
According to @dassonneville2018gender, political knowledge is shaped by early socialization.

#bibliography("references.bib")
```

2. Check the [📚 Guide to Academic Citations in Typst](../resources/writing.md#academic-citations-in-typst) to see how `.bib` files work.
3. Export and compile your document to PDF (`paper.pdf`).

### Automated Environment Setup

Follow the automated setup scripts on the [:fontawesome-regular-paper-plane: **Onboarding**](../resources/onboarding.md) page to install VS Code, Python, the Jupyter extensions, and data science libraries on your computer with a single command.

### The Assignment 

- [Getting started with Assignments (Milestones)](../activities/challenges.md)
- :fontawesome-solid-award: Link to [**Milestone 1**](../activities/milestone-1.md)
- Use [Google Scholar](https://scholar.google.com/), [Cairn](https://www.cairn.info/), or [Annual Reviews](https://www.annualreviews.org/) to identify scientific articles.
- Check [The “Big 5” and Other Ideas* For Presentations](https://econ.lse.ac.uk/staff/spischke/phds/The%20Big%205.pdf), especially the Big 5 questions on page 5 & 6 to help you prepare your paragraph & presentations.

---

## **Get Ready for Next Week: Think. Read. Practice.**

:fontawesome-solid-brain: **Thinking Ahead**

- What are the key concepts in your project idea (your Milestone 1)

:fontawesome-solid-book: **Mandatory Reading, Reading Note & Presentation**

- [Dassonneville, R., & McAllister, I. (2018). Gender, political knowledge, and descriptive representation: The impact of long‐term socialization. American Journal of Political Science, 62(2), 249-265.](https://onlinelibrary.wiley.com/doi/epdf/10.1111/ajps.12353)

:fontawesome-solid-house-laptop: **Practice**

- :fontawesome-solid-award: **Complete** [**Milestone 1**](../activities/milestone-1.md) (Due Friday, Sep 25 at 08:00)
