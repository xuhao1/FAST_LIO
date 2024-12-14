all: arm64

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build              - build all images"
	# @echo "   1. make pull             - pull all images"
	@echo "   1. make clean              - remove all images"
	@echo ""

arm64:
	@docker build --platform=linux/arm64 -t fastlio2:arm64 -f ./Dockerfile .  

pc:
	@docker build --platform=linux/amd64 -t fastlio2:amd64 -f ./Dockerfile .  

upload_arm64: arm64
	@docker tag fastlio2:arm64 buaadocker.xuhao1.me/swarmtal_control:arm64
	@docker push buaadocker.xuhao1.me/swarmtal_control:arm64

upload_amd64: pc
	@docker tag fastlio2:amd64 buaadocker.xuhao1.me/swarmtal_control:amd64
	@docker push buaadocker.xuhao1.me/swarmtal_control:amd64

upload: upload_amd64 upload_arm64

clean:
	@docker rmi -f buaadocker.xuhao1.me/swarmtal_control
