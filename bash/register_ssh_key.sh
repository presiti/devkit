#!/bin/bash
# register_ssh_key.sh

set -e

PEM_FILE="$HOME/.ssh/my-key.pem"  # 고정 pem 파일 경로

usage() {
    echo "Usage: $0 -h <host_ip> -n <hostname> [-p <port>] [-u <user>]"
    echo ""
    echo "  -h  서버 IP 또는 도메인"
    echo "  -n  ~/.ssh/config 에 등록할 Host 별칭"
    echo "  -p  SSH 포트 (기본값: 22)"
    echo "  -u  SSH 사용자 (기본값: ubuntu)"
    exit 1
}

PORT=22
USER="ubuntu"

while getopts "h:n:p:u:" opt; do
    case $opt in
        h) HOST="$OPTARG" ;;
        n) HOSTNAME="$OPTARG" ;;
        p) PORT="$OPTARG" ;;
        u) USER="$OPTARG" ;;
        *) usage ;;
    esac
done

[ -z "$HOST" ] || [ -z "$HOSTNAME" ] && usage

# pem 파일 권한 자동 수정
chmod 600 "$PEM_FILE"

# authorized_keys에 공개키 등록
echo "🔑 공개키 등록 중..."
ssh-keygen -y -f "$PEM_FILE" | ssh -i "$PEM_FILE" -p "$PORT" -o StrictHostKeyChecking=no \
    "$USER@$HOST" "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"

# ~/.ssh/config에 Host 블록 추가
echo "" >> ~/.ssh/config
cat >> ~/.ssh/config <<EOF
Host $HOSTNAME
    HostName $HOST
    User $USER
    Port $PORT
    IdentityFile $PEM_FILE
EOF

echo "✅ 완료! 이제 'ssh $HOSTNAME' 으로 접속 가능합니다."
