# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Api::V1::Todo.destroy_all

todos = Api::V1::Todo.create([{
    task: 'comprar seven up',
    done: false,
    due_by: Date.today,
},
{
    task: 'devolver tuper',
    done: false,
    due_by: Date.today + 7,
},
{
    task: 'pagar alquiler',
    done: false,
    due_by: Date.today + 2,
},
{
    task: 'hacer tarea',
    done: true,
    due_by: Date.today - 2,
}])