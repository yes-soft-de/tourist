<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20200704211712 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE guid_entity ADD path VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE images_entity DROP FOREIGN KEY FK_CCD2832E31F4582D');
        $this->addSql('DROP INDEX IDX_CCD2832E31F4582D ON images_entity');
        $this->addSql('ALTER TABLE images_entity DROP guid_id');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE guid_entity DROP path');
        $this->addSql('ALTER TABLE images_entity ADD guid_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE images_entity ADD CONSTRAINT FK_CCD2832E31F4582D FOREIGN KEY (guid_id) REFERENCES user (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('CREATE INDEX IDX_CCD2832E31F4582D ON images_entity (guid_id)');
    }
}
