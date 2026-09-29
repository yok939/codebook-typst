#let code_default_size = 7.2pt
#let code_default_lh = 5.47pt

#let code(
  font_size: code_default_size,
  numbers: true,
  stepnumber: 1,
  numberfirstline: false,
  numberstyle: auto, 
  firstnumber: 1,
  content
) = {
  show raw: set text(size: font_size)

  block(
    fill: luma(240),
    inset: 6pt,
    radius: 2pt,
    width: 100%,
    clip: false,
    {
      //Number of lines counter
      let (columns, align, make_row) = {
        if numbers {
          ( ( auto, 1fr ),
            ( right + horizon, left ),
            e => {
              let (i, l) = e
              let n = i + firstnumber
              let n_str = if (calc.rem(n, stepnumber) == 0) or (numberfirstline and i == 0) { 
                numbering("1", n)
              } 
              else {
                "" 
              }
              (raw(n_str) + h(.5em), raw(lang: content.lang, l))
            }
          )
        }
        else {
          ( ( 1fr, ),
            ( left, ),
            e => {
              let (i, l) = e
              raw(lang: content.lang, l)
            }
          )
        }
      }

      //Finalization
      table(
        stroke: none,
        columns: columns,
        rows: (auto, ),
        gutter: 0pt,
        inset: 2pt,
        align: (col, _) => align.at(col),
        ..content
          .text
          .split("\n")
          .enumerate()
          .map(make_row)
          .flatten()
          .map(c => if c.has("text") and c.text == "" { v(code_default_lh) } else { c })
      )
    }
  )
}


// Team dictionary creation
#let setup_team(team_name: "", team_members: (), team_institution: "") = {
  let team = (
    team_name: "Team", 
    team_members: ("Member 1", "Memeber 2", "Member 3"),
    team_institution: "Foobar School"
  )
  team.team_name = team_name
  team.team_members = team_members
  team.team_institution = team_institution
  return team
}

// Front page formatting
#let format_title_page(team: ()) = {
  let formatted_members = ""
  for members in team.team_members {
    if not formatted_members.len() == 0 {
      formatted_members += ", "    
    } 
    formatted_members += members
  }


  set align(center + top)
  set text(15pt) 
  str(team.team_institution)
  linebreak()
  set text(12pt) 
  str("ICPC Codebook")

  v(5cm)
  set text(25pt)
  str(team.team_name) 
  linebreak()
  set text(15pt) 
  str(formatted_members) 

  set align(center + bottom)
  datetime.today().display("[month repr:long] [day], [year]")

  pagebreak()
}

#let codebook(team: (), source_path: "") = {
  set document(author: team.team_members, title: "ICPC Codebook - " + team.team_name)
  set page(columns: 1)
  format_title_page(team: team)

  set page(margin: 0.5cm, columns: 2) 
  set columns(gutter: 0.5pt)

  // show raw: set text(size: code_size)
  //show raw: set text(size: code_default_size)
  code(```cpp
  #include <iostream>

  int main()
  {
      std::cout << "Hello NTOU!\n";

      int n;
      std::cin >> n;
      for(int i = i; i <= n; i++)
      {
          cout << i << '\n';
      }
  }
  ```)
}
