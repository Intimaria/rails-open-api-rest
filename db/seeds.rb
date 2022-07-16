# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Api::V1::Todo.destroy_all

todos = Api::V1::Todo.create([{
    task: 'comprar pan',
    done: false,
    due_by: Date.today,
    owner: "google-oauth2|111035368809348208211"
},
{
    task: 'ir a la facultad',
    done: false,
    due_by: Date.today + 7,
    owner: "google-oauth2|111035368809348208211"
},
{
    task: 'pagar expensas',
    done: false,
    due_by: Date.today + 2,
    owner: "ggoogle-oauth2|109020883778282245656"
},
{
    task: 'hacer curso de trabajo',
    done: true,
    due_by: Date.today - 2,
    owner: "google-oauth2|109020883778282245656"
}])