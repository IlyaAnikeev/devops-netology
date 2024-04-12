#!/usr/bin/env python

import sentry_sdk

sentry_sdk.init(
    dsn="https://d14ed51ed3cf469459da9a6c80f7fe82@o4507049682403328.ingest.us.sentry.io/4507072067272705",
    traces_sample_rate=1.0,
    profiles_sample_rate=1.0,
    environment="development",
    release="1.0.0" 
)

cook_book = [
  ['салат',
      [
        ['картофель', 100, 'гр.'],
        ['морковь', 50, 'гр.'],
        ['огурцы', 50, 'гр.'],
        ['горошек', 30, 'гр.'],
        ['майонез', 70, 'мл.'],
      ]
  ],
  ['пицца',
      [
        ['сыр', 50, 'гр.'],
        ['томаты', 50, 'гр.'],
        ['тесто', 100, 'гр.'],
        ['бекон', 30, 'гр.'],
        ['колбаса', 30, 'гр.'],
        ['грибы', 20, 'гр.'],
      ],
  ],
  ['фруктовый десерт',
      [
        ['хурма', 60, 'гр.'],
        ['киви', 60, 'гр.'],
        ['творог', 60, 'гр.'],
        ['сахар', 10, 'гр.'],
        ['мед', 50, 'мл.'],
      ]
  ]
]
person = int(input('Введите количество персон для банкета: '))
print()

for dish, ingredients in cook_book:
    print(f'{dish.capitalize()}:')
    for ingredient in ingredients:
        ingredient_name = ingredient[0]
        ingredient_weight = ingredient[1]*person
        ingredient_measure = ingredient[2]
        print(f'{ingredient_name}, {ingredient_weight}{ingredient_measure}')
    print()