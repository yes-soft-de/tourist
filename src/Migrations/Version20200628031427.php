<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20200628031427 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE guid_entity (id INT AUTO_INCREMENT NOT NULL, user_id INT NOT NULL, name VARCHAR(25) NOT NULL, status VARCHAR(15) DEFAULT NULL, about VARCHAR(100) DEFAULT NULL, city JSON DEFAULT NULL, language JSON DEFAULT NULL, phone_number VARCHAR(15) DEFAULT NULL, cost VARCHAR(10) DEFAULT NULL, service JSON DEFAULT NULL, UNIQUE INDEX UNIQ_CC1E99A0A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE guid_entity ADD CONSTRAINT FK_CC1E99A0A76ED395 FOREIGN KEY (user_id) REFERENCES user (id)');
        $this->addSql('ALTER TABLE comments_entity CHANGE date date DATETIME NOT NULL');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('DROP TABLE guid_entity');
        $this->addSql('ALTER TABLE comments_entity CHANGE date date DATE NOT NULL');
    }
}
