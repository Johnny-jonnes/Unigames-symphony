<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260508154036 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE discipline (id INT AUTO_INCREMENT NOT NULL, nom VARCHAR(255) NOT NULL, description LONGTEXT DEFAULT NULL, nombre_joueurs_par_equipe INT NOT NULL, PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('CREATE TABLE edition (id INT AUTO_INCREMENT NOT NULL, nom VARCHAR(255) NOT NULL, date_debut DATETIME NOT NULL, date_fin DATETIME NOT NULL, PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('CREATE TABLE equipe (id INT AUTO_INCREMENT NOT NULL, nom VARCHAR(255) NOT NULL, faculte_id INT NOT NULL, discipline_id INT NOT NULL, edition_id INT NOT NULL, INDEX IDX_2449BA1572C3434F (faculte_id), INDEX IDX_2449BA15A5522701 (discipline_id), INDEX IDX_2449BA1574281A5E (edition_id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('CREATE TABLE faculte (id INT AUTO_INCREMENT NOT NULL, nom VARCHAR(255) NOT NULL, universite VARCHAR(255) NOT NULL, edition_id INT NOT NULL, INDEX IDX_3973C0C74281A5E (edition_id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('CREATE TABLE joueur (id INT AUTO_INCREMENT NOT NULL, nom VARCHAR(255) NOT NULL, prenom VARCHAR(255) NOT NULL, sexe VARCHAR(10) NOT NULL, numero INT NOT NULL, equipe_id INT NOT NULL, INDEX IDX_FD71A9C56D861B89 (equipe_id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('CREATE TABLE matchs (id INT AUTO_INCREMENT NOT NULL, date_match DATETIME NOT NULL, lieu VARCHAR(255) DEFAULT NULL, phase VARCHAR(255) DEFAULT NULL, score_a INT DEFAULT 0 NOT NULL, score_b INT DEFAULT 0 NOT NULL, statut VARCHAR(50) NOT NULL, buteurs JSON DEFAULT NULL, equipe_a_id INT NOT NULL, equipe_b_id INT NOT NULL, discipline_id INT NOT NULL, edition_id INT NOT NULL, INDEX IDX_6B1E60413297C2A6 (equipe_a_id), INDEX IDX_6B1E604120226D48 (equipe_b_id), INDEX IDX_6B1E6041A5522701 (discipline_id), INDEX IDX_6B1E604174281A5E (edition_id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('CREATE TABLE user (id INT AUTO_INCREMENT NOT NULL, email VARCHAR(180) NOT NULL, name VARCHAR(255) NOT NULL, roles JSON NOT NULL, password VARCHAR(255) NOT NULL, UNIQUE INDEX UNIQ_IDENTIFIER_EMAIL (email), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('CREATE TABLE messenger_messages (id BIGINT AUTO_INCREMENT NOT NULL, body LONGTEXT NOT NULL, headers LONGTEXT NOT NULL, queue_name VARCHAR(190) NOT NULL, created_at DATETIME NOT NULL, available_at DATETIME NOT NULL, delivered_at DATETIME DEFAULT NULL, INDEX IDX_75EA56E0FB7336F0 (queue_name), INDEX IDX_75EA56E0E3BD61CE (available_at), INDEX IDX_75EA56E016BA31DB (delivered_at), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4');
        $this->addSql('ALTER TABLE equipe ADD CONSTRAINT FK_2449BA1572C3434F FOREIGN KEY (faculte_id) REFERENCES faculte (id)');
        $this->addSql('ALTER TABLE equipe ADD CONSTRAINT FK_2449BA15A5522701 FOREIGN KEY (discipline_id) REFERENCES discipline (id)');
        $this->addSql('ALTER TABLE equipe ADD CONSTRAINT FK_2449BA1574281A5E FOREIGN KEY (edition_id) REFERENCES edition (id)');
        $this->addSql('ALTER TABLE faculte ADD CONSTRAINT FK_3973C0C74281A5E FOREIGN KEY (edition_id) REFERENCES edition (id)');
        $this->addSql('ALTER TABLE joueur ADD CONSTRAINT FK_FD71A9C56D861B89 FOREIGN KEY (equipe_id) REFERENCES equipe (id)');
        $this->addSql('ALTER TABLE matchs ADD CONSTRAINT FK_6B1E60413297C2A6 FOREIGN KEY (equipe_a_id) REFERENCES equipe (id)');
        $this->addSql('ALTER TABLE matchs ADD CONSTRAINT FK_6B1E604120226D48 FOREIGN KEY (equipe_b_id) REFERENCES equipe (id)');
        $this->addSql('ALTER TABLE matchs ADD CONSTRAINT FK_6B1E6041A5522701 FOREIGN KEY (discipline_id) REFERENCES discipline (id)');
        $this->addSql('ALTER TABLE matchs ADD CONSTRAINT FK_6B1E604174281A5E FOREIGN KEY (edition_id) REFERENCES edition (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE equipe DROP FOREIGN KEY FK_2449BA1572C3434F');
        $this->addSql('ALTER TABLE equipe DROP FOREIGN KEY FK_2449BA15A5522701');
        $this->addSql('ALTER TABLE equipe DROP FOREIGN KEY FK_2449BA1574281A5E');
        $this->addSql('ALTER TABLE faculte DROP FOREIGN KEY FK_3973C0C74281A5E');
        $this->addSql('ALTER TABLE joueur DROP FOREIGN KEY FK_FD71A9C56D861B89');
        $this->addSql('ALTER TABLE matchs DROP FOREIGN KEY FK_6B1E60413297C2A6');
        $this->addSql('ALTER TABLE matchs DROP FOREIGN KEY FK_6B1E604120226D48');
        $this->addSql('ALTER TABLE matchs DROP FOREIGN KEY FK_6B1E6041A5522701');
        $this->addSql('ALTER TABLE matchs DROP FOREIGN KEY FK_6B1E604174281A5E');
        $this->addSql('DROP TABLE discipline');
        $this->addSql('DROP TABLE edition');
        $this->addSql('DROP TABLE equipe');
        $this->addSql('DROP TABLE faculte');
        $this->addSql('DROP TABLE joueur');
        $this->addSql('DROP TABLE matchs');
        $this->addSql('DROP TABLE user');
        $this->addSql('DROP TABLE messenger_messages');
    }
}
