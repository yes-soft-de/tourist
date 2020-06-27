<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20200620002838 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE comments_entity (id INT AUTO_INCREMENT NOT NULL, region_id INT NOT NULL, user_id INT NOT NULL, comment VARCHAR(255) NOT NULL, date DATE NOT NULL, INDEX IDX_AAB1B6E298260155 (region_id), INDEX IDX_AAB1B6E2A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE images_entity (id INT AUTO_INCREMENT NOT NULL, region_id INT NOT NULL, path VARCHAR(255) NOT NULL, INDEX IDX_CCD2832E98260155 (region_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE ratings_entity (id INT AUTO_INCREMENT NOT NULL, region_id INT NOT NULL, user_id INT NOT NULL, rate INT NOT NULL, INDEX IDX_BA8E2D8A98260155 (region_id), INDEX IDX_BA8E2D8AA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE comments_entity ADD CONSTRAINT FK_AAB1B6E298260155 FOREIGN KEY (region_id) REFERENCES regions_entity (id)');
        $this->addSql('ALTER TABLE comments_entity ADD CONSTRAINT FK_AAB1B6E2A76ED395 FOREIGN KEY (user_id) REFERENCES user (id)');
        $this->addSql('ALTER TABLE images_entity ADD CONSTRAINT FK_CCD2832E98260155 FOREIGN KEY (region_id) REFERENCES regions_entity (id)');
        $this->addSql('ALTER TABLE ratings_entity ADD CONSTRAINT FK_BA8E2D8A98260155 FOREIGN KEY (region_id) REFERENCES regions_entity (id)');
        $this->addSql('ALTER TABLE ratings_entity ADD CONSTRAINT FK_BA8E2D8AA76ED395 FOREIGN KEY (user_id) REFERENCES user (id)');
        $this->addSql('ALTER TABLE user CHANGE phone_number phone_number VARCHAR(15) DEFAULT NULL');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('DROP TABLE comments_entity');
        $this->addSql('DROP TABLE images_entity');
        $this->addSql('DROP TABLE ratings_entity');
        $this->addSql('ALTER TABLE user CHANGE phone_number phone_number INT DEFAULT NULL');
    }
}
