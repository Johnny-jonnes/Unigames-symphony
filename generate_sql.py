import json
from datetime import datetime, timedelta

def main():
    sql = []
    sql.append("-- ==========================================================")
    sql.append("-- SCRIPT ULTIME UNIGAMES - RÉEL ET EXHAUSTIF (CORRIGÉ)")
    sql.append("-- ==========================================================")
    sql.append("")
    sql.append("USE unigames_db;")
    sql.append("")
    sql.append("DROP TABLE IF EXISTS `users`;")
    sql.append("CREATE TABLE `users` (")
    sql.append("  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,")
    sql.append("  `name` varchar(255) NOT NULL,")
    sql.append("  `email` varchar(255) NOT NULL,")
    sql.append("  `role` varchar(255) DEFAULT 'staff',")
    sql.append("  `password` varchar(255) NOT NULL,")
    sql.append("  `created_at` timestamp NULL DEFAULT NULL,")
    sql.append("  `updated_at` timestamp NULL DEFAULT NULL,")
    sql.append("  PRIMARY KEY (`id`),")
    sql.append("  UNIQUE KEY `users_email_unique` (`email`)")
    sql.append(") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;")
    sql.append("")
    sql.append("SET FOREIGN_KEY_CHECKS = 0;")
    sql.append("TRUNCATE TABLE joueur; TRUNCATE TABLE matchs; TRUNCATE TABLE equipe;")
    sql.append("TRUNCATE TABLE discipline; TRUNCATE TABLE faculte; TRUNCATE TABLE edition;")
    sql.append("TRUNCATE TABLE users;")
    sql.append("SET FOREIGN_KEY_CHECKS = 1;")
    sql.append("")
    
    # 1. EDITIONS (statut fixe: terminee, en_cours, a_venir)
    sql.append("-- 1. EDITIONS")
    sql.append("-- Ajouter les colonnes manquantes si elles n'existent pas")
    sql.append("SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'unigames_db' AND TABLE_NAME = 'edition' AND COLUMN_NAME = 'lieu');")
    sql.append("SET @sql = IF(@col_exists = 0, 'ALTER TABLE edition ADD COLUMN lieu varchar(255) DEFAULT NULL', 'SELECT 1');")
    sql.append("PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;")
    sql.append("SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'unigames_db' AND TABLE_NAME = 'edition' AND COLUMN_NAME = 'description');")
    sql.append("SET @sql = IF(@col_exists = 0, 'ALTER TABLE edition ADD COLUMN description text DEFAULT NULL', 'SELECT 1');")
    sql.append("PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;")
    sql.append("SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'unigames_db' AND TABLE_NAME = 'edition' AND COLUMN_NAME = 'statut');")
    sql.append("SET @sql = IF(@col_exists = 0, \"ALTER TABLE edition ADD COLUMN statut enum('a_venir','en_cours','terminee') DEFAULT 'a_venir'\", 'SELECT 1');")
    sql.append("PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;")
    sql.append("")
    sql.append("INSERT INTO edition (id, nom, date_debut, date_fin, lieu, description, statut) VALUES")
    sql.append("(1, 'Jeux Universitaires 2024', '2024-05-01', '2024-05-15', 'Conakry', 'Première édition des Jeux Universitaires de Guinée', 'terminee'),")
    sql.append("(2, 'Jeux Universitaires 2025', '2025-05-01', '2025-05-15', 'Conakry', 'Deuxième édition', 'terminee'),")
    sql.append("(3, 'Jeux Universitaires 2026', '2026-05-01', '2026-05-15', 'Conakry', 'Troisième édition', 'terminee');")
    sql.append("")
    
    # 3. DISCIPLINES
    sql.append("-- 3. DISCIPLINES")
    sql.append("INSERT INTO discipline (id, nom, description, nombre_joueurs_par_equipe) VALUES")
    sql.append("(1, 'Football Masculin', '11 vs 11', 22), (2, 'Basketball Féminin', '5 vs 5', 12),")
    sql.append("(3, 'Volleyball Mixte', '6 vs 6', 10), (4, 'Handball Masculin', '7 vs 7', 14);")
    sql.append("")

    facultes = [
        ('Université de Kindia', 'UK'),
        ('Univ. Gl Lansana Conté', 'Sonfonia'),
        ('Univ. Gamal Abdel Nasser', 'Gamal'),
        ('Université Nongo Conakry', 'UNC'),
        ('Univ. Mercure International', 'Mercure'),
        ('Université Kofi Annan', 'Kofi'),
        ('Univ. Julius Nyerere', 'Kankan'),
        ('ISAV Faranah', 'ISAV'),
        ('Institut Supérieur des Mines', 'Boké'),
        ('Institut Supérieur des Arts', 'Mory Kanté'),
        ('Université de Labé', 'Labé'),
        ('Université de Nzérékoré', 'NZ'),
        ('ENAM', 'ENAM'),
        ('ISIC Kountia', 'ISIC'),
        ('Institut Supérieur de Commerce', 'ISC'),
        ('UCAO Conakry', 'UCAO')
    ]
    
    # 2. FACULTES
    sql.append("-- 2. FACULTES")
    facs_sql = []
    fac_id = 1
    fac_map = {} # edition_id -> list of fac_ids
    for ed_id in [1, 2, 3]:
        fac_map[ed_id] = []
        for name, short in facultes:
            facs_sql.append(f"({fac_id}, '{name}', 'Université de Conakry', {ed_id})")
            fac_map[ed_id].append(fac_id)
            fac_id += 1
    sql.append("INSERT INTO faculte (id, nom, universite, edition_id) VALUES")
    sql.append(",\n".join(facs_sql) + ";")
    sql.append("")

    # 4. EQUIPES
    sql.append("-- 4. EQUIPES")
    eqs_sql = []
    eq_id = 1
    eq_map = {} # (edition_id, discipline_id) -> list of eq_ids
    for ed_id in [1, 2, 3]:
        for disc_id in [1, 2, 3, 4]:
            eq_map[(ed_id, disc_id)] = []
            for i, (name, short) in enumerate(facultes):
                sport = ['Foot', 'Basket', 'Volley', 'Hand'][disc_id-1]
                fid = fac_map[ed_id][i]
                eqs_sql.append(f"({eq_id}, '{short} {sport}', {fid}, {disc_id}, {ed_id})")
                eq_map[(ed_id, disc_id)].append(eq_id)
                eq_id += 1
    sql.append("INSERT INTO equipe (id, nom, faculte_id, discipline_id, edition_id) VALUES")
    sql.append(",\n".join(eqs_sql) + ";")
    sql.append("")

    # 5. JOUEURS
    sql.append("-- 5. JOUEURS")
    joueurs_sql = []
    noms = ['Diallo', 'Camara', 'Sow', 'Traore', 'Sylla', 'Bangoura', 'Kouyate', 'Sidibe', 'Doumbouya', 'Bah', 'Keita', 'Barry']
    prenoms = ['M.', 'I.', 'A.', 'S.', 'F.', 'L.', 'O.', 'J.', 'K.', 'B.', 'H.', 'Z.']
    j_id = 1
    import random
    random.seed(42)
    for eq in range(1, eq_id):
        # Insert 3 players per team
        for i in range(3):
            n = random.choice(noms)
            p = random.choice(prenoms)
            sexe = 'F' if eq % 2 == 0 else 'M'
            num = random.randint(1, 20)
            joueurs_sql.append(f"('{n}', '{p}', '{sexe}', {num}, {eq})")
            j_id += 1
    sql.append("INSERT INTO joueur (nom, prenom, sexe, numero, equipe_id) VALUES")
    sql.append(",\n".join(joueurs_sql) + ";")
    sql.append("")

    # 6. MATCHS
    sql.append("-- 6. MATCHS")
    matchs_sql = []
    
    # helper to generate match
    def make_match(ed_id, disc_id, phase, eq_a, eq_b, date_str, score_a, score_b, statut):
        buteurs = {"equipe_a": [], "equipe_b": []}
        if statut == 'joue' or statut == 'en_cours':
            if score_a > 0:
                p_id_a = (eq_a - 1) * 3 + 1
                buteurs["equipe_a"].append({"id": p_id_a, "nb_buts": score_a})
            if score_b > 0:
                p_id_b = (eq_b - 1) * 3 + 1
                buteurs["equipe_b"].append({"id": p_id_b, "nb_buts": score_b})
        
        buteurs_json = json.dumps(buteurs).replace("'", "\\'")
        return f"('{date_str}', 'Stade/Gymnase', '{phase}', {score_a}, {score_b}, '{statut}', '{buteurs_json}', {eq_a}, {eq_b}, {disc_id}, {ed_id})"

    # GENERATE TOURNAMENT FOR ALL EDITIONS
    for ed_id in [1, 2, 3]:
        for disc_id in [1, 2, 3, 4]:
            teams = eq_map[(ed_id, disc_id)] # 16 teams
            
            # Helper for date based on edition
            base_year = 2023 + ed_id
            
            # Status based on edition (since today is May 23 2026, all editions are passed)
            st_p = 'joue'; st_8 = 'joue'; st_q = 'joue'; st_d = 'joue'; st_f = 'joue'

            def get_realistic_score(statut, disc_id, a_wins, is_draw=False):
                if statut == 'planifie': return 0, 0
                
                # For en_cours, give partial scores
                is_partial = (statut == 'en_cours')
                
                if disc_id == 1: # Foot
                    if is_draw: return 1, 1
                    sa, sb = (random.randint(2, 4), random.randint(0, 1)) if a_wins else (random.randint(0, 1), random.randint(2, 4))
                    return (max(0, sa-1), max(0, sb-1)) if is_partial else (sa, sb)
                elif disc_id == 2: # Basket
                    if is_draw: return 85, 85
                    sa, sb = (random.randint(80, 105), random.randint(60, 78)) if a_wins else (random.randint(60, 78), random.randint(80, 105))
                    return (int(sa*0.6), int(sb*0.6)) if is_partial else (sa, sb)
                elif disc_id == 3: # Volley
                    if is_draw: return 2, 2
                    sa, sb = (3, random.randint(0, 2)) if a_wins else (random.randint(0, 2), 3)
                    return (min(2, sa), min(2, sb)) if is_partial else (sa, sb)
                elif disc_id == 4: # Hand
                    if is_draw: return 28, 28
                    sa, sb = (random.randint(28, 38), random.randint(18, 26)) if a_wins else (random.randint(18, 26), random.randint(28, 38))
                    return (int(sa*0.5), int(sb*0.5)) if is_partial else (sa, sb)



            # 1. Poules (Simulated, just a few matches)
            for i in range(0, 16, 2):
                a_wins = (i % 4 == 0)
                is_draw = (i % 8 == 0) and (st_p == 'joue') and (disc_id != 3) # no draw in volley if possible, but let's just avoid draws to be safe
                sa, sb = get_realistic_score(st_p, disc_id, a_wins, is_draw=False)
                matchs_sql.append(make_match(ed_id, disc_id, 'Poules', teams[i], teams[i+1], f'{base_year}-05-01 10:00:00', sa, sb, st_p))

            # 2. 8e de Finale (16 teams -> 8 matchs)
            for i in range(0, 16, 2):
                a_wins = (i % 4 == 0)
                sa, sb = get_realistic_score(st_8, disc_id, a_wins)
                # Ensure a winner if played
                if st_8 == 'joue' and sa == sb: sa += 1
                matchs_sql.append(make_match(ed_id, disc_id, '8e de finale', teams[i], teams[i+1], f'{base_year}-05-05 10:00:00', sa, sb, st_8))
            
            # Winners of 8e: teams[0], teams[3], teams[4], teams[7], teams[8], teams[11], teams[12], teams[15]
            w8 = [teams[0], teams[3], teams[4], teams[7], teams[8], teams[11], teams[12], teams[15]]
            
            # 3. Quart de Finale (8 teams -> 4 matchs)
            for i in range(0, 8, 2):
                a_wins = (i % 4 == 0)
                sa, sb = get_realistic_score(st_q, disc_id, a_wins)
                if st_q == 'joue' and sa == sb: sa += 1
                matchs_sql.append(make_match(ed_id, disc_id, 'Quart de finale', w8[i], w8[i+1], f'{base_year}-05-08 14:00:00', sa, sb, st_q))
            
            # Winners of Quart: w8[0], w8[3], w8[4], w8[7]
            wq = [w8[0], w8[3], w8[4], w8[7]]
            
            # 4. Demi-Finale (4 teams -> 2 matchs)
            sa, sb = get_realistic_score(st_d, disc_id, True)
            if st_d == 'joue' and sa == sb: sa += 1
            matchs_sql.append(make_match(ed_id, disc_id, 'Demi', wq[0], wq[1], f'{base_year}-05-12 16:00:00', sa, sb, st_d))
            
            sa, sb = get_realistic_score(st_d, disc_id, False)
            if st_d == 'joue' and sa == sb: sb += 1
            matchs_sql.append(make_match(ed_id, disc_id, 'Demi', wq[2], wq[3], f'{base_year}-05-12 16:00:00', sa, sb, st_d))

            # 5. Finale (2 teams -> 1 match)
            wd = [wq[0], wq[3]]
            sa, sb = get_realistic_score(st_f, disc_id, True)
            if st_f == 'joue' and sa == sb: sa += 1
            matchs_sql.append(make_match(ed_id, disc_id, 'Finale', wd[0], wd[1], f'{base_year}-05-15 20:00:00', sa, sb, st_f))

    sql.append("INSERT INTO matchs (date_match, lieu, phase, score_a, score_b, statut, buteurs, equipe_a_id, equipe_b_id, discipline_id, edition_id) VALUES")
    sql.append(",\n".join(matchs_sql) + ";")
    sql.append("")

    sql.append("-- 11. UTILISATEURS")
    sql.append("INSERT INTO users (id, email, role, password, name) VALUES")
    # Using default Laravel hash for 'password'
    sql.append("(1, 'admin@unigames.gn', 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrateur'),")
    sql.append("(2, 'staff@unigames.gn', 'staff', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Staff Sportif');")
    sql.append("")

    sql.append("-- 12. TABLES TECHNIQUES LARAVEL")
    sql.append("CREATE TABLE IF NOT EXISTS `sessions` ( `id` varchar(255) NOT NULL, `user_id` bigint(20) unsigned DEFAULT NULL, `ip_address` varchar(45) DEFAULT NULL, `user_agent` text, `payload` longtext NOT NULL, `last_activity` int(11) NOT NULL, PRIMARY KEY (`id`), KEY `sessions_user_id_index` (`user_id`), KEY `sessions_last_activity_index` (`last_activity`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;")
    sql.append("CREATE TABLE IF NOT EXISTS `cache` ( `key` varchar(255) NOT NULL, `value` mediumtext NOT NULL, `expiration` int(11) NOT NULL, PRIMARY KEY (`key`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;")
    sql.append("CREATE TABLE IF NOT EXISTS `cache_locks` ( `key` varchar(255) NOT NULL, `owner` varchar(255) NOT NULL, `expiration` int(11) NOT NULL, PRIMARY KEY (`key`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;")
    sql.append("CREATE TABLE IF NOT EXISTS `jobs` ( `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT, `queue` varchar(255) NOT NULL, `payload` longtext NOT NULL, `attempts` tinyint(3) unsigned NOT NULL, `reserved_at` int(10) unsigned DEFAULT NULL, `available_at` int(10) unsigned NOT NULL, `created_at` int(10) unsigned NOT NULL, PRIMARY KEY (`id`), KEY `jobs_queue_index` (`queue`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;")
    sql.append("CREATE TABLE IF NOT EXISTS `failed_jobs` ( `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT, `uuid` varchar(255) NOT NULL, `connection` text NOT NULL, `queue` text NOT NULL, `payload` longtext NOT NULL, `exception` longtext NOT NULL, `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (`id`), UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;")
    sql.append("CREATE TABLE IF NOT EXISTS `job_batches` ( `id` varchar(255) NOT NULL, `name` varchar(255) NOT NULL, `total_jobs` int(11) NOT NULL, `pending_jobs` int(11) NOT NULL, `failed_jobs` int(11) NOT NULL, `failed_job_ids` longtext NOT NULL, `options` mediumtext, `cancelled_at` int(11) DEFAULT NULL, `created_at` int(11) NOT NULL, `finished_at` int(11) DEFAULT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;")

    with open('insert_test_data_unigames.sql', 'w', encoding='utf-8') as f:
        f.write("\n".join(sql))

if __name__ == '__main__':
    main()
