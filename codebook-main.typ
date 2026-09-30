#let code_default_size = 7pt
#let code_default_lh = 4.61pt

#let include_dir = "src/"

#let measure_raw(body) = context {
  set text(size: code_default_size)
  let size = measure(body)
  [#size.height]
}

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
  set raw(tab-size: 4)
  let actual_len = content.text.split("\n").len()
  block(
    fill: luma(240),
    inset: 6pt,
    radius: 2pt,
    above: 6pt,
    width: 99%,
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
        //align: (col, _) => align.at(col),
        align: (top + right, auto),
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

#let get_lang(
  file_name
) = {
  let got_file = file_name
  let lang_type = ""
  for i in str(got_file).rev() {
    if (i == ".") { break }
    lang_type += i 
  }
  lang_type = lang_type.rev()
  if lang_type == "cpp" or lang_type == "hpp" { lang_type = "cpp" }
  else if lang_type == "c" or lang_type == "h" { lang_type = "c" }
  else if lang_type == ".vimrc" { lang_type = "vim" }
  return lang_type
}


#let codebook(team: (), source_path: "") = {
  set document(author: team.team_members, title: "ICPC Codebook - " + team.team_name)
  show outline.entry: it => link(
    it.element.location(),
    it.indented(it.prefix(), it.inner())
  )
  set heading(numbering: "1.", )
  show heading: set block(below: 6pt)

  set page(columns: 1)
  format_title_page(team: team)

  set page(margin: 0.5cm, columns: 2)
  set columns(gutter: 0.5pt)
  outline()

  set page(margin: 0.5cm, columns: 2) 
  set columns(gutter: 0.5pt)

  // show raw: set text(size: code_size)
  //show raw: set text(size: code_default_size)

  set heading(numbering: "1.", )
  show heading: set block(below: 6pt, above: 8pt)
  
  let in_yaml = yaml("config.yaml") 
  for (main_name, main_items) in in_yaml {
    for (chapter_name, chapter_items) in main_items {
      line(length: 100%)
      heading(str(chapter_name), level: 1)
      for (section_name, section_items) in chapter_items {
        heading(str(section_name), level: 2)
        if type(section_items) == dictionary {
          for (subsection_name, subsection_items) in section_items {
            heading(str(subsection_name), level: 3)
            let got_file = subsection_items.at(0)
            let temp = raw(read(include_dir + got_file), lang: get_lang(got_file))
            text(code(temp))
          }
        }
        else {
            let got_file = section_items.at(0)
            let temp = raw(read(include_dir + got_file), lang: get_lang(got_file))
            text(code(temp))
        }
      }
    }
  }

  // If changing code font size, please run following function to get 
  // new font height for empty line
  //
  //set text(size: code_default_size)
  //measure_raw[raw("test")]

}
