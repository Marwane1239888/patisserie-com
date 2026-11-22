# Pâtisserie – Commandes partagées

Application web responsive pour Android et iPhone. Les utilisateurs connectés partagent les mêmes produits, commandes, tickets café et paramètres.

## Avant la publication

1. Créer un projet sur [Supabase](https://supabase.com).
2. Dans **SQL Editor**, exécuter tout le fichier `supabase_setup.sql`.
3. Récupérer le **Project URL** et la **Publishable key** dans Supabase.
4. Dans `index.html`, remplacer les deux valeurs suivantes par vos propres valeurs :
   - `PASTE_YOUR_SUPABASE_PROJECT_URL_HERE`
   - `PASTE_YOUR_SUPABASE_PUBLISHABLE_KEY_HERE`
5. Ne jamais mettre une **Secret key** ou une clé `service_role` dans `index.html` ni dans GitHub.
6. Le fichier est configuré avec `ALLOW_SIGNUP=false` : créez/invitez chaque utilisateur dans **Supabase → Authentication → Users → Add user → Send invitation**. Tous les utilisateurs auront les mêmes droits dans l’application. Gardez les inscriptions publiques désactivées.

## Publier gratuitement avec GitHub Pages

1. Créer un nouveau dépôt GitHub **Public** (ex. `patisserie-commandes`).
2. Dans le dépôt, choisir **Add file → Upload files**.
3. Téléverser le contenu de ce dossier à la racine du dépôt : `index.html`, `supabase_setup.sql`, `LISEZ-MOI.txt`, `.nojekyll` et `README.md`. Ne téléverser que les fichiers, pas le dossier parent.
4. Cliquer sur **Commit changes**.
5. Ouvrir **Settings → Pages**.
6. Dans **Build and deployment**, choisir **Deploy from a branch**, puis `main` et `/(root)`, puis **Save**.
7. Attendre le déploiement GitHub Pages. Le lien sera affiché dans la page **Settings → Pages**.

Le fichier `index.html` doit rester à la racine du dépôt pour être détecté par GitHub Pages.

## Attention

GitHub Pages publie un site accessible publiquement sur Internet. L'accès aux données dépend de l'authentification Supabase et des règles RLS installées par `supabase_setup.sql`. Utiliser uniquement la Publishable key côté navigateur. Faire régulièrement une sauvegarde des données depuis l'application.
