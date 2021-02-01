set -euo pipefail

targetUser=${1:-$(whoami)}
targetGroup=brew

echo "Setting up '${targetUser}' to use Homebrew..."
echo "Loooking for the 'brew' group:"
(dscl . list /Groups | grep "^${targetGroup}$") || (sudo dseditgroup -o create "${targetGroup}" -r "Homebrew users" && echo "Group '${targetGroup}' created")
echo "Checking for membership in the '${targetGroup}' group:"
(id -Gn "${targetUser}" | tr ' ' '\n' | grep "^${targetGroup}$") || (sudo dseditgroup -o edit -a "${targetUser}" -t user "${targetGroup}" && echo "User '${targetUser}' added to group '${targetGroup}'")
