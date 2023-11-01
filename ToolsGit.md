1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.

git log --pretty=oneline -1 aefea
git show aefea

aefead2207ef7e2aa5dc81a34aedf0cad4c32545 Update CHANGELOG.md

2. Какому тегу соответствует коммит 85024d3?

git log --pretty=oneline -1 85024d3

85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23) v0.12.23

3. Сколько родителей у коммита b8d720? Напишите их хеши.

git cat-file -p b8d720

tree cec002aab630c8bc701cb85bc94e55e751cd2d8f
parent 56cd7859e05c36c06b56d013b55a252d0bb7e158
parent 9ea88f22fc6269854151c571162c5bcf958bee2b

git show b8d720
git log -1 b8d720

commit b8d720f8340221f2146e4e4870bf2ee0bc48f2d5
Merge: 56cd7859e0 9ea88f22fc

git log -1 --pretty=format:"%H: %P" b8d720

b8d720f8340221f2146e4e4870bf2ee0bc48f2d5: 56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b

git log -1 --pretty=format:"Родители: %P" b8d720

Родители: 56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b

4. Перечислите хеши и комментарии всех коммитов, которые были сделаны между тегами v0.12.23 и v0.12.24.

git log --pretty=oneline v0.12.23..v0.12.24

33ff1c03bb960b332be3af2e333462dde88b279e (tag: v0.12.24) v0.12.24
b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links
3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md
6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location
06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md
d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows
4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md
dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md
225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release

5. Найдите коммит, в котором была создана функция func providerSource, её определение в коде выглядит так: func providerSource(...) (вместо троеточия перечислены аргументы).

--- Ищем файл, где находится функция providerSource:
 
git grep --heading 'func providerSource('

provider_source.go
func providerSource(configs []*cliconfig.ProviderInstallation, services *disco.Disco) (getproviders.Source, tfdiags.Diagnostics) {

--- Ищем историю изменения функции providerSource в файле provider_source.go с параметром -L:

git log -L :'func providerSource(':provider_source.go

commit 8c928e83589d90a031f811fae52a81be7153e82f
+func providerSource(services *disco.Disco) getproviders.Source {
+       // We're not yet using the CLI config here because we've not implemented
+       // yet the new configuration constructs to customize provider search
+       // locations. That'll come later.
+       // For now, we have a fixed set of search directories:

--- Либо ищем с помощью регулярного выражения функцию providerSource и отображаем с помощью --reverse от первого созданного комита содержащего функцию providerSource:

git log --oneline -G 'func providerSource\(.*\)' --reverse

--- Первый коммит 8c928e8358 в котором была создана функция providerSource:
8c928e8358 main: Consult local directories as potential mirrors of providers
5af1e6234a main: Honor explicit provider_installation CLI config when present


6. Найдите все коммиты, в которых была изменена функция globalPluginDirs.

--- Ищем файл, где находится функция globalPluginDirs:

git grep --heading 'func globalPluginDirs('

plugins.go
func globalPluginDirs() []string {

--- Ищем историю изменения функции globalPluginDirs в файле plugins.go с параметром -L:

git log -L :'func globalPluginDirs(':plugins.go

78b12205587fe839f10d946ea3fdc06719decb05 Remove config.go and update things using its aliases
52dbf94834cb970b510f2fba853a5b49ad9b1a46 keep .terraform.d/plugins for discovery
41ab0aef7a0fe030e84018973a64135b11abcd70 Add missing OS_ARCH dir to global plugin paths
66ebff90cdfaa6938f26f908c7ebad8d547fea17 move some more plugin search path logic to command
8364383c359a6b738a436d1b7745ccdce178df47 Push plugin discovery down into command package

7. Кто автор функции synchronizedWriters?

--- Ищем функцию synchronizedWriters по регулярному выражению и отображаем с помощью --reverse от первого созданного комита содержащего функцию synchronizedWriters:

git log --oneline -G 'func synchronizedWriters\(.*\)' --reverse

5ac311e2a9 main: synchronize writes to VT100-faker on Windows
bdfea50cc8 remove unused

git log -1 --pretty=format:'Автор: %an' 5ac311e2a9

Автор: Martin Atkins

git log 5ac311e2a9

commit 5ac311e2a91e381e2f52234668b49ba670aa0fe5
Author: Martin Atkins <mart@degeneration.co.uk>


