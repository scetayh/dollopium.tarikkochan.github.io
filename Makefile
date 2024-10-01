PROJECT_NAME = dollopium
PROJECT_VERSION =
PROJECT_TYPE =
GITHUB_USERNAME = scetayh
GITHUB_REPOSITORY_NAME = dollopium.tarikkochan.github.io

.PHONY: deploy

${PROJECT_NAME}:
	cd hongze-lake-prison-production-safety-knowledge-test && \
	rm -rf debug/* && \
	bash main.sh >> debug/index.html && \
	cp -r sources/js/ debug/
	open hongze-lake-prison-production-safety-knowledge-test/debug/index.html

deploy:
	git remote remove origin
	git remote add origin git@github.com:${GITHUB_USERNAME}/${GITHUB_REPOSITORY_NAME}
	git add .
	-git commit -a -m "v${PROJECT_VERSION}"
	git push --set-upstream origin main