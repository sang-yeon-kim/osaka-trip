# 오사카 쇼핑 리스트 (Supabase 실시간 동기화)

로컬 파일/브라우저 저장 대신 **Supabase Postgres**에 저장하고, 여러 기기에서 **Realtime**으로 같은 목록을 맞춥니다.

## 1. Supabase 프로젝트

1. [https://supabase.com/dashboard](https://supabase.com/dashboard)에서 프로젝트 생성
2. **SQL Editor**에 `supabase/schema.sql` 전체를 붙여넣고 Run
3. **Project Settings → API**에서
   - Project URL
   - `anon` / `publishable` key  
   를 복사

`schema.sql`은 `shopping_items` 테이블, Realtime publication, anon 읽기/쓰기 정책을 만듭니다.  
anon key를 아는 사람은 목록을 읽고 고칠 수 있으니, 여행용 개인 리스트로만 쓰세요.

## 2. 페이지 열기

GitHub Pages: [https://sang-yeon-kim.github.io/osaka-trip/](https://sang-yeon-kim.github.io/osaka-trip/)

로컬에서 보려면 `file://` 대신 아래처럼 HTTP로 여세요.

```bash
npx --yes serve .
```

또는

```bash
python -m http.server 5500
```

## 3. 연결

1. 상단 **☁️ Supabase 연결** 또는 노란 안내 카드에 URL과 anon key 입력
2. **연결하고 실시간 동기화 시작**
3. 키가 이 브라우저 `localStorage`에 저장됩니다 (서버로 보내지 않음)
4. 클라우드가 비어 있으면 기존 로컬/샘플 목록을 한 번 올립니다
5. 추가·수정·체크·삭제·번역이 바로 DB에 반영되고, 다른 탭/폰은 Realtime으로 따라갑니다

## 데이터 모델

`public.shopping_items`: `id`, `name`, `jp_name`, `category`, `branch`, `price`, `memo`, `completed`, `created_at`, `updated_at`
