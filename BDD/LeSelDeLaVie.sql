CREATE SCHEMA IF NOT EXISTS `le_sel_de_la_vie_site` DEFAULT CHARACTER SET utf8mb4 ;

USE `le_sel_de_la_vie_site` ;

-- ------------------------------------
--          table Rights             --
-- ------------------------------------

CREATE TABLE IF NOT EXISTS rights (
    id_right INT AUTO_INCREMENT NOT NULL, 
    right_name VARCHAR(255), 
    PRIMARY KEY (id_right)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `rights` (`id_right`, `right_name`) VALUES (1, 'utilisateur');
INSERT INTO `rights` (`id_right`, `right_name`) VALUES (2, 'moderateur');
INSERT INTO `rights` (`id_right`, `right_name`) VALUES (1337, 'admin');

-- ------------------------------------
--        table users         --
-- ------------------------------------

CREATE TABLE IF NOT EXISTS users (
    id_user INT AUTO_INCREMENT NOT NULL, 
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(60),
    adress VARCHAR(255),
    zip_code INT(5),
    id_right INT NOT NULL DEFAULT 1,
    CONSTRAINT FK_users_id_droit_droits 
    FOREIGN KEY (id_right) REFERENCES rights (id_right),
    PRIMARY KEY (id_user)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ------------------------------------
--           table categories        --
-- ------------------------------------ 
     
CREATE TABLE IF NOT EXISTS categories (
    id_category INT AUTO_INCREMENT NOT NULL, 
    name_category VARCHAR(255), 
    PRIMARY KEY (id_category)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `categories` (`id_category`, `name_category`) VALUES (1, 'scolaire');
INSERT INTO `categories` (`id_category`, `name_category`) VALUES (2, 'sortie');
INSERT INTO `categories` (`id_category`, `name_category`) VALUES (3, 'evenement');
INSERT INTO `categories` (`id_category`, `name_category`) VALUES (4, 'conference');
INSERT INTO `categories` (`id_category`, `name_category`) VALUES (5, 'atelier');
INSERT INTO `categories` (`id_category`, `name_category`) VALUES (6, 'divertissement');


-- ------------------------------------
--           table states        --
-- ------------------------------------ 
     
CREATE TABLE IF NOT EXISTS states (
    id_state INT AUTO_INCREMENT NOT NULL, 
    name_state VARCHAR(255), 
    PRIMARY KEY (id_state)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `states` (`id_state`, `name_state`) VALUES (1, 'en cours de validation');
INSERT INTO `states` (`id_state`, `name_state`) VALUES (2, 'valide');

-- ------------------------------------
--           table forms             --
-- ------------------------------------ 

CREATE TABLE IF NOT EXISTS forms (
    id_form INT AUTO_INCREMENT NOT NULL, 
    name_form VARCHAR(255), 
    PRIMARY KEY (id_form)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `forms` (`id_form`, `name_form`) VALUES
(1, 'Soutien Scolaire'),
(2, 'Sortie AquaSplash'),
(3, 'Inscription cours');

-- ------------------------------------
--           table modules           --
-- ------------------------------------

CREATE TABLE IF NOT EXISTS modules (
    id_module INT AUTO_INCREMENT NOT NULL,
    module_type VARCHAR(255) NOT NULL, 
    module_order INT NOT NULL,
    module_label VARCHAR(255) NOT NULL,
    option_count INT,
    option_names VARCHAR(255),
    id_form INT NOT NULL,
    CONSTRAINT FK_forms_id_form_modules 
    FOREIGN KEY (id_form) REFERENCES forms (id_form)
    ON DELETE CASCADE,
    PRIMARY KEY (id_module)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `modules` (`id_module`, `module_type`, `module_order`, `module_label`, `option_count`, `option_names`, `id_form`) VALUES
(1, 'text', 0, 'Nom Pr??nom (parent 1) :', NULL, NULL, 1),
(2, 'text', 2, 'Nom Pr??nom (parent 2) :', NULL, NULL, 1),
(3, 'text', 4, 'Nom Pr??nom (enfant) :', NULL, NULL, 1),
(4, 'textarea', 6, 'Informations compl??mentaires ?? nous transmettre', NULL, NULL, 1),
(5, 'select', 5, 'En quelle classe est votre enfant ?', 5, 'CP||CE1||CE2||CM1||CM2', 1),
(6, 'checkbox', 7, 'Quel mat??riel avez-vous ?', 4, 'Stylos multicolores||Cahier gros carreaux||R??gle||Colle', 1),
(7, 'radio', 8, "Voulez-vous que votre enfant soit seul avec l'encadrant", 2, 'Oui||Non', 1),
(8, 'file', 1, "Carte d'identit?? (parent 1)", NULL, NULL, 1),
(9, 'file', 3, "Carte d'identit?? (parent 2)", NULL, NULL, 1),
(10, 'file', 9, 'Livret de famille', NULL, NULL, 1),
(11, 'file', 10, 'Certificat de scolarit??', NULL, NULL, 1),
(12, 'text', 0, 'Nom et Pr&eacute;nom (adulte 1) :', NULL, NULL, 2),
(13, 'text', 1, 'Nom et Pr&eacute;nom (adulte 2) :', NULL, NULL, 2),
(14, 'textarea', 3, 'Nom(s) enfant(s)', NULL, NULL, 2),
(15, 'select', 2, "Nombre d'enfants participants (le cas echeant)", 4, '0||1||2||3 et +', 2),
(16, 'checkbox', 4, 'Choisissez vos options pour la sortie', 6, 'Je viens et rentre par mes propres moyens||Bus aller-retour||J&#039;apporte ma nourriture||D&eacute;jeuner (5&euro; par personne)||Go&ucirc;ter (2&euro; par personne)||Boissons (3&euro; par personne)', 2),
(17, 'text', 0, 'Nom et pr&eacute;nom du participant', NULL, NULL, 3),
(18, 'textarea', 2, 'Remarque particuli&egrave;re :', NULL, NULL, 3),
(19, 'select', 1, "Niveau pour l'activite :", 4, 'Novice||D&eacute;butant||Interm&eacute;diaire||Avanc&eacute;', 3);

-- ------------------------------------
--           table articles          --
-- ------------------------------------ 
     
CREATE TABLE IF NOT EXISTS articles (
    id_article INT AUTO_INCREMENT NOT NULL, 
    name_article VARCHAR(255),
    image_url VARCHAR(255) DEFAULT 'View/ArticleImg/Bienvenue.jpg',
    description_article TEXT,
    date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_category INT NOT NULL,
    id_state INT NOT NULL,
    id_form INT,    
    CONSTRAINT FK_articles_id_category_categories
    FOREIGN KEY (id_category) REFERENCES categories (id_category),
    CONSTRAINT FK_articles_id_state_states 
    FOREIGN KEY (id_state) REFERENCES states (id_state),
    CONSTRAINT FK_articles_id_form_forms 
    FOREIGN KEY (id_form) REFERENCES forms (id_form),
    PRIMARY KEY (id_article)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `articles` (`id_article`, `name_article`, `image_url`, `description_article`, `date_created`, `id_category`, `id_state`, `id_form`) VALUES
(1, 'Bienvenue ?? tous !', 'View/ArticleImg/LSDLVLAPLAT.png', 
"Les ??tudiants de LaPlateforme_ en partenariat avec l'association Le Sel de la Vie sont heureux de vous pr??senter leur travail. 
Nous avons ??uvr?? afin  de doter cette belle association d'un site mettant en avant ses actions ainsi que son histoire. 
Ce site-outil est mis ?? disposition de ses adh??rents et des participants de l'association. 
Merci ?? vous pour cette belle opportunit?? de partenariat et d'apprentissage !", '2022-07-06 16:05:00', 3, 2, NULL),
(2, 'Sortie AquaSplash', 'View/ArticleImg/aquasplash.jpg', 'Aquasplash propose une vingtaine d???attractions aquatiques, dont une piscine ?? vagues et plus de 15 toboggans g??ants, pour un total de plus de 2000 m??tres de glisse ! \r\nVoici les principales attractions : Turbolance (descente ?? deux dans une bou??e sur un toboggan de 100 m??tres de long, acc??s ?? partir de 1m20), Spaceboat (descente sur bou??e de 3 boucles dans un tunnel plong?? dans le noir avant d???atterrir dans un siphon de 14 m??tres de diam??tre, ?? partir de 1m20)', '2022-07-15 07:56:24', 2, 2, 2),
(3, 'Soutien Scolaire 2022 - 2023', 'View/ArticleImg/carousel1.jpg', 
'Le SelDeLaVie vous propose un soutien scolaire pour les primaires de Marseille. 
Une ??quipe de b??n??vole est ?? votre disposition pour encadrer vos enfants', '2022-07-15 08:09:43', 1, 2, 1),
(4, 'Cours du soir de fran??ais', 'View/ArticleImg/carousel3.jpg', 
'De plus en plus de recruteurs appr??cient de voir une certification en langue fran??aise dans un CV, 
car la ma??trise du fran??ais est exig??e dans le milieu professionnel de nombreux pays francophones 
et elle constitue une valeur ajout??e dans les autres. Le niveau B2, niveau interm??diaire, 
garantit une bonne ma??trise de la langue, tant ?? l?????crit qu????? l???oral, en compr??hension comme en production. 
C???est pourquoi c???est le niveau minimum exig?? pour int??grer une universit?? francophone. Le niveau C1 prouve que vous avez un niveau avanc?? 
et que l???usage de la langue ne pose plus de difficult??s. Aussi, nous vous proposons dans ce cours une pr??paration aux examens du 
Dipl??me d???Etudes en Langue Fran??aise (DELF) niveau B2 et du Dipl??me Approfondi en Langue Fran??aise (DALF) niveau C1.
Tous les sujets qui vous sont propos??s sont tr??s proches de ceux du CIEP, responsable de ces examens.', '2022-07-15 08:11:50', 5, 2, 3),
(5, "L'atelier cr??atif du mardi soir", 'View/ArticleImg/carousel5.jpg', 
'Il est temps pour vous de faire une activit?? manuelle, de profiter d???un moment de relaxation 
apr??s une longue journ??e de labeur fatiguante ou en toute tranquillit?? le samedi ou le dimanche. 
Comme la majorit?? des personnes habitant ?? Marseille, vous ??prouvez le besoin 
de vous affirmer avec le loisir cr??atif et le Do It Yourself. 
Il y a un nombre important d???activit??s de loisirs cr??atifs : 
la broderie, le cartonnage, l???origami ou encore la cr??ation de bijoux, le bricolage...', '2022-07-15 08:17:06', 5, 2, 3),
(6, 'Atelier Cuisine', 'View/ArticleImg/carousel4.jpg', 'Il est temps pour vous de faire une activit?? manuelle, 
de profiter d???un moment de relaxation apr??s une longue journ??e de labeur 
fatiguante ou en toute tranquillit?? le samedi ou le dimanche. 
Comme la majorit?? des personnes habitant ?? Marseille, vous ??prouvez le besoin de vous affirmer 
avec le loisir cr??atif et le Do It Yourself. Il y a un nombre important d???activit??s de loisirs cr??atifs : 
la broderie, le cartonnage, l???origami ou encore la cr??ation de bijoux, le bricolage', '2022-07-15 08:19:04', 5, 2, 3),
(7, 'Sortie Parc Borely', 'View/ArticleImg/carousel2.jpg', 
"Le parc Bor??ly se situe dans le 8??me arrondissement de Marseille, ?? c??t?? de l'hippodrome Marseille Bor??ly. 
Il occupe une surface de 17 hectares, ponctu??s de sculptures et de jardins de styles diff??rents : 
jardin traditionnel chinois, roseraie, jardin botanique... On y trouve aussi une parcelle de jardin anglais. 
Elle se distingue par des formes sinueuses. ?? c??t??, un jardin ?? la fran??aise fait le contraste : 
il est compos?? de mani??re plus sym??trique et ordonn??e. Le jardin traditionnel chinois, lui, 
a ??t?? offert ?? Marseille par la ville de Shanghai, en 2004. Cet espace est ??galement un lieu de culture. 
On peut y admirer une c??l??bre oeuvre de l'artiste Jean-Michel Folon : l'homme aux oiseaux. 
En 2008, un mus??e des arts d??coratifs a ??t?? cr???? dans le ch??teau de Bor??ly. 
Il expose la culture proven??ale des XVIII et XIX??me si??cles, ?? travers diff??rents objets de la vie quotidienne ou d??coratifs : 
tapisseries, meubles, porcelaine...
Le parc Bor??ly est un lieu de d??tente pour les Marseillais mais aussi les visiteurs de passage.", '2022-07-15 08:21:08', 2, 2, 2),
(8, 'Sortie Jardin des Automates', 'View/ArticleImg/jardinAutomates.jpg', 
'Entrez dans le monde magique des automates et d??couvrez-les dans des univers amusants, ludiques et f??eriques. 
La maison du Mexique, la pagode des pandas, le palais des 1001 nuits, la maison de la jungle, le ch??teau du P??re-No??l, 
la baleine de Pinocchio et bien d\'autres encore vous ouvriront leurs portes afin que vous puissiez 
??couter les histoires et les chansons de nos chers amis les automates. 
Baladez vous en famille de maison en maison dans un monde enfantin 
puis profitez des aires de jeux mises en place pour les petits: Parcours aventure des dragons, 
la ferme, les chenilles ?? toboggans, les jeux d\'eau et brumisateurs (en ??t?? uniquement), 
tourniquet et jeux ?? ressorts, labyrinthe et bo??te ?? rires....
une multitude de petites attractions qui apporteront ?? vos bambins joie et bonne humeur.', '2022-07-15 08:27:41', 2, 2, 2),
(9, "Cours du soir d'Anglais", 'View/ArticleImg/Cours-danglais.png', 
"Les cours du soir sont propos??s en petit groupe et se d??roulent le lundi de 19h ?? 20h30 
(hors vacances scolaires) dans notre centre situ?? ?? Marseille 13006, au 27 rue Aldebert. 
Nous proposons ??galement ce cours dans notre centre d'Aix-en-Provence. 
Vous ??tes ?? la recherche d'une solution de cours d'anglais ?? Marseille ?
Contactez l'??quipe du Sel de la Vie", '2022-07-15 08:31:07', 5, 2, 3);


-- ------------------------------------
--        table users_articles        --
-- ------------------------------------

CREATE TABLE IF NOT EXISTS users_articles (
    id_users_articles INT AUTO_INCREMENT NOT NULL,
    id_user INT NOT NULL,
    id_article INT NOT NULL,
    CONSTRAINT FK_users_articles_id_user_users
    FOREIGN KEY (id_user) REFERENCES users (id_user),
    CONSTRAINT FK_users_articles_id_article_articles 
    FOREIGN KEY (id_article) REFERENCES articles (id_article),
    PRIMARY KEY (id_users_articles)) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ------------------------------------
--        table r??cup??ration         --
-- ------------------------------------
CREATE TABLE IF NOT EXISTS recuperation (
    id INT AUTO_INCREMENT NOT NULL,
    mail VARCHAR(255) NOT NULL,
    code int(11) NOT NULL,
    PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ------------------------------------
--           table carousel          --
-- ------------------------------------

CREATE TABLE IF NOT EXISTS carousel_articles(
    id_carousel_article INT NOT NULL,
    id_article INT NOT NULL,
    CONSTRAINT FK_carousel_articles_id_article_articles
    FOREIGN KEY (id_article) REFERENCES articles (id_article),
    PRIMARY KEY (id_carousel_article)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `carousel_articles` (`id_carousel_article`, `id_article`) VALUES
(0, 2),
(1, 3),
(2, 4),
(3, 5);