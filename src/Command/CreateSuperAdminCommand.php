<?php


namespace App\Command;

use App\Request\AdminCreateRequest;
use App\Service\AdminServiceInterface;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class CreateSuperAdminCommand extends Command
{
    protected static $defaultName = 'app:create-super-admin';

    private $adminService;

    public function __construct(AdminServiceInterface $adminServiceInterface)
    {
        $this->adminService = $adminServiceInterface;
        parent::__construct();
    }

    public function superAdminData()
    {
         $data = new AdminCreateRequest();

         $data->setUserID('superAdmin0');
         $data->setPassword('000');
         $data->setRoles(['ROLE_SUPER_ADMIN']);

         return $data;
    }

    protected function configure()
    {
        $this
            ->setDescription('Creates a super admin user.')
            ->setHelp('This command allows you to create a super admin user...')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        // this method must return an integer number with the "exit status code"
        // of the command. You can also use these constants to make code more readable

        //php profiler
        //check from dev before run
        $io = new SymfonyStyle($input, $output);

        $message = "Creating user with super admin privileges, please wait..";
        $output->writeln($message);
        $io->newLine();

        //$io->progressStart($artistsNumber);

        $data = $this->superAdminData();

        $this->adminService->adminCreate($data);

        $io->progressAdvance();

        $io->newLine();

        $message = "Super Admin had been created successfully!";

        $output->writeln($message);

        $io->newLine();

        return 0;
        // return this if there was no problem running the command
        // (it's equivalent to returning int(0))
        //return Command::SUCCESS;

        // or return this if some error happened during the execution
        // (it's equivalent to returning int(1))
        // return Command::FAILURE;
    }
}