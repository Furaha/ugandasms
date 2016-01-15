Question.create!([
  { title: "Which Insect Spreads Malaria?", campaign_id: Campaign.find_by(title: "Malaria Campaign").id}
])

Option.create!([
  { title: "house fly", question_id: Question.find_by(title: "Which Insect Spreads Malaria?").id},
  { title: "mosquito", question_id: Question.find_by(title: "Which Insect Spreads Malaria?").id}
])