Item.destroy_all
Category.destroy_all
Cart.destroy_all
User.destroy_all
LineItem.destroy_all

10.times do
  Item.create(
    title: Faker::Commerce.product_name,
    inventory: Faker::Number.number(2),
    price: Faker::Number.number(4)
  )
  Category.create(title: Faker::Commerce.department)
end

counter = 1
Item.all.each do |item|
  item.category_id = counter
  item.save
  counter += 1
  Category.all[0].items << item
end

Category.all[1].items << Item.all[0]
Category.all[1].items << Item.all[1]
Category.all[1].items << Item.all[2]


User.create(:email => "test@test.com", password: "testtest")
