$ErrorActionPreference = "Stop"
$outputDirectory = Join-Path $PSScriptRoot "regions"
New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
$siteUrl = "https://tutorway.kr"
$phone = "010-2928-3614"
$today = Get-Date -Format "yyyy-MM-dd"

$regions = @(
  [ordered]@{ Name="청주시"; Short="청주"; Slug="cheongju-si"; En="CHEONGJU"; Places="상당구·서원구·흥덕구·청원구"; Summary="청주시 4개 구의 학교 진도와 학생별 학습 목표를 반영해 개념부터 내신·수능까지 수업을 설계합니다."; Focus="학교별 시험 일정과 단원 진도를 놓치지 않도록 주차별 학습 계획을 세웁니다." },
  [ordered]@{ Name="충주시"; Short="충주"; Slug="chungju-si"; En="CHUNGJU"; Places="연수동·호암동·칠금동·용산동·교현동"; Summary="충주시 학생의 현재 개념 이해도와 학교 진도를 살펴 초등 기초부터 중등 내신, 고등 수능까지 연결합니다."; Focus="학교 진도에 맞춘 개념 정리와 반복되는 오답의 원인을 함께 관리합니다." },
  [ordered]@{ Name="제천시"; Short="제천"; Slug="jecheon-si"; En="JECHEON"; Places="청전동·하소동·장락동·신백동"; Summary="제천시 초·중·고 학생에게 필요한 개념의 빈틈을 찾고 목표에 맞는 1:1 수학 학습 순서를 제안합니다."; Focus="진도와 복습의 균형을 잡아 배운 내용을 스스로 다시 풀 수 있게 돕습니다." },
  [ordered]@{ Name="보은군"; Short="보은"; Slug="boeun-gun"; En="BOEUN"; Places="보은읍·속리산면·삼승면"; Summary="보은군 학생의 학년과 학습 환경을 고려해 기초 개념, 학교 시험, 상급 학년 준비를 차근차근 연결합니다."; Focus="학생의 속도에 맞춘 설명과 복습 점검으로 혼자 공부하는 힘을 기릅니다." },
  [ordered]@{ Name="옥천군"; Short="옥천"; Slug="okcheon-gun"; En="OKCHEON"; Places="옥천읍·이원면·동이면"; Summary="옥천군 초·중·고 학생의 학교 진도와 목표를 반영해 개념 이해부터 문제 적용까지 1:1로 지도합니다."; Focus="취약 단원을 정확히 찾고 내신 범위에 맞춰 풀이 정확도를 높입니다." },
  [ordered]@{ Name="영동군"; Short="영동"; Slug="yeongdong-gun"; En="YEONGDONG"; Places="영동읍·황간면·용산면"; Summary="영동군 학생이 수학의 흐름을 놓치지 않도록 현재 실력을 진단하고 학년별 핵심 개념을 연결합니다."; Focus="기초가 부족한 단원은 다시 다지고, 잘하는 영역은 심화 문제로 확장합니다." },
  [ordered]@{ Name="증평군"; Short="증평"; Slug="jeungpyeong-gun"; En="JEUNGPYEONG"; Places="증평읍·도안면"; Summary="증평군 학생의 교과 진도와 시험 계획에 맞춰 개념, 유형, 오답 복습이 이어지는 수업을 만듭니다."; Focus="짧은 기간에도 우선순위를 분명히 정해 필요한 단원부터 집중합니다." },
  [ordered]@{ Name="진천군"; Short="진천"; Slug="jincheon-gun"; En="JINCHEON"; Places="진천읍·덕산읍·광혜원면"; Summary="진천군과 충북혁신도시 학생의 학습 수준을 살펴 학교별 내신과 상급 학년 준비를 함께 설계합니다."; Focus="새로운 학교 환경과 진도 차이에도 흔들리지 않도록 개인별 계획을 세웁니다." },
  [ordered]@{ Name="괴산군"; Short="괴산"; Slug="goesan-gun"; En="GOESAN"; Places="괴산읍·청천면·칠성면"; Summary="괴산군 학생의 개념 이해와 문제 풀이 습관을 확인하고 목표까지 이어지는 현실적인 수학 계획을 세웁니다."; Focus="수업과 자기주도 학습이 연결되도록 과제와 오답 복습을 꾸준히 점검합니다." },
  [ordered]@{ Name="음성군"; Short="음성"; Slug="eumseong-gun"; En="EUMSEONG"; Places="음성읍·금왕읍·대소면·맹동면"; Summary="음성군과 충북혁신도시 초·중·고 학생을 위해 학교 진도, 시험 범위, 목표에 맞는 1:1 수업을 진행합니다."; Focus="개념 설명부터 유형 적용, 서술형 풀이까지 학생의 속도에 맞춰 연결합니다." },
  [ordered]@{ Name="단양군"; Short="단양"; Slug="danyang-gun"; En="DANYANG"; Places="단양읍·매포읍"; Summary="단양군 학생이 거리와 환경에 관계없이 꾸준한 학습 흐름을 만들 수 있도록 수학 공부를 설계합니다."; Focus="학습 공백을 세밀하게 확인하고 매주 성취도를 점검해 다음 공부를 정합니다." },
  [ordered]@{ Name="청주시 상당구"; Short="상당구"; Slug="cheongju-sangdang-gu"; En="SANGDANG-GU"; Places="용암동·금천동·용담동·영운동"; Summary="청주시 상당구 학생의 학교 진도와 수학 고민을 살펴 개념, 내신, 상급 학년 준비를 1:1로 지도합니다."; Focus="상당구 학교별 시험 일정에 맞춰 취약 단원과 오답을 집중 관리합니다." },
  [ordered]@{ Name="청주시 서원구"; Short="서원구"; Slug="cheongju-seowon-gu"; En="SEOWON-GU"; Places="산남동·분평동·사창동·수곡동"; Summary="청주시 서원구 초·중·고 학생의 현재 실력을 진단하고 학교 진도와 목표에 맞는 수학 수업을 설계합니다."; Focus="개념을 문제에 적용하는 과정을 반복해 내신과 서술형 대응력을 높입니다." },
  [ordered]@{ Name="청주시 흥덕구"; Short="흥덕구"; Slug="cheongju-heungdeok-gu"; En="HEUNGDEOK-GU"; Places="복대동·가경동·오송읍·강서동"; Summary="청주시 흥덕구 학생을 위해 학교별 진도와 학습 속도를 반영한 초·중·고 1:1 수학 수업을 제공합니다."; Focus="오송과 복대·가경 지역의 다양한 학교 진도에 맞춰 개인별 계획을 조정합니다." },
  [ordered]@{ Name="청주시 청원구"; Short="청원구"; Slug="cheongju-cheongwon-gu"; En="CHEONGWON-GU"; Places="율량동·주성동·오창읍·내수읍"; Summary="청주시 청원구 학생의 개념 빈틈과 풀이 습관을 확인해 내신과 수능으로 이어지는 학습 기반을 만듭니다."; Focus="오창과 율량·주성 지역 학생의 학교 일정과 목표에 맞춰 수업 속도를 조절합니다." }
)

