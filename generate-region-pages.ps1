$ErrorActionPreference = "Stop"
$outputDirectory = Join-Path $PSScriptRoot "regions"
New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null

$regions = @(
  [ordered]@{ Name="청주시"; Slug="cheongju-si"; En="CHEONGJU"; Places="상당구·서원구·흥덕구·청원구"; Summary="청주시 4개 구의 학교 진도와 학생별 학습 목표를 반영해 개념부터 내신·수능까지 수업을 설계합니다."; Focus="학교별 시험 일정과 단원 진도를 놓치지 않도록 주차별 학습 계획을 세웁니다." },
  [ordered]@{ Name="충주시"; Slug="chungju-si"; En="CHUNGJU"; Places="연수동·호암동·칠금동·용산동·교현동"; Summary="충주시 학생의 현재 개념 이해도와 학교 진도를 살펴 초등 기초부터 중등 내신, 고등 수능까지 연결합니다."; Focus="학교 진도에 맞춘 개념 정리와 반복되는 오답의 원인을 함께 관리합니다." },
  [ordered]@{ Name="제천시"; Slug="jecheon-si"; En="JECHEON"; Places="청전동·하소동·장락동·신백동"; Summary="제천시 초·중·고 학생에게 필요한 개념의 빈틈을 찾고 목표에 맞는 1:1 수학 학습 순서를 제안합니다."; Focus="진도와 복습의 균형을 잡아 배운 내용을 스스로 다시 풀 수 있게 돕습니다." },
  [ordered]@{ Name="보은군"; Slug="boeun-gun"; En="BOEUN"; Places="보은읍·속리산면·삼승면"; Summary="보은군 학생의 학년과 학습 환경을 고려해 기초 개념, 학교 시험, 상급 학년 준비를 차근차근 연결합니다."; Focus="학생의 속도에 맞춘 설명과 복습 점검으로 혼자 공부하는 힘을 기릅니다." },
  [ordered]@{ Name="옥천군"; Slug="okcheon-gun"; En="OKCHEON"; Places="옥천읍·이원면·동이면"; Summary="옥천군 초·중·고 학생의 학교 진도와 목표를 반영해 개념 이해부터 문제 적용까지 1:1로 지도합니다."; Focus="취약 단원을 정확히 찾고 내신 범위에 맞춰 풀이 정확도를 높입니다." },
  [ordered]@{ Name="영동군"; Slug="yeongdong-gun"; En="YEONGDONG"; Places="영동읍·황간면·용산면"; Summary="영동군 학생이 수학의 흐름을 놓치지 않도록 현재 실력을 진단하고 학년별 핵심 개념을 연결합니다."; Focus="기초가 부족한 단원은 다시 다지고, 잘하는 영역은 심화 문제로 확장합니다." },
  [ordered]@{ Name="증평군"; Slug="jeungpyeong-gun"; En="JEUNGPYEONG"; Places="증평읍·도안면"; Summary="증평군 학생의 교과 진도와 시험 계획에 맞춰 개념, 유형, 오답 복습이 이어지는 수업을 만듭니다."; Focus="짧은 기간에도 우선순위를 분명히 정해 필요한 단원부터 집중합니다." },
  [ordered]@{ Name="진천군"; Slug="jincheon-gun"; En="JINCHEON"; Places="진천읍·덕산읍·광혜원면"; Summary="진천군과 충북혁신도시 학생의 학습 수준을 살펴 학교별 내신과 상급 학년 준비를 함께 설계합니다."; Focus="새로운 학교 환경과 진도 차이에도 흔들리지 않도록 개인별 계획을 세웁니다." },
  [ordered]@{ Name="괴산군"; Slug="goesan-gun"; En="GOESAN"; Places="괴산읍·청천면·칠성면"; Summary="괴산군 학생의 개념 이해와 문제 풀이 습관을 확인하고 목표까지 이어지는 현실적인 수학 계획을 세웁니다."; Focus="수업과 자기주도 학습이 연결되도록 과제와 오답 복습을 꾸준히 점검합니다." },
  [ordered]@{ Name="음성군"; Slug="eumseong-gun"; En="EUMSEONG"; Places="음성읍·금왕읍·대소면·맹동면"; Summary="음성군과 충북혁신도시 초·중·고 학생을 위해 학교 진도, 시험 범위, 목표에 맞는 1:1 수업을 진행합니다."; Focus="개념 설명부터 유형 적용, 서술형 풀이까지 학생의 속도에 맞춰 연결합니다." },
  [ordered]@{ Name="단양군"; Slug="danyang-gun"; En="DANYANG"; Places="단양읍·매포읍"; Summary="단양군 학생이 거리와 환경에 관계없이 꾸준한 학습 흐름을 만들 수 있도록 수학 공부를 설계합니다."; Focus="학습 공백을 세밀하게 확인하고 매주 성취도를 점검해 다음 공부를 정합니다." },
  [ordered]@{ Name="청주시 상당구"; Slug="cheongju-sangdang-gu"; En="SANGDANG-GU"; Places="용암동·금천동·용담동·영운동"; Summary="청주시 상당구 학생의 학교 진도와 수학 고민을 살펴 개념, 내신, 상급 학년 준비를 1:1로 지도합니다."; Focus="상당구 학교별 시험 일정에 맞춰 취약 단원과 오답을 집중 관리합니다." },
  [ordered]@{ Name="청주시 서원구"; Slug="cheongju-seowon-gu"; En="SEOWON-GU"; Places="산남동·분평동·사창동·수곡동"; Summary="청주시 서원구 초·중·고 학생의 현재 실력을 진단하고 학교 진도와 목표에 맞는 수학 수업을 설계합니다."; Focus="개념을 문제에 적용하는 과정을 반복해 내신과 서술형 대응력을 높입니다." },
  [ordered]@{ Name="청주시 흥덕구"; Slug="cheongju-heungdeok-gu"; En="HEUNGDEOK-GU"; Places="복대동·가경동·오송읍·강서동"; Summary="청주시 흥덕구 학생을 위해 학교별 진도와 학습 속도를 반영한 초·중·고 1:1 수학 수업을 제공합니다."; Focus="오송과 복대·가경 지역의 다양한 학교 진도에 맞춰 개인별 계획을 조정합니다." },
  [ordered]@{ Name="청주시 청원구"; Slug="cheongju-cheongwon-gu"; En="CHEONGWON-GU"; Places="율량동·주성동·오창읍·내수읍"; Summary="청주시 청원구 학생의 개념 빈틈과 풀이 습관을 확인해 내신과 수능으로 이어지는 학습 기반을 만듭니다."; Focus="오창과 율량·주성 지역 학생의 학교 일정과 목표에 맞춰 수업 속도를 조절합니다." }
)

