# SRE Assessment

This is a repository of questions that consultants running SRE assessments can use with their
clients. It can also sync with the Confluence page of your choice to maintain feature parity with
people that prefer that tool.

# How To Use

1. Create a new SRE questionnaire for your client: `scripts/create_template [CLIENT_NAME]`
   This will:

   - Create a file in `clients` named after your client (with special characters removed), and
   - Copy the questions in the `base` file into that file, with some front-matter applied for things
     like Confluence settings

2. Update the file as you see fit. Go crazy!

3. When you're happy with it, run `scripts/update_confluence [CLIENT_NAME]` to update the page in
   Confluence where these questions should live.

# Assessment Templates

- The question template is based on YAML.
- Internally, `sre-assessment` converts the template YAML into Markdown tables. This allows
  them to be renderable by GitHub and other Markdown viewers.
- `sre-assessment` then converts the Markdown tables into Confluence XHTML with
    [Showdown](https://github.com/yyang/showdown-confluence)

## Question Schema

Each question should look like this:

```yaml
questions:
  - question: Do you like cats?
    topic: Coolness
    intended_audience: Everyone
    recommended_answer: Hell yes, who doesn't?
    actual_answer: I would, but I'm allergic. :(
    explanation: Cats are awesome. If you don't like cats, why even bother?
    scores:
      - reference:
        max_score: 5.0
      - name: Consultant A
        score: 2.5
      - name: Consultant B
        score: 1.0 # laaaaaaaaaaaame
```

Note the `scores` section. Each member of an assessment team can add a score to each question based
on whatever metric suits them. `sre-assessment` will compute an average and a maturity rating from 1 to 5
based on the formula below:

```
MATURITY_RATING = ( (max_score - average_score)/max_score ) / 2
```

In this case, the `average_score` would be `1.75` and the `maturity_rating` would be a `3`.
