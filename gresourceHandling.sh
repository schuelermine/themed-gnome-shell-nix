# extractGresource srcPath destPath
extractGresources() {
    srcPath=$1
    destPath=$2

    resList=$(gresource list $srcPath)

    for resName in resList;
    do
        resDir=$(dirname $resName)
        mkdir -p $destPath/$resDir
        gresource extract $srcPath $resName > $destPath/$resName
    done
}