# {R} = 지역명, {S} = 짧은 지역명, {P} = 주요 동·읍·면
$grades = @(
  [ordered]@{
    Key="elementary"; Label="초등"; En="ELEMENTARY"; Card="기초와 자신감"
    TitleTail="기초수학·수학공부 1:1 수업"
    Tagline="개념과 연산이 단단해지는 시간"
    Description="{R} 초등 수학과외 - 연산·기초수학부터 교과 개념과 서술형까지, 초1~초6 학생별 1:1 수학수업과 수학공부 습관 관리. {P} 상담 010-2928-3614"
    Intro="{R} 초등학생의 연산 정확도와 교과 개념 이해도를 먼저 확인하고, 스스로 풀이를 설명할 수 있을 때까지 1:1로 지도합니다."
    CardText="연산 정확도와 교과 개념을 다지고 풀이를 설명하는 습관을 만듭니다."
    Topics=@(
      @("수학수업", "{R} 초등 수학수업은 교과서 개념을 학생이 자신의 말로 설명할 수 있을 때까지 진행합니다. 학교 진도에 맞춰 단원별 핵심을 정리하고, 배운 내용을 바로 문제에 적용해 봅니다."),
      @("수학공부", "{R} 초등 수학공부는 매일 짧게라도 꾸준히 하는 습관이 중요합니다. 학생 수준에 맞는 과제 분량을 정하고, 틀린 문제를 다시 풀어 보는 오답 습관을 함께 만듭니다."),
      @("기초수학", "{R} 초등 기초수학은 사칙연산, 분수와 소수, 도형의 기본 개념처럼 다음 학년의 바탕이 되는 내용을 다시 점검합니다. 연산 실수가 잦다면 원인부터 찾아 정확도를 높입니다."),
      @("서술형 수학", "문장제와 서술형 문제는 문제를 끝까지 읽고 조건을 정리하는 연습부터 시작합니다. 식을 세우는 이유를 말로 설명하며 풀이 과정을 쓰는 힘을 기릅니다.")
    )
    Years=@(
      @("초1·초2", "수 세기, 덧셈과 뺄셈, 곱셈구구를 정확하게 익혀 바른 연산 습관을 만듭니다."),
      @("초3·초4", "나눗셈, 분수와 소수의 첫 개념, 도형을 정리하고 문장제를 읽는 힘을 기릅니다."),
      @("초5·초6", "약수와 배수, 분수의 계산, 비와 비율처럼 중등 수학의 바탕이 되는 단원을 집중 관리합니다."),
      @("예비중1", "초등 핵심 단원의 빈틈을 메우고 중1 수학의 정수와 유리수, 문자와 식을 미리 익힙니다.")
    )
    Faq=@(
      @("{R} 초등 수학과외는 몇 학년부터 가능한가요?", "초등 1학년부터 6학년까지 가능합니다. 학년보다 현재 이해도를 먼저 확인해 연산, 교과 개념, 서술형 중 필요한 부분부터 시작합니다."),
      @("초등 기초수학이 많이 부족해도 수업을 받을 수 있나요?", "가능합니다. 어느 단원에서 막혔는지 진단한 뒤 이전 학년 내용까지 필요한 만큼 되짚어 기초를 다시 다집니다."),
      @("{R} 어느 지역에서 수업을 받을 수 있나요?", "{P} 등 {R} 학생과 상담하고 있습니다. 방문 수업 가능 여부와 일정은 전화 상담 시 안내해 드립니다.")
    )
  },
  [ordered]@{
    Key="middle"; Label="중등"; En="MIDDLE SCHOOL"; Card="개념과 내신"
    TitleTail="수학내신·기초수학 1:1 수업"
    Tagline="개념을 연결하고 내신을 다지는 시간"
    Description="{R} 중등 수학과외 - 중1·중2·중3 수학내신과 기초수학, 학교별 시험 범위에 맞춘 1:1 수학수업과 수학공부 관리. {P} 상담 010-2928-3614"
    Intro="{R} 중학생의 학교 진도와 시험 범위를 기준으로 개념, 유형, 서술형, 오답 관리가 이어지는 1:1 수학 수업을 설계합니다."
    CardText="단원별 개념을 연결하고 학교 시험 유형에 맞춰 정확도와 속도를 높입니다."
    Topics=@(
      @("수학수업", "{R} 중등 수학수업은 학교 진도와 교과서·부교재 범위를 기준으로 개념 설명, 유형 연습, 오답 정리를 한 흐름으로 진행합니다."),
      @("수학공부", "{R} 중등 수학공부는 개념 복습과 문제 풀이의 균형이 중요합니다. 주차별 학습 계획과 과제 점검으로 혼자 공부하는 시간까지 관리합니다."),
      @("기초수학", "{R} 중등 기초수학은 정수와 유리수, 문자와 식, 방정식과 함수처럼 막히기 쉬운 단원을 다시 정리합니다. 초등 과정의 빈틈이 있다면 필요한 부분부터 되짚습니다."),
      @("수학내신", "{R} 중등 수학내신은 학교별 시험 범위와 출제 경향을 확인해 준비합니다. 시험 4주 전부터 단원 점검, 서술형 풀이, 실전 연습 순서로 대비합니다.")
    )
    Years=@(
      @("중1", "정수와 유리수, 일차방정식, 좌표평면과 그래프로 중등 수학의 기초를 세웁니다."),
      @("중2", "연립방정식과 일차함수, 도형의 성질을 정리하고 내신 서술형에 대비합니다."),
      @("중3", "제곱근과 이차방정식, 이차함수를 다지며 고등 수학으로 넘어갈 준비를 합니다."),
      @("예비고1", "중등 핵심 단원을 점검하고 고1 공통수학 개념을 미리 익혀 첫 내신을 준비합니다.")
    )
    Faq=@(
      @("{R} 중등 수학내신은 언제부터 준비하나요?", "평소에는 학교 진도에 맞춰 개념과 유형을 정리하고, 시험 4주 전부터 학교별 시험 범위에 맞춘 내신 대비를 진행합니다."),
      @("중학교 기초수학이 부족한데 따라갈 수 있을까요?", "1:1 수업이라 학생의 속도에 맞출 수 있습니다. 진단으로 빈틈이 있는 단원을 찾고, 현재 진도와 병행해 필요한 기초를 함께 보완합니다."),
      @("{R} 어느 지역에서 수업을 받을 수 있나요?", "{P} 등 {R} 학생과 상담하고 있습니다. 방문 수업 가능 여부와 일정은 전화 상담 시 안내해 드립니다.")
    )
  },
  [ordered]@{
    Key="high"; Label="고등"; En="HIGH SCHOOL"; Card="내신과 수능"
    TitleTail="수학내신·수능수학 1:1 대비"
    Tagline="내신과 수능을 함께 준비하는 시간"
    Description="{R} 고등 수학과외 - 고1·고2·고3 수학내신, 수능대비·수능수학까지 목표 등급에 맞춘 1:1 수학수업. {P} 상담 010-2928-3614"
    Intro="{R} 고등학생의 과목, 학교 시험 일정, 목표 등급을 함께 살펴 내신과 수능 대비의 비중을 조절하는 1:1 수학 수업을 진행합니다."
    CardText="목표에 따라 개념, 기출, 실전 문제의 비중을 조절해 학습합니다."
    Topics=@(
      @("수학수업", "{R} 고등 수학수업은 공통수학부터 대수, 미적분, 확률과 통계까지 학생이 배우는 과목과 목표에 맞춰 개념과 문제 풀이의 비중을 조절합니다."),
      @("수학공부", "{R} 고등 수학공부는 개념 이해, 기출 분석, 오답 관리가 이어져야 합니다. 학생의 학습 시간과 다른 과목 일정까지 고려해 현실적인 계획을 세웁니다."),
      @("기초수학", "{R} 고등 기초수학은 방정식, 함수, 도형처럼 고등 수학의 바탕이 되는 중학교 과정을 빠르게 점검하고 필요한 부분만 집중해서 보완합니다."),
      @("수학내신", "{R} 고등 수학내신은 학교별 교과서와 부교재, 기출 경향을 분석해 서술형과 고난도 문항까지 대비합니다."),
      @("수능대비", "{R} 고등 수능대비는 학년과 목표 등급에 맞춰 개념 완성, 기출 분석, 실전 모의고사 순서로 진행합니다."),
      @("수능수학", "{R} 수능수학은 기출 문제를 중심으로 출제 의도를 읽는 연습을 하고, 시간 배분과 실수 관리까지 함께 훈련합니다.")
    )
    Years=@(
      @("고1", "공통수학 개념을 탄탄히 하고 첫 내신과 학력평가에 대비합니다."),
      @("고2", "선택 과목의 개념과 내신을 관리하면서 수능 기출 학습을 시작합니다."),
      @("고3", "목표 등급에 맞춰 수능 기출과 실전 모의고사로 마무리합니다."),
      @("N수생", "지난 시험의 약점을 분석해 개념 보완과 실전 훈련의 순서를 다시 설계합니다.")
    )
    Faq=@(
      @("{R} 고등 수학과외는 내신과 수능 중 무엇에 집중하나요?", "학년과 목표에 따라 비중을 조절합니다. 고1·고2는 내신과 개념을 중심으로, 고3은 수능 기출과 실전 연습의 비중을 높입니다."),
      @("수능수학 대비는 언제 시작하는 것이 좋나요?", "개념이 정리된 단원부터 기출 문제를 함께 풀어 보는 것이 좋습니다. 고2부터 기출 학습을 시작하면 고3 실전 대비가 수월해집니다."),
      @("{R} 어느 지역에서 수업을 받을 수 있나요?", "{P} 등 {R} 학생과 상담하고 있습니다. 방문 수업 가능 여부와 일정은 전화 상담 시 안내해 드립니다.")
    )
  }
)

