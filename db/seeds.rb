# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

questions = [
  { statement: 'Little interest or pleasure in doing things', severe: false },
  { statement: 'Feeling down, depressed, or hopeless', severe: false },
  { statement: 'Trouble falling or staying asleep, or sleeping too much', severe: false },
  { statement: 'Feeling tired or having little energy', severe: false },
  { statement: 'Poor appetite or overeating', severe: false },
  { statement: 'Feeling bad about yourself or that you are a failure or have let yourself or your family down', severe: false },
  { statement: 'Trouble concentrating on things, such as reading the newspaper or watching television', severe: false },
  { statement: 'Moving or speaking so slowly that other people could have noticed. Or the opposite being so figety or restless that you have been moving around a lot more than usual', severe: false },
  { statement: 'Thoughts that you would be better off dead, or of hurting yourself', severe: true }
]

# Create questionnaires
questionnaire = Questionnaire.find_or_create_by!(name: 'PHQ-9')

# Create Questions and associate them with the Questionnaire
questions.each_with_index do |question, index|
  question = Question.find_or_create_by!(question_statement: question[:statement], severe: question[:severe])
  QuestionnaireQuestion.find_or_create_by!(questionnaire:, question:, order: index)
end

puts 'Seeding completed successfully.'
