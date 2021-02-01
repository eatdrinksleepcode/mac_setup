targetGroup=brew

sudo chgrp -R ${targetGroup} $(brew --prefix)/*
sudo chmod -R g+w $(brew --prefix)/*