function Fill($text, $region) {
  return $text.Replace('{R}', $region.Name).Replace('{S}', $region.Short).Replace('{P}', ($region.Places -replace '·', ', '))
}

function Get-RegionLinks($currentSlug, $grade) {
  return ($regions | ForEach-Object {
    $suffix = if ($grade) { "-$($grade.Key)" } else { "" }
    $label = if ($grade) { "$($_.Short) $($grade.Label) 수학" } else { "$($_.Short) 수학과외" }
    $current = if ($_.Slug -eq $currentSlug) { ' aria-current="page"' } else { '' }
    "<a href=`"$($_.Slug)$suffix.html`"$current>$label</a>"
  }) -join ''
}

function Get-FaqHtml($faq) {
  return ($faq | ForEach-Object { "<details><summary>$($_[0])</summary><p>$($_[1])</p></details>" }) -join ''
}

function Get-JsonLd($url, $name, $description, $breadcrumbs, $faq) {
  $items = @()
  for ($i = 0; $i -lt $breadcrumbs.Count; $i++) {
    $items += [ordered]@{ "@type"="ListItem"; position=$i + 1; name=$breadcrumbs[$i][0]; item=$breadcrumbs[$i][1] }
  }
  $graph = @(
    [ordered]@{ "@type"="Service"; name=$name; description=$description; url=$url; serviceType="수학과외"; areaServed="충청북도"; provider=[ordered]@{ "@type"="EducationalOrganization"; name="충북 수학과외"; url="$siteUrl/"; telephone="+82-10-2928-3614" } },
    [ordered]@{ "@type"="BreadcrumbList"; itemListElement=$items },
    [ordered]@{ "@type"="FAQPage"; mainEntity=@($faq | ForEach-Object { [ordered]@{ "@type"="Question"; name=$_[0]; acceptedAnswer=[ordered]@{ "@type"="Answer"; text=$_[1] } } }) }
  )
  return ([ordered]@{ "@context"="https://schema.org"; "@graph"=$graph } | ConvertTo-Json -Depth 8 -Compress)
}

function Get-Page($page) {
  return @"
<!doctype html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="$($page.Description)">
  <meta name="theme-color" content="#14362f">
  <meta property="og:type" content="website">
  <meta property="og:locale" content="ko_KR">
  <meta property="og:site_name" content="충북 수학과외">
  <meta property="og:title" content="$($page.Title)">
  <meta property="og:description" content="$($page.Description)">
  <meta property="og:url" content="$($page.Url)">
  <link rel="canonical" href="$($page.Url)">
  <link rel="icon" href="../favicon.svg" type="image/svg+xml">
  <title>$($page.Title)</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@700&family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../region-page.css">
  <script type="application/ld+json">$($page.JsonLd)</script>
</head>
<body>
  <header class="site-header">
    <a class="brand" href="../"><span class="brand-symbol" aria-hidden="true">∫</span><span>충북 수학과외<small>TUTORWAY</small></span></a>
    <a class="back-link" href="$($page.BackHref)">$($page.BackText)</a>
  </header>
  <main>
$($page.Main)
  </main>
  <footer class="site-footer"><span>충북 수학과외 · 초중고 1:1 맞춤 수업 · 상담 <a href="tel:01029283614">$phone</a></span><span>© <span id="year"></span> TUTORWAY.</span></footer>
  <a class="floating-contact" href="tel:01029283614">전화 상담 $phone</a>
  <script src="../region-page.js"></script>
</body>
</html>
"@
}

function Write-Page($fileName, $html) {
  Set-Content -Path (Join-Path $outputDirectory $fileName) -Value $html -Encoding UTF8
}

$sitemapUrls = @("$siteUrl/")

foreach ($region in $regions) {
  $regionUrl = "$siteUrl/regions/$($region.Slug).html"
  $places = (($region.Places -split '·') | ForEach-Object { "<span>$($_.Trim())</span>" }) -join ''
  $localBand = "    <section class=`"local-band`"><div><p class=`"eyebrow`">LOCAL AREA</p><h2>$($region.Name)<br>주요 상담 지역</h2></div><div class=`"place-list`">$places</div></section>"
  $cta = "    <section class=`"cta`"><p>START YOUR WAY</p><h2>$($region.Name) 수학과외,<br>편하게 상담해 보세요.</h2><div><a class=`"primary-button`" href=`"tel:01029283614`">전화 상담하기</a><a class=`"phone-link`" href=`"tel:01029283614`">$phone</a></div></section>"

  # 지역 대표 페이지
  $gradeCards = ($grades | ForEach-Object {
    $keywords = ($_.Topics | ForEach-Object { $_[0] }) -join ' · '
    "<a class=`"grade-card`" href=`"$($region.Slug)-$($_.Key).html`"><strong>$($_.Label)</strong><h3>$($region.Short) $($_.Label) 수학과외</h3><p>$($_.CardText)</p><span class=`"keyword-line`">$keywords</span><em>$($_.Label) 수업 자세히 보기 →</em></a>"
  }) -join ''
  $regionFaq = @(
    @("$($region.Name) 수학과외는 어떤 학생이 받을 수 있나요?", "초등·중등·고등 학생 모두 가능합니다. 초등 기초수학, 중등 수학내신, 고등 수능수학까지 학생의 학년과 목표에 맞춰 수업을 설계합니다."),
    @("수업은 어떻게 시작하나요?", "전화 상담으로 현재 고민과 목표를 듣고, 개념 이해도와 풀이 습관을 진단한 뒤 학생별 수업 방향을 제안합니다."),
    @((Fill "{R} 어느 지역에서 수업을 받을 수 있나요?" $region), (Fill "{P} 등 {R} 학생과 상담하고 있습니다. 방문 수업 가능 여부와 일정은 전화 상담 시 안내해 드립니다." $region))
  )
  $regionTitle = "$($region.Short) 수학과외 | $($region.Name) 초등·중등·고등 1:1 수학수업"
  $regionDescription = "$($region.Name) 수학과외 - 초등 기초수학, 중등 수학내신, 고등 수능수학까지 1:1 맞춤 수업. $($region.Summary) 상담 $phone"
  $regionMain = @"
    <section class="hero" aria-labelledby="region-title">
      <div class="hero-content">
        <p class="eyebrow">$($region.En) 1:1 MATH TUTORING</p>
        <h1 id="region-title">$($region.Name) 수학과외,<br><em>학생에게 맞는 공부의 순서</em></h1>
        <p class="hero-copy">$($region.Summary)</p>
        <div class="hero-actions"><a class="primary-button" href="tel:01029283614">무료 학습 상담</a><a class="phone-link" href="tel:01029283614">$phone</a></div>
      </div>
    </section>
    <nav class="breadcrumb" aria-label="현재 위치"><a href="../">충북 수학과외</a><span aria-hidden="true">/</span><span aria-current="page">$($region.Name) 수학과외</span></nav>
    <section class="section diagnosis">
      <div class="section-heading"><p class="eyebrow dark">PERSONAL DIAGNOSIS</p><h2>점수보다 먼저<br>막힌 이유를 찾습니다.</h2></div>
      <p class="section-copy">$($region.Focus) 성적표만 보는 것이 아니라 개념을 설명하는 방식, 문제를 읽는 순서, 오답을 다시 푸는 습관까지 확인합니다.</p>
      <div class="feature-grid">
        <article><span>01 / CHECK</span><h3>현재 실력 진단</h3><p>개념 이해도와 풀이 과정을 확인해 놓친 부분을 정확히 찾습니다.</p></article>
        <article><span>02 / PLAN</span><h3>개인별 학습 설계</h3><p>학교 진도와 목표, 학습 속도를 반영해 주차별 계획을 세웁니다.</p></article>
        <article><span>03 / REVIEW</span><h3>복습과 오답 관리</h3><p>수업에서 배운 내용이 혼자 공부하는 시간까지 이어지도록 점검합니다.</p></article>
      </div>
    </section>
$localBand
    <section class="section grade-guide">
      <div class="section-heading"><p class="eyebrow dark">GRADE PROGRAM</p><h2>$($region.Name)<br>학년별 수학과외</h2></div>
      <p class="grade-transition">예비중1·예비중2·예비중3, 예비고1·예비고2·예비고3 학생은 새 학년 진도와 현재 실력을 함께 확인해 필요한 선행과 복습의 범위를 조정합니다.</p>
      <div class="grade-grid">$gradeCards</div>
    </section>
    <section class="section faq"><div class="section-heading"><p class="eyebrow dark">FAQ</p><h2>$($region.Name) 수학과외<br>자주 묻는 질문</h2></div><div class="faq-list">$(Get-FaqHtml $regionFaq)</div></section>
    <section class="section region-navigation"><p class="eyebrow dark">CHUNGBUK 15 AREAS</p><h2>충북 지역별 수학과외</h2><nav class="region-links" aria-label="충북 지역별 수학과외">$(Get-RegionLinks $region.Slug $null)</nav></section>
$cta
"@
  Write-Page "$($region.Slug).html" (Get-Page @{
    Title=$regionTitle; Description=$regionDescription; Url=$regionUrl; BackHref="../#areas"; BackText="전체 지역 보기"; Main=$regionMain
    JsonLd=(Get-JsonLd $regionUrl "$($region.Name) 수학과외" $regionDescription @(@("충북 수학과외", "$siteUrl/"), @("$($region.Name) 수학과외", $regionUrl)) $regionFaq)
  })
  $sitemapUrls += $regionUrl

  # 지역 + 학년 페이지
  foreach ($grade in $grades) {
    $gradeUrl = "$siteUrl/regions/$($region.Slug)-$($grade.Key).html"
    $gradeDescription = Fill $grade.Description $region
    $gradeFaq = @($grade.Faq | ForEach-Object { ,@((Fill $_[0] $region), (Fill $_[1] $region)) })
    $topics = ($grade.Topics | ForEach-Object { "<article><span>$($grade.Label) $($_[0])</span><h3>$($region.Short) $($grade.Label) $($_[0])</h3><p>$(Fill $_[1] $region)</p></article>" }) -join ''
    $years = ($grade.Years | ForEach-Object { "<article><strong>$($_[0])</strong><h3>$($region.Short) $($_[0]) 수학과외</h3><p>$($_[1])</p></article>" }) -join ''
    $siblings = (@("<a href=`"$($region.Slug).html`">$($region.Short) 수학과외 전체</a>") + ($grades | ForEach-Object {
      $current = if ($_.Key -eq $grade.Key) { ' aria-current="page"' } else { '' }
      "<a href=`"$($region.Slug)-$($_.Key).html`"$current>$($region.Short) $($_.Label) 수학과외</a>"
    })) -join ''
    $gradeMain = @"
    <section class="hero" aria-labelledby="region-title">
      <div class="hero-content">
        <p class="eyebrow">$($region.En) · $($grade.En) MATH</p>
        <h1 id="region-title">$($region.Name) $($grade.Label) 수학과외,<br><em>$($grade.Tagline)</em></h1>
        <p class="hero-copy">$(Fill $grade.Intro $region)</p>
        <div class="hero-actions"><a class="primary-button" href="tel:01029283614">무료 학습 상담</a><a class="phone-link" href="tel:01029283614">$phone</a></div>
      </div>
    </section>
    <nav class="breadcrumb" aria-label="현재 위치"><a href="../">충북 수학과외</a><span aria-hidden="true">/</span><a href="$($region.Slug).html">$($region.Name) 수학과외</a><span aria-hidden="true">/</span><span aria-current="page">$($grade.Label) 수학</span></nav>
    <section class="section topics">
      <div class="section-heading"><p class="eyebrow dark">$($grade.En) PROGRAM</p><h2>$($region.Name) $($grade.Label) 수학,<br>이렇게 공부합니다.</h2></div>
      <p class="section-copy">$($region.Focus)</p>
      <div class="topic-grid">$topics</div>
    </section>
    <section class="section grade-guide">
      <div class="section-heading"><p class="eyebrow dark">BY GRADE</p><h2>학년별<br>$($region.Short) $($grade.Label) 수학과외</h2></div>
      <div class="grade-grid year-grid">$years</div>
    </section>
$localBand
    <section class="section faq"><div class="section-heading"><p class="eyebrow dark">FAQ</p><h2>$($region.Short) $($grade.Label) 수학과외<br>자주 묻는 질문</h2></div><div class="faq-list">$(Get-FaqHtml $gradeFaq)</div></section>
    <section class="section region-navigation"><p class="eyebrow dark">$($region.En) PROGRAM</p><h2>$($region.Name) 학년별 수학과외</h2><nav class="region-links grade-links" aria-label="$($region.Name) 학년별 수학과외">$siblings</nav>
      <h2 class="sub-heading">충북 지역별 $($grade.Label) 수학과외</h2><nav class="region-links" aria-label="충북 지역별 $($grade.Label) 수학과외">$(Get-RegionLinks $region.Slug $grade)</nav></section>
$cta
"@
    Write-Page "$($region.Slug)-$($grade.Key).html" (Get-Page @{
      Title="$($region.Short) $($grade.Label) 수학과외 | $($region.Name) $($grade.TitleTail)"; Description=$gradeDescription; Url=$gradeUrl
      BackHref="$($region.Slug).html"; BackText="$($region.Short) 수학과외"; Main=$gradeMain
      JsonLd=(Get-JsonLd $gradeUrl "$($region.Name) $($grade.Label) 수학과외" $gradeDescription @(@("충북 수학과외", "$siteUrl/"), @("$($region.Name) 수학과외", $regionUrl), @("$($grade.Label) 수학과외", $gradeUrl)) $gradeFaq)
    })
    $sitemapUrls += $gradeUrl
  }
}

$sitemapEntries = ($sitemapUrls | ForEach-Object {
  $priority = if ($_ -eq "$siteUrl/") { "1.0" } elseif ($_ -match '-(elementary|middle|high)\.html$') { "0.7" } else { "0.8" }
  "  <url><loc>$_</loc><lastmod>$today</lastmod><priority>$priority</priority></url>"
}) -join "`n"
$sitemap = "<?xml version=`"1.0`" encoding=`"UTF-8`"?>`n<urlset xmlns=`"http://www.sitemaps.org/schemas/sitemap/0.9`">`n$sitemapEntries`n</urlset>"
[System.IO.File]::WriteAllText((Join-Path $PSScriptRoot "sitemap.xml"), $sitemap + "`n", (New-Object System.Text.UTF8Encoding $false))

Write-Host "Generated $($regions.Count) regional pages and $($regions.Count * $grades.Count) grade pages."
