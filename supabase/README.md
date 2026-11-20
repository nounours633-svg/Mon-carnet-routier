# Mise en place du partage privé — Mon Carnet Routier

## Objectif
Un seul lien d'application, mais un carnet séparé pour chaque compte. Les données sont stockées dans la ligne dont `user_id` correspond au compte connecté. La sécurité est appliquée par PostgreSQL Row Level Security (RLS), pas par un simple identifiant côté téléphone.

## État actuel
L'application existante conserve les journées dans le stockage local du navigateur (`monCarnetRoutierV2`) et les tarifs repas/nuitée dans deux clés locales. Le fichier `index.html` n'est volontairement pas modifié à cette étape : aucun risque de casser l'application actuelle ou d'effacer les données présentes sur le téléphone.

## Étapes nécessaires
1. Créer un projet Supabase appartenant à l'utilisateur.
2. Dans Supabase, ouvrir SQL Editor et exécuter `schema.sql`.
3. Récupérer l'URL du projet et la clé publique `anon`/publishable. Ne jamais communiquer ni intégrer la clé `service_role`.
4. Ajouter dans l'application un écran de connexion/inscription et une synchronisation protégée.
5. Tester avec deux comptes distincts : chaque compte doit uniquement lire et écrire sa propre ligne.
6. Pour le compte existant, sauvegarder d'abord les données JSON et importer les journées et tarifs locaux vers le compte connecté. Ne jamais supprimer les données locales pendant la migration.
7. Tester les fonctions hors ligne et la reconnexion avant de publier la version finale.

## Structure de stockage
- `user_id`: identifiant authentifié du propriétaire (clé primaire).
- `jours`: tableau JSON contenant les journées existantes sans changer leur structure.
- `tarif_repas` et `tarif_nuitee`: tarifs actuellement stockés séparément sur le téléphone.
- Les règles RLS imposent `auth.uid() = user_id` pour chaque opération.

## Sécurité
La clé publique du projet peut être utilisée dans l'application uniquement avec RLS activé. La clé `service_role` est secrète et ne doit jamais être mise dans le code du navigateur, dans GitHub Pages ou envoyée dans une conversation.
