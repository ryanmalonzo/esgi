# MongoDB Exercices séance 1

## Collections : Sakila_films

### Exercice 1

Rechercher tous les films dont la description comprend "documentary" et de catégorie "horror"

```js
db.Sakila_films.find({ Category: /horror/i, Description: /documentary/i });
```

### Exercice 2

Donner le nombre de films en rating "G"

```js
db.Sakila_films.countDocuments({ Rating: 'G' });
```

## Collection : video_movieDetails

### Exercice 3

Rechercher tous les films de 2012 ou 2013 dont la durée est entre 60 et 150 minutes

```js
db.video_movieDetails.find({
  $or: [{ year: 2012 }, { year: 2013 }],
  runtime: { $gte: 60, $lte: 150 },
});
```

### Exercice 4

Rechercher tous les films qui ont une image "certified" sur tomato

```js
db.video_movieDetails.find({ 'tomato.image': 'certified' });
```

## Collection : Sakila_films

### Exercice 5

Rechercher tous les films avec l'acteur ED (prénom) CHASE (nom)

```js
db.Sakila_films.find({
  Actors: { $elemMatch: { 'Last name': 'CHASE', 'First name': 'ED' } },
});
```

### Exercice 6

Afficher tous les "Rating" et le nombre de films pour chacun d'eux

```js
db.Sakila_films.aggregate([{ $group: { _id: '$Rating', count: { $sum: 1 } } }]);
```
