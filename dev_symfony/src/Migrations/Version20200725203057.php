<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20200725203057 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE comments_entity ADD event_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE comments_entity ADD CONSTRAINT FK_AAB1B6E271F7E88B FOREIGN KEY (event_id) REFERENCES event_entity (id)');
        $this->addSql('CREATE INDEX IDX_AAB1B6E271F7E88B ON comments_entity (event_id)');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE comments_entity DROP FOREIGN KEY FK_AAB1B6E271F7E88B');
        $this->addSql('DROP INDEX IDX_AAB1B6E271F7E88B ON comments_entity');
        $this->addSql('ALTER TABLE comments_entity DROP event_id');
    }
}
