# Ruby Admin — 사용 가이드

## 시작하기

### 1단계 — 서버 실행 (PC에서 1회만)

```bash
bundle install
rails db:migrate
rails db:seed   # 예제 데이터 (선택)
rails server
```

---

## PC에서 사용하기

| 화면 | 주소 |
|------|------|
| 섹션 전체 목록 | `http://localhost:3000` |
| 새 섹션 추가 | `http://localhost:3000/admin/sections/new` |
| 특정 섹션 편집 | 목록에서 **편집** 버튼 클릭 |

---

## 모바일 브라우저에서 사용하기

### 2단계 — PC IP 주소 확인

**Windows:** `시작 → cmd → ipconfig` → IPv4 주소
**Mac:** `시스템 설정 → Wi-Fi → 세부정보` → IP 주소

> 모바일과 PC가 **같은 Wi-Fi**에 연결되어 있어야 합니다.

### 3단계 — 모바일 브라우저 접속

```
http://[PC-IP]:3000/mobile
```

---

## 모바일 앱 연동하기 (React Native / Flutter)

### API 기본 정보

| 항목 | 값 |
|------|----|
| Base URL | `http://[PC-IP]:3000/api/v1` |
| 인증 방식 | 요청 헤더에 `X-API-Token` 포함 |
| 기본 토큰 | `ruby-admin-secret-token-2026` |
| 응답 형식 | JSON |

> 운영 환경에서는 `API_SECRET_TOKEN` 환경변수로 토큰을 교체하세요.

---

### API 엔드포인트

#### 전체 섹션 목록
```
GET /api/v1/sections
```

#### 섹션 상세
```
GET /api/v1/sections/:id
```

#### 모바일 동기화 (진행중 + 완료 섹션만)
```
GET /api/v1/sections/sync
GET /api/v1/sections/sync?since=2026-05-01T00:00:00Z   # 특정 시간 이후 변경분
```

---

### React Native 연동 예시

```javascript
const BASE_URL = 'http://192.168.0.10:3000/api/v1';
const API_TOKEN = 'ruby-admin-secret-token-2026';

const headers = {
  'X-API-Token': API_TOKEN,
  'Content-Type': 'application/json',
};

// 동기화 (진행 중 섹션 포함)
export async function syncSections(since = null) {
  const url = since
    ? `${BASE_URL}/sections/sync?since=${since}`
    : `${BASE_URL}/sections/sync`;

  const res = await fetch(url, { headers });
  return res.json(); // { sections: [...], synced_at: '...', total: N }
}

// 전체 목록
export async function fetchSections() {
  const res = await fetch(`${BASE_URL}/sections`, { headers });
  return res.json();
}

// 섹션 상세
export async function fetchSection(id) {
  const res = await fetch(`${BASE_URL}/sections/${id}`, { headers });
  return res.json();
}
```

---

### Flutter 연동 예시

```dart
const baseUrl = 'http://192.168.0.10:3000/api/v1';
const apiToken = 'ruby-admin-secret-token-2026';

final headers = {
  'X-API-Token': apiToken,
  'Content-Type': 'application/json',
};

// 동기화
Future<Map<String, dynamic>> syncSections({String? since}) async {
  final uri = since != null
      ? Uri.parse('$baseUrl/sections/sync?since=$since')
      : Uri.parse('$baseUrl/sections/sync');

  final response = await http.get(uri, headers: headers);
  return jsonDecode(response.body);
}
```

---

### API 응답 예시

```json
{
  "sections": [
    {
      "id": 3,
      "title": "백엔드 API 개발",
      "description": "REST API 개발 진행 중",
      "status": "in_progress",
      "progress": 65,
      "started_at": null,
      "completed_at": null,
      "updated_at": "2026-05-02T10:30:00+09:00",
      "created_at": "2026-05-01T09:00:00+09:00"
    }
  ],
  "synced_at": "2026-05-02T14:00:00+09:00",
  "total": 1
}
```

---

### 에러 응답

| 상황 | HTTP 코드 | 메시지 |
|------|-----------|--------|
| 토큰 없음/잘못됨 | `401` | 인증이 필요합니다 |
| 섹션 없음 | `404` | 섹션을 찾을 수 없습니다 |
| 파라미터 오류 | `400` | 필수 파라미터가 누락되었습니다 |

---

## 주소 정리

| 용도 | 주소 |
|------|------|
| PC 관리자 화면 | `http://localhost:3000` |
| 모바일 브라우저 뷰 | `http://[PC-IP]:3000/mobile` |
| 모바일 앱 API | `http://[PC-IP]:3000/api/v1/sections/sync` |
