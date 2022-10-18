import sys

pathname = sys.argv[1]

# profile-videzzo-qemu-xhci-arp-0-1663674034
items = pathname.split('-')
assert(len(items) == 7)
print(items[-1])
