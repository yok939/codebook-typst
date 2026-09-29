#import "@preview/zebraw:0.6.3": *
#import "codebook-main.typ": *
#import "codebook-overwrite.typ": *


#let local_team = setup_team(
  team_name: "yokAndHisBuddies", 
  team_members: ("James Hong (yok939)", ), 
  team_institution: "National Taiwan Ocean University"
)

#codebook(team: local_team)