foreach ($region in $regions) {
  $description = "$($region.Name) 초등·중등·고등 1:1 수학과외. $($region.Summary)"
  $html = @"
<!doctype html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="$description">
  <meta name="theme-color" content="#14362f">
  <meta property="og:type" content="website">
  <meta property="og:title" content="$($region.Name) 수학과외 | 충북 1:1 맞춤 수업">
  <meta property="og:description" content="$($region.Summary)">
  <meta property="og:url" content="https://tutorway.kr/regions/$($region.Slug).html">
  <link rel="canonical" href="https://tutorway.kr/regions/$($region.Slug).html">
  <link rel="icon" href="../favicon.svg" type="image/svg+xml">
  <title>$($region.Name) 수학과외 | 초중고 1:1 맞춤 수업</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@700&family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../region-page.css">
</head>
<body data-region="$($region.Name)">
  <header class="site-header">
    <a class="brand" href="../"><span class="brand-symbol" aria-hidden="true">∫</span><span>충북 수학과외<small>TUTORWAY</small></span></a>
    <a class="back-link" href="../#areas">전체 지역 보기</a>
  </header>
  <main>
    <section class="hero" aria-labelledby="region-title">
      <div class="hero-content">
        <p class="eyebrow">$($region.En) 1:1 MATH TUTORING</p>
        <h1 id="region-title">$($region.Name) 수학과외,<br><em>학생에게 맞는 공부의 순서</em></h1>
        <p class="hero-copy">$($region.Summary)</p>
        <div class="hero-actions"><a class="primary-button" href="../#contact">무료 학습 상담</a><a class="phone-link" href="tel:01029283614">010-2928-3614</a></div>
      </div>
    </section>
    <section class="section diagnosis">
      <div class="section-heading"><p class="eyebrow dark">PERSONAL DIAGNOSIS</p><h2>점수보다 먼저<br>막힌 이유를 찾습니다.</h2></div>
      <p class="section-copy">$($region.Focus) 성적표만 보는 것이 아니라 개념을 설명하는 방식, 문제를 읽는 순서, 오답을 다시 푸는 습관까지 확인합니다.</p>
      <div class="feature-grid">
        <article><span>01 / CHECK</span><h3>현재 실력 진단</h3><p>개념 이해도와 풀이 과정을 확인해 놓친 부분을 정확히 찾습니다.</p></article>
        <article><span>02 / PLAN</span><h3>개인별 학습 설계</h3><p>학교 진도와 목표, 학습 속도를 반영해 주차별 계획을 세웁니다.</p></article>
        <article><span>03 / REVIEW</span><h3>복습과 오답 관리</h3><p>수업에서 배운 내용이 혼자 공부하는 시간까지 이어지도록 점검합니다.</p></article>
      </div>
    </section>
    <section class="local-band"><div><p class="eyebrow">LOCAL AREA</p><h2>$($region.Name)<br>주요 상담 지역</h2></div><div class="place-list">$((($region.Places -split '·') | ForEach-Object { "<span>$($_.Trim())</span>" }) -join '')</div></section>
    <section class="section grade-guide">
      <div class="section-heading"><p class="eyebrow dark">GRADE PROGRAM</p><h2>학년별 목표에 맞춘<br>수학 학습 설계</h2></div>
      <p class="grade-transition">예비중1·예비중2·예비중3, 예비고1·예비고2·예비고3 학생은 새 학년 진도와 현재 실력을 함께 확인해 필요한 선행과 복습의 범위를 조정합니다.</p>
      <div class="grade-grid">
        <article><strong>초등</strong><h3>기초와 자신감</h3><p>연산 정확도와 교과 개념을 다지고 풀이를 설명하는 습관을 만듭니다.</p></article>
        <article><strong>중등</strong><h3>개념과 내신</h3><p>단원별 개념을 연결하고 학교 시험 유형에 맞춰 정확도와 속도를 높입니다.</p></article>
        <article><strong>고등</strong><h3>내신과 수능</h3><p>목표에 따라 개념, 기출, 실전 문제의 비중을 조절해 학습합니다.</p></article>
      </div>
    </section>
    <section class="section region-navigation"><p class="eyebrow dark">CHUNGBUK 15 AREAS</p><h2>충북 지역별 수학과외</h2><nav class="region-links" aria-label="충북 지역별 수학과외"></nav></section>
    <section class="cta"><p>START YOUR WAY</p><h2>$($region.Name) 수학과외,<br>편하게 상담해 보세요.</h2><div><a class="primary-button" href="../#contact">상담 신청하기</a><a class="phone-link" href="tel:01029283614">010-2928-3614</a></div></section>
  </main>
  <footer class="site-footer"><span>충북 수학과외 · 초중고 1:1 맞춤 수업</span><span>© <span id="year"></span> TUTORWAY.</span></footer>
  <a class="floating-contact" href="../#contact">무료 상담 신청</a>
  <script src="../region-page.js"></script>
</body>
</html>
"@
  Set-Content -Path (Join-Path $outputDirectory "$($region.Slug).html") -Value $html -Encoding UTF8
}

Write-Host "Generated $($regions.Count) regional pages."