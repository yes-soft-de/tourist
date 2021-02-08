<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20200704092027 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE comments_entity ADD guid_id INT DEFAULT NULL, CHANGE region_id region_id INT DEFAULT NULL, CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE comments_entity ADD CONSTRAINT FK_AAB1B6E231F4582D FOREIGN KEY (guid_id) REFERENCES user (id)');
        $this->addSql('CREATE INDEX IDX_AAB1B6E231F4582D ON comments_entity (guid_id)');
        $this->addSql('ALTER TABLE images_entity ADD guid_id INT DEFAULT NULL, CHANGE region_id region_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE images_entity ADD CONSTRAINT FK_CCD2832E31F4582D FOREIGN KEY (guid_id) REFERENCES user (id)');
        $this->addSql('CREATE INDEX IDX_CCD2832E31F4582D ON images_entity (guid_id)');
        $this->addSql('ALTER TABLE ratings_entity ADD guid_id INT DEFAULT NULL, CHANGE region_id region_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE ratings_entity ADD CONSTRAINT FK_BA8E2D8A31F4582D FOREIGN KEY (guid_id) REFERENCES user (id)');
        $this->addSql('CREATE INDEX IDX_BA8E2D8A31F4582D ON ratings_entity (guid_id)');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE comments_entity DROP FOREIGN KEY FK_AAB1B6E231F4582D');
        $this->addSql('DROP INDEX IDX_AAB1B6E231F4582D ON comments_entity');
        $this->addSql('ALTER TABLE comments_entity DROP guid_id, CHANGE region_id region_id INT NOT NULL, CHANGE user_id user_id INT NOT NULL');
        $this->addSql('ALTER TABLE images_entity DROP FOREIGN KEY FK_CCD2832E31F4582D');
        $this->addSql('DROP INDEX IDX_CCD2832E31F4582D ON images_entity');
        $this->addSql('ALTER TABLE images_entity DROP guid_id, CHANGE region_id region_id INT NOT NULL');
        $this->addSql('ALTER TABLE ratings_entity DROP FOREIGN KEY FK_BA8E2D8A31F4582D');
        $this->addSql('DROP INDEX IDX_BA8E2D8A31F4582D ON ratings_entity');
        $this->addSql('ALTER TABLE ratings_entity DROP guid_id, CHANGE region_id region_id INT NOT NULL');
    }
}
