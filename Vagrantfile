Vagrant.configure("2") do |config|
	config.vm.box = "prowl dev"
	config.vm.box_url = "/Users/gabriel/Dropbox/code/prowl/api/prowl-dev.box"
	config.vm.network :private_network, ip: "7.7.7.7"
	config.vm.hostname = "prowl.dev"
	config.hostsupdater.aliases = ["api.prowl.dev", "app.prowl.dev"]
	config.vm.synced_folder "../", "/code/prowl", type: "nfs"
end
