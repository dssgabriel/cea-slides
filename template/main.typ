#import "@preview/touying:0.6.1": *
#import "@local/cea-slides:0.2.0": *

#show: cea-theme.with(
  config-info(
    // First author is considered the main author/point of contact.
    // Affiliations are automatically annotated accordingly.
    authors: (
      (
        name: "Françoise Martin",
        email: "francoise.martin@cea.fr",
        affiliations: ("CEA/DRF, Saclay, France", ),
      ),
    ),
    title: [An Engaging Presentation Title],
    subtitle: [With an intriguing subtitle],
    short-title: [A catchy short title],
    conference: [CEA workshop],
    date: datetime.today(),
  ),
)

#title-slide()

#outline-slide()

= Section

== Slide

1. Pose the question that the presentation will aim to answer.
2. Determining what problem is to be solved.
3. Investigate potential ways to solve the problem.
4. Develop enough of a concrete artifact to evaluate ideas.
5. Making a decision as to a technical direction.
6. Actively build!
7. Confirm that the built artifact is functional.
8. Operate the built artifact at sufficient load to break it.
9. Ship and deploy the built artifact.

#end-slide()
