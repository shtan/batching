Put script_bsub2 in scripts_folder.
I've put it in the main directory so it can be easily copied.
(Scripts_folder tends to fill up with stuff once jobs are submitted.)

To set up and create scripts:
chmod 755 script_maker.sh
chmod 755 scripts_folder/script_bsub2.sh
source script_maker.sh

This will create a bunch of scripts and put them in scripts_folder.

IMPORTANT: Have to make these runnable:
cd scripts_folder
chmod 755 script*.sh

Otherwise, batch jobs will fail and you will waste time.

Before running, make sure that whatever directory you used as the output directory
in script_template exists.

Now run bsub:
source script_bsub2.sh