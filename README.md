# 🛠️ devkit

개인 개발 편의용 스크립트 모음 레포

---

## 📁 구조

```
devkit/
└── bash/         # Shell 스크립트 모음
```

---

## 📜 스크립트 목록

### bash/

| 파일 | 설명 |
|------|------|
| `register_ssh_key.sh` | 기존 pem 파일로 새 서버에 SSH 키 등록 및 config 추가 |

---

## 🚀 사용법

```bash
# 실행 권한 부여
chmod +x bash/<script>.sh

# 실행
./bash/<script>.sh [options]
```

각 스크립트별 세부 옵션은 `-h` 플래그로 확인

```bash
./bash/<script>.sh -h
```

---

## 🔧 환경

- **OS**: Ubuntu / macOS
- **Shell**: bash 4.0+
