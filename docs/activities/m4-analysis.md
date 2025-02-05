# Milestone 4: The Update

Welcome to Milestone 4 The Update! In this milestone, you will advance your skills by learning about professional-grade coding and publishing tools and techniques. By the end of this milestone, you will have refined your data analysis project into a more polished, publishable format.

From now on, we will host the remainder of the paper & code on GitHub and rely on Visual Studio Code (VSCode) as our primary coding and writing platform.

## Objectives

- Convert existing Google Notebooks to Markdown files with proper citations.
- Export and integrate figures from your previous milestones into a paper.
- Update and refine your Dependent Variable (DV) and Independent Variable (IV).

## Link to the Milestone

- [Follow this link](XXX)

## Step-by-Step Guide

### 1. Convert Notebooks to Markdown

- **Copy existing markdown contents:**
    - Open your previous milestone notebook (M3) and extract only the content from the Markdown cells, then seamlessly integrate this content into your `paper.md` file.

- **Update Citations**:
    - Integrate all references into the `references.bib` file in the `bibtex` format. This allows for efficient management and organization of references in your paper. Note that the citation keys you define in the `.bib` file enable streamlined referencing
    - Update all citation both in-text and narrative citations within your analysis. Use `[@somepaper]` will create a parenthetical in-text citation, while `@someotherpaper` allows for a narrative citation that seamlessly integrates the author into the text. 
    - This approach not only enhances the readability and professionalism of your document but also ensures adherence to academic standards and consistency across your work. By leveraging these citation methods, you can efficiently reference literature, thereby strengthening the scholarly foundation of your political science analysis.

### 2. Generate and Include Images

- **Export Visualizations**: 
    - Use Matplotlib to export/save the images from your latest milestone into the dedicated `imgs` folder.
        ```python
        import matplotlib.pyplot as plt
        plt.savefig("imgs/your-image-name.png")

        ```

    - Embed Images in your Markdown document using appropriate Markdown syntax:

        ```markdown
        ![Description of Your Image](imgs/image-name.png)
        ```

### 3. Refine Variables

- **Update DV and IV**: Reassess your Dependent Variable (DV) and Independent Variables (IV) based on feedback and further research. 
    - Include a relevant figure that illustrates the relationship between your DV (y-axis) and IV (x-axis)


## Expected Deliverable

- A polished pdf file resulting from compiling the `paper.md` file using VSCode. This updated paper, contains your latest version of the paper, including automatic citations and embedded images.

## Conclusion

By completing this milestone, you will enhance your ability to present data analysis in a professional format, making your work suitable for publication or presentation. Embrace these tools and techniques in this class and beyond.

