#!/bin/bash -eu

# ここ変えるならdocker-compose.ymlの変更も忘れずに
MYSQL_PASSWORD="./mysql/MYSQL_PASSWORD"
MYSQL_ROOT_PASSWORD="./mysql/MYSQL_ROOT_PASSWORD"
FONT_FILE="./zabbix/font.ttf"
# zipで入手可能なttfフォントなら他のフォントでも可
FONT_URL="https://oscdl.ipa.go.jp/IPAexfont/ipaexg00401.zip"

if [ "$(whoami)" != root ];then
    echo "require root"
    exit 1
fi

# MYSQL_PASSWORD自体を400にしてしまうとコンテナ内のmysqlユーザー(おそらくuid 999)から読み取れなくなる
# なので、mysqlディレクトリを400にして中のファイルは644にする(ディレクトリ自体はdocker=rootでマウントされるので400でもOK)
# ｺﾚ ｵﾓｲﾂｲﾀ ｵﾚ ｶｼｺｲ ?
: "mkdir" && {
    tmp="$(dirname "${MYSQL_PASSWORD}")"
    mkdir -pv "${tmp}"
    chmod -v 400 "${tmp}"

    tmp="$(dirname "${MYSQL_ROOT_PASSWORD}")"
    mkdir -pv "${tmp}"
    chmod -v 400 "${tmp}"

    mkdir -pv "$(dirname "${FONT_FILE}")"
}

if [ ! -f "${MYSQL_PASSWORD}" ];then
    echo "Generate: ${MYSQL_PASSWORD}"
    openssl rand -base64 18 > "${MYSQL_PASSWORD}"
    chmod -v 644 "${MYSQL_PASSWORD}"
fi

if [ ! -f "${MYSQL_ROOT_PASSWORD}" ];then
    echo "Generate: ${MYSQL_ROOT_PASSWORD}"
    openssl rand -base64 18 > "${MYSQL_ROOT_PASSWORD}"
    chmod -v 644 "${MYSQL_ROOT_PASSWORD}"
fi

if [ ! -f "${FONT_FILE}" ];then
    echo "Download: Japanese font"
    : "download" && {
        tmp="$(mktemp -d)"
        curl -L -o "${tmp}/font.zip" "${FONT_URL}"
        unzip -d "${tmp}/font" "${tmp}/font.zip"
        # findでttfを探すためフォントの種類が変わっても問題ない
        find "${tmp}/font" -name "*.ttf" -exec mv -v {} "${FONT_FILE}" \;
        rm -rv "${tmp}"
    }
    chmod -v 644 "${FONT_FILE}"
fi
