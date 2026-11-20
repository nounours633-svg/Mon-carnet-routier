# Préparation de Mon Carnet Routier pour Google Play

## État vérifié du dépôt

Le projet actuel est une application web progressive (PWA), publiée avec GitHub Pages.

Fichiers déjà présents :
- `index.html` : application.
- `manifest.json` : nom, affichage et icônes de l'application web.
- `sw.js` : fonctionnement hors connexion et mise à jour du cache.
- `icon-192.png` et `icon-512.png` : icônes Android.
- `.well-known/assetlinks.json` : association entre le site et l'application Android.

Informations déjà présentes dans `.well-known/assetlinks.json` :
- Identifiant Android : `io.github.nounours633_svg.twa`
- Empreinte de certificat SHA-256 : déjà renseignée dans le fichier.

## Éléments qui manquent dans ce dépôt

Aucun projet Android généré n'est actuellement présent :
- pas de configuration Bubblewrap `twa-manifest.json` ;
- pas de fichiers Gradle / projet Android ;
- pas de fichier Android App Bundle signé (`.aab`).

Le fichier AAB est le fichier à envoyer à Google Play Console. Il doit être généré à partir du site avec un outil de Trusted Web Activity (TWA), par exemple Bubblewrap.

## Points à vérifier avant de fabriquer le paquet

1. Confirmer l'adresse publique exacte de GitHub Pages et que le manifeste est accessible à cette adresse.
2. Vérifier que l'identifiant Android et l'empreinte SHA-256 de `.well-known/assetlinks.json` correspondent bien au certificat de signature qui sera utilisé pour construire l'application.
3. Conserver en lieu sûr la clé privée de signature et ses mots de passe. Ne jamais les publier dans ce dépôt ni les transmettre dans une conversation.
4. Générer le projet Android et le fichier AAB signé avec une version de Bubblewrap compatible avec les exigences Google Play du moment.
5. Installer et tester le paquet, puis préparer la fiche Google Play Console et les déclarations demandées par Google.

## Important

Ne pas remplacer ni supprimer les fichiers de l'application web pour préparer Google Play. La publication Android doit emballer le site existant ; elle ne doit pas modifier les données enregistrées localement dans les téléphones.

Ne jamais générer un nouveau certificat de signature sans vérifier la stratégie de signature et l'empreinte déjà publiée : un certificat différent peut faire échouer la vérification plein écran TWA ou compliquer les mises à jour de l'application.
