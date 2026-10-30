$ErrorActionPreference = "Stop"
$outputDirectory = Join-Path $PSScriptRoot "regions"
$schoolDirectory = Join-Path $PSScriptRoot "schools"
New-Item -ItemType Directory -Path $outputDirectory, $schoolDirectory -Force | Out-Null
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

# 출처: 전국초중등학교위치표준데이터(2026-10-26), 충북 운영 중인 본교
$schools = Import-Csv -Path (Join-Path $PSScriptRoot "data/chungbuk-schools.csv") -Encoding UTF8
$schools | ForEach-Object { $_.Lat = [double]$_.Lat; $_.Lon = [double]$_.Lon }

# {R} = 지역명, {S} = 짧은 지역명, {P} = 주요 동·읍·면
$grades = @(
  [ordered]@{
    Key="elementary"; Label="초등"; En="ELEMENTARY"; Card="기초와 자신감"; SchoolLevel="초등학교"
    SchoolText="학교별 교과 진도와 단원평가 일정에 맞춰 연산, 교과 개념, 서술형 풀이를 함께 관리합니다."
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
    Key="middle"; Label="중등"; En="MIDDLE SCHOOL"; Card="개념과 내신"; SchoolLevel="중학교"
    SchoolText="학교별 교과서와 부교재, 시험 범위, 서술형 출제 경향을 확인해 수학내신을 준비합니다."
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
    Key="high"; Label="고등"; En="HIGH SCHOOL"; Card="내신과 수능"; SchoolLevel="고등학교"
    SchoolText="학교별 교과서와 부교재, 기출 경향에 맞춘 수학내신 대비와 수능수학 준비를 함께 진행합니다."
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

# 학년별 페이지 데이터
$years = @(
  [ordered]@{ Key="elementary-1"; Grade="elementary"; Label="초1"; Full="초등학교 1학년"; Tagline="수와 연산의 첫걸음"
    Units="9까지의 수, 덧셈과 뺄셈의 기초, 100까지의 수, 여러 가지 모양, 시계 보기"
    Struggle="손가락으로 세는 습관이 오래가거나, 10을 모으고 가르는 감각이 부족해 받아올림 계산에서 막히는 경우가 많습니다."
    Plan="구체물과 그림으로 수의 크기를 느끼게 한 뒤, 10 만들기와 가르기를 반복해 암산의 기초를 만듭니다."
    Points=@(@("수 감각", "수를 세고 크기를 비교하며 10의 묶음을 자연스럽게 이해합니다."), @("바른 연산 습관", "덧셈과 뺄셈의 의미를 이해하고 식으로 쓰는 연습을 합니다."), @("수학과 친해지기", "놀이와 생활 속 문제로 수학에 대한 흥미와 자신감을 키웁니다."))
    Faq=@("초1부터 수학과외가 필요한가요?", "모든 학생에게 필요한 것은 아니지만, 수 세기나 덧셈·뺄셈에서 어려움을 느낀다면 초1 때 바로잡는 것이 가장 수월합니다. 짧은 시간이라도 바른 연산 습관을 만드는 데 집중합니다.") },
  [ordered]@{ Key="elementary-2"; Grade="elementary"; Label="초2"; Full="초등학교 2학년"; Tagline="곱셈구구와 받아올림 완성"
    Units="세 자리 수, 받아올림·받아내림이 있는 덧셈과 뺄셈, 곱셈과 곱셈구구, 길이 재기, 시각과 시간"
    Struggle="받아올림과 받아내림에서 자릿값을 헷갈리거나, 곱셈구구를 외우기만 하고 의미를 이해하지 못해 응용 문제에서 막히는 경우가 많습니다."
    Plan="자릿값을 그림과 수 모형으로 확인한 뒤, 곱셈을 같은 수를 여러 번 더하는 것으로 이해하고 곱셈구구를 정확하게 익힙니다."
    Points=@(@("자릿값 이해", "세 자리 수의 자릿값을 정확히 알고 받아올림 계산의 원리를 이해합니다."), @("곱셈구구", "곱셈의 의미를 이해한 상태에서 곱셈구구를 빠르고 정확하게 익힙니다."), @("측정", "길이와 시간을 재고 읽는 활동으로 생활 속 수학을 익힙니다."))
    Faq=@("초2 곱셈구구는 어떻게 지도하나요?", "무작정 외우기보다 묶어 세기와 덧셈으로 곱셈의 의미를 먼저 이해하게 합니다. 이후 단별 규칙을 찾고 반복 연습으로 정확도와 속도를 함께 높입니다.") },
  [ordered]@{ Key="elementary-3"; Grade="elementary"; Label="초3"; Full="초등학교 3학년"; Tagline="나눗셈과 분수의 시작"
    Units="세 자리 수의 덧셈과 뺄셈, 곱셈, 나눗셈, 분수와 소수의 첫 개념, 평면도형, 원, 길이와 시간"
    Struggle="나눗셈과 분수가 처음 등장하면서 수학이 어려워졌다고 느끼는 학생이 많아지고, 문장제 문제를 식으로 바꾸는 데 어려움을 겪습니다."
    Plan="나눗셈을 똑같이 나누기와 묶어 세기로 이해하고, 분수를 그림으로 표현하며 개념을 다집니다. 문장제는 조건을 표시하며 읽는 습관부터 만듭니다."
    Points=@(@("나눗셈", "곱셈과 나눗셈의 관계를 이해하고 나머지가 있는 나눗셈까지 익힙니다."), @("분수와 소수", "전체와 부분의 관계로 분수를 이해하고 소수와 연결합니다."), @("문장제 읽기", "문제의 조건을 정리해 알맞은 식을 세우는 연습을 합니다."))
    Faq=@("초3 때 수학이 갑자기 어려워졌다고 해요.", "초3은 나눗셈과 분수가 처음 나오고 문장제가 늘어나는 시기라 흔히 겪는 일입니다. 막힌 개념을 그림과 구체물로 다시 설명하고, 연산과 문장제를 나눠서 차근차근 보완합니다.") },
  [ordered]@{ Key="elementary-4"; Grade="elementary"; Label="초4"; Full="초등학교 4학년"; Tagline="고학년 수학의 기초 다지기"
    Units="큰 수, 각도, 곱셈과 나눗셈, 분수의 덧셈과 뺄셈, 소수의 덧셈과 뺄셈, 삼각형·사각형·다각형"
    Struggle="계산 단계가 길어지면서 실수가 늘고, 각도와 도형 단원에서 개념을 정확히 구분하지 못하는 경우가 많습니다."
    Plan="계산 과정을 단계별로 쓰는 습관으로 실수를 줄이고, 도형은 직접 그리고 분류하며 성질을 정리합니다."
    Points=@(@("계산 정확도", "큰 수와 두세 자리 수의 곱셈·나눗셈을 정확하게 해결합니다."), @("분수·소수 계산", "분모가 같은 분수와 소수의 덧셈·뺄셈 원리를 이해합니다."), @("도형 개념", "각도, 삼각형과 사각형의 성질을 구분해 설명할 수 있게 합니다."))
    Faq=@("초4 계산 실수가 너무 많아요.", "실수의 대부분은 과정을 생략하거나 자릿값을 맞추지 않아 생깁니다. 풀이 과정을 정리해 쓰는 습관과 검산 방법을 함께 지도해 실수를 줄입니다.") },
  [ordered]@{ Key="elementary-5"; Grade="elementary"; Label="초5"; Full="초등학교 5학년"; Tagline="분수 계산과 중등 수학의 연결"
    Units="자연수의 혼합 계산, 약수와 배수, 약분과 통분, 분수의 덧셈·뺄셈·곱셈, 소수의 곱셈, 다각형의 둘레와 넓이, 직육면체"
    Struggle="약수와 배수, 약분과 통분이 이어지는 분수 계산에서 크게 막히는 학생이 많고, 이 빈틈이 중학교 수학까지 이어지기 쉽습니다."
    Plan="약수와 배수의 개념부터 약분·통분, 분수의 계산까지 한 흐름으로 정리하고, 넓이 공식은 유도 과정을 이해하도록 지도합니다."
    Points=@(@("약수와 배수", "최대공약수와 최소공배수를 구하고 분수 계산에 활용합니다."), @("분수의 계산", "약분과 통분을 이용해 분수의 덧셈, 뺄셈, 곱셈을 정확히 합니다."), @("넓이와 입체", "다각형의 넓이 공식을 이해하고 직육면체의 성질을 익힙니다."))
    Faq=@("초5 분수 계산이 왜 중요한가요?", "분수 계산은 중학교의 유리수, 문자와 식, 방정식으로 바로 이어집니다. 초5에서 약분과 통분, 분수의 계산을 확실히 다져 두면 중등 수학이 훨씬 수월해집니다.") },
  [ordered]@{ Key="elementary-6"; Grade="elementary"; Label="초6"; Full="초등학교 6학년"; Tagline="초등 수학 마무리와 예비중1 준비"
    Units="분수와 소수의 나눗셈, 비와 비율, 비례식과 비례배분, 원의 둘레와 넓이, 각기둥과 각뿔, 원기둥·원뿔·구, 여러 가지 그래프"
    Struggle="분수의 나눗셈과 비율 개념이 헷갈리기 쉽고, 초등 과정의 빈틈이 쌓인 채로 중학교에 올라가면 첫 시험에서 어려움을 겪습니다."
    Plan="초등 핵심 단원의 빈틈을 점검해 보완하고, 하반기에는 중1 수학의 정수와 유리수, 문자와 식을 미리 익혀 중학교 진학을 준비합니다."
    Points=@(@("분수·소수의 나눗셈", "나눗셈의 의미를 이해하고 분수와 소수의 나눗셈을 정확히 합니다."), @("비와 비율", "비율, 백분율, 비례식을 생활 문제에 적용합니다."), @("예비중1 준비", "초등 과정을 점검하고 중1 수학의 첫 단원을 미리 익힙니다."))
    Faq=@("초6 때 중학교 수학 선행을 해야 하나요?", "초등 과정에 빈틈이 있다면 그 부분을 먼저 보완하는 것이 우선입니다. 기초가 탄탄하다면 하반기부터 중1 첫 단원을 미리 익혀 진학 후 적응을 돕습니다.") },
  [ordered]@{ Key="middle-1"; Grade="middle"; Label="중1"; Full="중학교 1학년"; Tagline="중등 수학의 첫 단추"
    Units="소인수분해, 정수와 유리수, 문자와 식, 일차방정식, 좌표평면과 그래프, 기본 도형, 평면도형과 입체도형, 자료의 정리와 해석"
    Struggle="음수의 계산과 문자를 사용한 식이 처음 등장하면서 부호 실수와 식 정리에서 어려움을 겪고, 첫 지필 평가의 서술형에 익숙하지 않습니다."
    Plan="정수와 유리수의 계산 규칙을 확실히 하고, 문자와 식에서 일차방정식까지 한 흐름으로 이어지도록 지도합니다. 학교 평가 방식에 맞춰 서술형 풀이도 함께 연습합니다."
    Points=@(@("정수와 유리수", "부호가 있는 수의 사칙계산을 실수 없이 해결합니다."), @("문자와 식", "문자를 사용해 식을 세우고 정리하는 방법을 익힙니다."), @("일차방정식", "방정식의 풀이와 활용 문제를 단계별로 해결합니다."))
    Faq=@("중1은 시험이 적은데 수학과외가 필요한가요?", "중1에 배우는 정수와 유리수, 문자와 식, 일차방정식은 중2·중3 수학 전체의 기초입니다. 시험 부담이 적은 중1 때 개념을 탄탄히 다지는 것이 이후 내신 관리에 큰 도움이 됩니다.") },
  [ordered]@{ Key="middle-2"; Grade="middle"; Label="중2"; Full="중학교 2학년"; Tagline="함수와 도형, 내신의 본격 시작"
    Units="유리수와 순환소수, 식의 계산, 일차부등식, 연립일차방정식, 일차함수, 삼각형과 사각형의 성질, 도형의 닮음, 피타고라스 정리, 확률"
    Struggle="일차함수와 도형의 증명이 등장하면서 수학을 어려워하는 학생이 크게 늘고, 내신 시험의 서술형 비중도 높아집니다."
    Plan="일차함수는 그래프와 식을 연결해 이해하고, 도형은 성질과 증명의 흐름을 정리합니다. 학교별 시험 범위에 맞춰 서술형과 고난도 문항을 함께 대비합니다."
    Points=@(@("연립방정식과 부등식", "식의 계산을 바탕으로 연립일차방정식과 일차부등식을 풀고 활용합니다."), @("일차함수", "그래프와 식의 관계를 이해하고 기울기와 절편을 활용합니다."), @("도형의 성질", "삼각형과 사각형의 성질, 닮음을 이해하고 증명 과정을 서술합니다."))
    Faq=@("중2 수학이 어렵다는데 무엇을 준비해야 하나요?", "중2는 일차함수와 도형의 증명이 나오면서 난도가 크게 오릅니다. 중1의 방정식과 좌표평면 개념이 탄탄한지 먼저 확인하고, 함수와 도형은 개념 이해와 서술형 연습을 함께 진행합니다.") },
  [ordered]@{ Key="middle-3"; Grade="middle"; Label="중3"; Full="중학교 3학년"; Tagline="고등 수학으로 가는 다리"
    Units="제곱근과 실수, 다항식의 곱셈과 인수분해, 이차방정식, 이차함수, 삼각비, 원의 성질, 통계"
    Struggle="인수분해와 이차방정식, 이차함수는 고등 수학의 출발점인데, 이 단원이 흔들린 채 고등학교에 진학하면 고1 수학에서 크게 어려움을 겪습니다."
    Plan="인수분해에서 이차방정식, 이차함수까지 연결해 완성하고, 고입 전 겨울방학에는 고1 공통수학의 핵심 개념을 미리 익힙니다."
    Points=@(@("인수분해", "곱셈 공식과 인수분해를 자유롭게 활용합니다."), @("이차방정식과 이차함수", "이차방정식의 풀이와 이차함수의 그래프를 연결해 이해합니다."), @("예비고1 준비", "중등 핵심 단원을 점검하고 고1 공통수학을 미리 준비합니다."))
    Faq=@("중3 겨울방학에는 무엇을 공부해야 하나요?", "중3 겨울방학은 고1 공통수학을 준비하는 가장 중요한 시기입니다. 인수분해와 이차함수 등 중등 핵심 단원의 빈틈을 먼저 메우고, 고1 첫 단원을 미리 익혀 첫 내신에 대비합니다.") },
  [ordered]@{ Key="high-1"; Grade="high"; Label="고1"; Full="고등학교 1학년"; Tagline="공통수학과 첫 내신"
    Units="공통수학의 다항식, 방정식과 부등식, 경우의 수, 도형의 방정식, 집합과 명제, 함수"
    Struggle="중학교보다 학습량과 난도가 크게 늘어나 첫 중간고사에서 예상보다 낮은 점수를 받는 경우가 많고, 내신 등급 경쟁이 시작됩니다."
    Plan="공통수학 개념을 탄탄히 다지고 학교 교과서와 부교재에 맞춰 내신을 준비합니다. 학력평가를 통해 수능형 문제에도 익숙해지도록 합니다."
    Points=@(@("공통수학 개념", "다항식, 방정식과 부등식 등 고등 수학의 기초 개념을 완성합니다."), @("첫 내신 관리", "학교별 시험 범위와 출제 경향에 맞춰 서술형과 고난도 문항을 대비합니다."), @("학력평가 대비", "모의고사 형식에 익숙해지고 시간 배분을 연습합니다."))
    Faq=@("고1 첫 시험이 걱정돼요. 언제부터 준비하나요?", "고1 첫 내신은 입학 전 겨울방학부터 준비하는 것이 좋습니다. 입학 후에는 학교 진도에 맞춰 개념과 유형을 정리하고, 시험 4주 전부터 학교 교과서와 부교재를 중심으로 실전 대비를 진행합니다.") },
  [ordered]@{ Key="high-2"; Grade="high"; Label="고2"; Full="고등학교 2학년"; Tagline="선택 과목과 수능의 시작"
    Units="지수와 로그, 삼각함수, 수열, 함수의 극한, 미분과 적분, 확률과 통계"
    Struggle="과목 수와 학습 범위가 크게 늘어나 내신과 수능 준비를 함께 하기 어려워지고, 개념이 흔들린 단원이 고3까지 이어지기 쉽습니다."
    Plan="학교에서 배우는 과목에 맞춰 내신을 관리하면서, 개념이 정리된 단원부터 수능 기출 학습을 시작해 고3 실전 대비의 기반을 만듭니다."
    Points=@(@("과목별 개념 완성", "지수와 로그, 삼각함수, 수열, 미분과 적분 등 핵심 개념을 정리합니다."), @("내신 관리", "학교별 시험 범위와 부교재에 맞춰 내신 등급을 관리합니다."), @("수능 기출 시작", "개념이 정리된 단원부터 기출 문제를 풀며 수능 감각을 익힙니다."))
    Faq=@("고2부터 수능 공부를 시작해야 하나요?", "고2는 내신과 수능 준비를 병행하기 시작하는 시기입니다. 학교 진도에 맞춘 내신 관리를 중심으로 하면서, 개념이 정리된 단원부터 기출 문제를 함께 풀어 두면 고3 대비가 훨씬 수월해집니다.") },
  [ordered]@{ Key="high-3"; Grade="high"; Label="고3"; Full="고등학교 3학년"; Tagline="목표 등급을 향한 수능 마무리"
    Units="수능 공통과목과 선택과목의 기출 분석, 실전 모의고사, 3학년 내신 마무리"
    Struggle="남은 시간이 짧아 무엇을 먼저 공부해야 할지 정하기 어렵고, 모의고사에서 시간 부족과 실수로 실력보다 낮은 점수를 받는 경우가 많습니다."
    Plan="모의고사 결과로 취약 단원을 정확히 찾아 우선순위를 정하고, 기출 분석과 실전 모의고사로 시간 배분과 실수 관리를 훈련합니다."
    Points=@(@("취약 단원 보완", "모의고사 결과를 분석해 점수를 올릴 수 있는 단원부터 집중합니다."), @("기출 분석", "기출 문제의 출제 의도와 풀이 흐름을 익힙니다."), @("실전 훈련", "실전 모의고사로 시간 배분과 실수 관리를 연습합니다."))
    Faq=@("고3인데 지금 시작해도 늦지 않을까요?", "남은 기간에 맞춰 목표를 현실적으로 정하면 충분히 의미 있는 성적 향상이 가능합니다. 모의고사 결과로 취약 단원을 찾고 점수를 올리기 쉬운 단원부터 우선순위를 정해 집중합니다.") }
)

function Fill($text, $region) {
  return $text.Replace('{R}', $region.Name).Replace('{S}', $region.Short).Replace('{P}', ($region.Places -replace '·', ', '))
}

function Get-Schools($region, $level) {
  $parts = $region.Name -split ' '
  return @($schools | Where-Object { $_.City -eq $parts[0] -and ($parts.Count -eq 1 -or $_.District -eq $parts[1]) -and $_.Level -eq $level })
}

function Get-SchoolList($items) {
  $listItems = ($items | ForEach-Object { "<li><a href=`"../schools/$($_.Id).html`">$($_.Name)</a></li>" }) -join ''
  return "<ul class=`"school-list`">$listItems</ul>"
}

function Get-Distance($a, $b) {
  $x = ($b.Lon - $a.Lon) * [Math]::Cos(($a.Lat + $b.Lat) * [Math]::PI / 360)
  $y = $b.Lat - $a.Lat
  return [Math]::Sqrt($x * $x + $y * $y) * 111.32
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
  <link rel="icon" href="../favicon.ico" sizes="any">
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

function Write-Page($fileName, $html, $directory = $outputDirectory) {
  Set-Content -Path (Join-Path $directory $fileName) -Value $html -Encoding UTF8
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
  $yearLinks = ($years | ForEach-Object { "<a href=`"$($region.Slug)-$($_.Key).html`">$($region.Short) $($_.Label) 수학과외</a>" }) -join ''
  $regionFaq = @(
    @("$($region.Name) 수학과외는 어떤 학생이 받을 수 있나요?", "초등·중등·고등 학생 모두 가능합니다. 초등 기초수학, 중등 수학내신, 고등 수능수학까지 학생의 학년과 목표에 맞춰 수업을 설계합니다."),
    @("수업은 어떻게 시작하나요?", "전화 상담으로 현재 고민과 목표를 듣고, 개념 이해도와 풀이 습관을 진단한 뒤 학생별 수업 방향을 제안합니다."),
    @((Fill "{R} 어느 지역에서 수업을 받을 수 있나요?" $region), (Fill "{P} 등 {R} 학생과 상담하고 있습니다. 방문 수업 가능 여부와 일정은 전화 상담 시 안내해 드립니다." $region))
  )
  $schoolColumns = ($grades | ForEach-Object {
    $names = Get-Schools $region $_.SchoolLevel
    if ($names.Count) { "<div class=`"school-column`"><h3><a href=`"$($region.Slug)-$($_.Key).html`">$($region.Short) $($_.SchoolLevel) 수학과외</a><small>$($names.Count)곳</small></h3>$(Get-SchoolList $names)</div>" }
  }) -join ''
  $schoolCount = @($grades | ForEach-Object { Get-Schools $region $_.SchoolLevel }).Count
  $regionSchools = "    <section class=`"section schools`"><div class=`"section-heading`"><p class=`"eyebrow dark`">LOCAL SCHOOLS</p><h2>$($region.Name)<br>학교별 수학과외</h2></div><p class=`"section-copy`">$($region.Name)에 있는 초·중·고 $($schoolCount)곳의 학생과 상담합니다. 다니는 학교의 진도와 시험 범위에 맞춰 수업을 설계합니다.</p><div class=`"school-columns`">$schoolColumns</div></section>"
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
      <nav class="year-links" aria-label="$($region.Name) 학년별 수학과외">$yearLinks</nav>
    </section>
$regionSchools
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
    $yearCards = ($grade.Years | ForEach-Object { "<article><strong>$($_[0])</strong><h3>$($region.Short) $($_[0]) 수학과외</h3><p>$($_[1])</p></article>" }) -join ''
    $gradeYearLinks = (@($years | Where-Object { $_.Grade -eq $grade.Key }) | ForEach-Object { "<a href=`"$($region.Slug)-$($_.Key).html`">$($region.Short) $($_.Label) 수학과외</a>" }) -join ''
    $siblings = (@("<a href=`"$($region.Slug).html`">$($region.Short) 수학과외 전체</a>") + ($grades | ForEach-Object {
      $current = if ($_.Key -eq $grade.Key) { ' aria-current="page"' } else { '' }
      "<a href=`"$($region.Slug)-$($_.Key).html`"$current>$($region.Short) $($_.Label) 수학과외</a>"
    })) -join ''
    $gradeSchoolNames = Get-Schools $region $grade.SchoolLevel
    $gradeSchools = if ($gradeSchoolNames.Count) { "    <section class=`"section schools`"><div class=`"section-heading`"><p class=`"eyebrow dark`">LOCAL SCHOOLS</p><h2>$($region.Short) $($grade.SchoolLevel)별<br>수학과외</h2></div><p class=`"section-copy`">$($region.Name)에 있는 $($grade.SchoolLevel) $($gradeSchoolNames.Count)곳의 학생과 상담합니다. $($grade.SchoolText)</p>$(Get-SchoolList $gradeSchoolNames)</section>" } else { "" }
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
      <div class="grade-grid year-grid">$yearCards</div>
    </section>
$gradeSchools
$localBand
    <section class="section faq"><div class="section-heading"><p class="eyebrow dark">FAQ</p><h2>$($region.Short) $($grade.Label) 수학과외<br>자주 묻는 질문</h2></div><div class="faq-list">$(Get-FaqHtml $gradeFaq)</div></section>
    <section class="section region-navigation"><p class="eyebrow dark">$($region.En) PROGRAM</p><h2>$($region.Name) 학년별 수학과외</h2><nav class="region-links grade-links" aria-label="$($region.Name) 학년별 수학과외">$siblings</nav>
      <h2 class="sub-heading">$($region.Short) $($grade.Label) 학년별 수학과외</h2><nav class="region-links grade-links" aria-label="$($region.Short) $($grade.Label) 학년별 수학과외">$gradeYearLinks</nav>
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

# 지역 + 학년별 페이지
foreach ($region in $regions) {
  $regionUrl = "$siteUrl/regions/$($region.Slug).html"
  foreach ($year in $years) {
    $grade = $grades | Where-Object { $_.Key -eq $year.Grade }
    $label = $year.Label
    $yearUrl = "$siteUrl/regions/$($region.Slug)-$($year.Key).html"
    $gradeHref = "$($region.Slug)-$($grade.Key).html"
    $unitsShort = ($year.Units -split ', ' | Select-Object -First 3) -join ', '
    $description = "$($region.Name) $label 수학과외 - $($year.Full) $unitsShort 등 핵심 단원부터 학교 시험까지 1:1 맞춤 수업. $(($region.Places -replace '·', ', ')) 상담 $phone"
    $points = ($year.Points | ForEach-Object { "<article><span>$label $($_[0])</span><h3>$($region.Short) $label $($_[0])</h3><p>$($_[1])</p></article>" }) -join ''
    $unitItems = ($year.Units -split ', ' | ForEach-Object { "<li>$_</li>" }) -join ''
    $yearSchools = Get-Schools $region $grade.SchoolLevel
    $schoolSection = if ($yearSchools.Count) { "    <section class=`"section schools`"><div class=`"section-heading`"><p class=`"eyebrow dark`">LOCAL SCHOOLS</p><h2>$($region.Short) $label<br>학교별 수학과외</h2></div><p class=`"section-copy`">$($region.Name)에 있는 $($grade.SchoolLevel) $($yearSchools.Count)곳의 $label 학생과 상담합니다. 다니는 학교의 진도와 평가 일정에 맞춰 수업합니다.</p>$(Get-SchoolList $yearSchools)</section>" } else { "" }
    $yearFaq = @(
      $year.Faq,
      @("$($region.Name) $label 수학과외는 어떻게 시작하나요?", "전화 상담으로 현재 고민과 목표를 듣고, $($year.Full) 과정의 개념 이해도와 풀이 습관을 진단한 뒤 수업 방향을 제안합니다."),
      @("$($region.Name) 어느 지역에서 수업을 받을 수 있나요?", "$(($region.Places -replace '·', ', ')) 등 $($region.Name) 학생과 상담하고 있습니다. 방문 수업 가능 여부와 일정은 전화 상담 시 안내해 드립니다.")
    )
    $sameGrade = (@($years | Where-Object { $_.Grade -eq $year.Grade }) | ForEach-Object {
      $current = if ($_.Key -eq $year.Key) { ' aria-current="page"' } else { '' }
      "<a href=`"$($region.Slug)-$($_.Key).html`"$current>$($region.Short) $($_.Label) 수학과외</a>"
    }) -join ''
    $otherRegions = ($regions | ForEach-Object {
      $current = if ($_.Slug -eq $region.Slug) { ' aria-current="page"' } else { '' }
      "<a href=`"$($_.Slug)-$($year.Key).html`"$current>$($_.Short) $label 수학</a>"
    }) -join ''
    $yearMain = @"
    <section class="hero" aria-labelledby="year-title">
      <div class="hero-content">
        <p class="eyebrow">$($region.En) · $($year.Full) MATH</p>
        <h1 id="year-title">$($region.Name) $label 수학과외,<br><em>$($year.Tagline)</em></h1>
        <p class="hero-copy">$($region.Name) $($year.Full) 학생의 개념 이해도와 학교 진도를 살펴 지금 필요한 공부의 순서를 1:1로 설계합니다.</p>
        <div class="hero-actions"><a class="primary-button" href="tel:01029283614">무료 학습 상담</a><a class="phone-link" href="tel:01029283614">$phone</a></div>
      </div>
    </section>
    <nav class="breadcrumb" aria-label="현재 위치"><a href="../">충북 수학과외</a><span aria-hidden="true">/</span><a href="$($region.Slug).html">$($region.Name) 수학과외</a><span aria-hidden="true">/</span><a href="$gradeHref">$($grade.Label) 수학</a><span aria-hidden="true">/</span><span aria-current="page">$label 수학</span></nav>
    <section class="section year-units">
      <div class="section-heading"><p class="eyebrow dark">CURRICULUM</p><h2>$($year.Full)<br>수학에서 배우는 내용</h2></div>
      <div><ul class="unit-list">$unitItems</ul><p class="data-note">학교와 교육과정에 따라 단원 구성과 순서는 다를 수 있습니다.</p></div>
    </section>
    <section class="section year-focus">
      <div class="focus-item"><p class="eyebrow dark">COMMON STRUGGLES</p><h2>$label 학생이<br>자주 막히는 부분</h2><p>$($year.Struggle)</p></div>
      <div class="focus-item"><p class="eyebrow dark">OUR APPROACH</p><h2>$($region.Short) $label<br>수학 수업 방향</h2><p>$($year.Plan) $($region.Focus)</p></div>
    </section>
    <section class="section topics">
      <div class="section-heading"><p class="eyebrow dark">KEY POINTS</p><h2>$($region.Short) $label 수학,<br>이것부터 잡습니다.</h2></div>
      <div class="topic-grid school-topics">$points</div>
    </section>
$schoolSection
    <section class="section faq"><div class="section-heading"><p class="eyebrow dark">FAQ</p><h2>$($region.Short) $label 수학과외<br>자주 묻는 질문</h2></div><div class="faq-list">$(Get-FaqHtml $yearFaq)</div></section>
    <section class="section region-navigation"><p class="eyebrow dark">$($region.En) PROGRAM</p><h2>$($region.Name) $($grade.Label) 학년별 수학과외</h2><nav class="region-links grade-links" aria-label="$($region.Name) $($grade.Label) 학년별 수학과외">$sameGrade</nav>
      <h2 class="sub-heading">충북 지역별 $label 수학과외</h2><nav class="region-links" aria-label="충북 지역별 $label 수학과외">$otherRegions</nav></section>
    <section class="cta"><p>START YOUR WAY</p><h2>$($region.Name) $label 수학과외,<br>편하게 상담해 보세요.</h2><div><a class="primary-button" href="tel:01029283614">전화 상담하기</a><a class="phone-link" href="tel:01029283614">$phone</a></div></section>
"@
    Write-Page "$($region.Slug)-$($year.Key).html" (Get-Page @{
      Title="$($region.Short) $label 수학과외 | $($region.Name) $($year.Full) 수학 1:1 수업"; Description=$description; Url=$yearUrl
      BackHref=$gradeHref; BackText="$($region.Short) $($grade.Label) 수학과외"; Main=$yearMain
      JsonLd=(Get-JsonLd $yearUrl "$($region.Name) $label 수학과외" $description @(@("충북 수학과외", "$siteUrl/"), @("$($region.Name) 수학과외", $regionUrl), @("$($grade.Label) 수학과외", "$siteUrl/regions/$gradeHref"), @("$label 수학과외", $yearUrl)) $yearFaq)
    })
    $sitemapUrls += $yearUrl
  }
}

# 메인 페이지 충북 학교별 섹션
$indexRegions = @($regions | Where-Object { $_.Slug -ne "cheongju-si" })
$indexRegions = @($indexRegions | Where-Object { $_.Name -like "청주시 *" }) + @($indexRegions | Where-Object { $_.Name -notlike "청주시 *" })
$schoolMap = ($indexRegions | ForEach-Object {
  $region = $_
  $lines = ($grades | ForEach-Object {
    $names = Get-Schools $region $_.SchoolLevel
    $schoolLinks = ($names | ForEach-Object { "<a href=`"schools/$($_.Id).html`">$($_.Name)</a>" }) -join ' · '
    if ($names.Count) { "<p><a class=`"level`" href=`"regions/$($region.Slug)-$($_.Key).html`">$($_.SchoolLevel)</a> $schoolLinks</p>" }
  }) -join ''
  "<article><h3><a href=`"regions/$($region.Slug).html`">$($region.Name) 수학과외</a></h3>$lines</article>"
}) -join "`n        "
$indexPath = Join-Path $PSScriptRoot "index.html"
$utf8 = New-Object System.Text.UTF8Encoding $false
$index = [System.IO.File]::ReadAllText($indexPath, $utf8)
$schoolSection = @"
<!-- schools:start -->
    <section class="school-map section" id="schools">
      <div class="areas-heading reveal">
        <div><p class="kicker">CHUNGBUK SCHOOLS</p><h2>충북 학교별<br>수학과외</h2></div>
        <p>충북에 있는 초등학교 $(@($schools | Where-Object Level -eq "초등학교").Count)곳, 중학교 $(@($schools | Where-Object Level -eq "중학교").Count)곳, 고등학교 $(@($schools | Where-Object Level -eq "고등학교").Count)곳 학생의 학교 진도와 시험 범위에 맞춰 수업합니다.</p>
      </div>
      <div class="school-map-grid">
        $schoolMap
      </div>
    </section>
    <!-- schools:end -->
"@
$index = [regex]::Replace($index, '(?s)<!-- schools:start -->.*?<!-- schools:end -->
?
', { param($m) $schoolSection })
[System.IO.File]::WriteAllText($indexPath, $index, $utf8)

# 학교별 페이지
$schoolPrograms = @{
  "초등학교" = @{ Grade="elementary"; Tail="기초수학·수학공부 1:1"; Tagline="학교 진도에 맞춘 1:1 수학 수업"; Next="중학교"; NextLabel="인근 중학교"
    Description="{N} 학생을 위한 1:1 수학과외. {N} 교과 진도와 단원평가에 맞춘 연산·기초수학, 서술형 풀이와 수학공부 습관 관리."
    Topics=@(
      @("수학수업", "{N} 학생의 교과 진도에 맞춰 이번 단원의 개념을 먼저 정리하고, 단원평가 전에는 틀리기 쉬운 문제를 다시 점검합니다."),
      @("기초수학", "연산 실수, 분수와 소수, 도형처럼 막힌 부분을 찾아 이전 학년 내용까지 필요한 만큼 되짚어 기초를 다집니다."),
      @("수학공부 습관", "학생 수준에 맞는 과제 분량을 정하고 틀린 문제를 다시 풀어 보는 오답 습관을 함께 만듭니다.")
    ) }
  "중학교" = @{ Grade="middle"; Tail="수학내신 대비 1:1"; Tagline="학교 시험에 맞춘 1:1 수학 수업"; Next="고등학교"; NextLabel="인근 고등학교"
    Description="{N} 학생을 위한 1:1 수학과외. {N} 시험 범위와 교과서·부교재에 맞춘 수학내신 대비, 기초수학 보완과 서술형 풀이 관리."
    Topics=@(
      @("수학내신", "{N}의 시험 범위와 교과서, 부교재를 확인해 시험 4주 전부터 단원 점검, 서술형 풀이, 실전 연습 순서로 준비합니다."),
      @("수학수업", "{N} 진도에 맞춰 개념 설명, 유형 연습, 오답 정리를 한 흐름으로 진행합니다."),
      @("기초수학", "정수와 유리수, 방정식, 함수처럼 막히기 쉬운 단원의 빈틈을 찾아 현재 진도와 함께 보완합니다.")
    ) }
  "고등학교" = @{ Grade="high"; Tail="수학내신·수능수학 1:1"; Tagline="내신과 수능을 함께 준비하는 1:1 수업"; Next="중학교"; NextLabel="인근 중학교"
    Description="{N} 학생을 위한 1:1 수학과외. {N} 교과서·부교재와 시험 범위에 맞춘 수학내신 대비, 목표 등급별 수능수학 준비."
    Topics=@(
      @("수학내신", "{N}의 교과서와 부교재, 시험 범위를 확인해 서술형과 고난도 문항까지 대비합니다."),
      @("수능수학", "학년과 목표 등급에 맞춰 개념 완성, 기출 분석, 실전 모의고사 순서로 수능수학을 준비합니다."),
      @("수학공부", "다른 과목 일정까지 고려해 개념 복습과 기출 풀이가 이어지는 현실적인 공부 계획을 세웁니다.")
    ) }
}

function Get-NearbyList($school, $level, $count) {
  $items = @($schools | Where-Object { $_.Level -eq $level -and $_.Id -ne $school.Id } | ForEach-Object { [pscustomobject]@{ School=$_; Km=(Get-Distance $school $_) } } | Sort-Object Km | Select-Object -First $count)
  $listItems = ($items | ForEach-Object { "<li><a href=`"$($_.School.Id).html`">$($_.School.Name) 수학과외</a><span>$($_.School.Town) · 약 $('{0:0.0}' -f $_.Km)km</span></li>" }) -join ''
  return "<ul class=`"nearby-list`">$listItems</ul>"
}

foreach ($school in $schools) {
  $program = $schoolPrograms[$school.Level]
  $grade = $grades | Where-Object { $_.Key -eq $program.Grade }
  $regionName = if ($school.District) { "$($school.City) $($school.District)" } else { $school.City }
  $region = $regions | Where-Object { $_.Name -eq $regionName }
  $name = $school.Name
  $schoolUrl = "$siteUrl/schools/$($school.Id).html"
  $gradeHref = "../regions/$($region.Slug)-$($grade.Key).html"
  $description = "$($program.Description.Replace('{N}', $name)) $($region.Name) $($school.Town) 상담 $phone"
  $topics = ($program.Topics | ForEach-Object { "<article><span>$($grade.Label) $($_[0])</span><h3>$name $($_[0])</h3><p>$($_[1].Replace('{N}', $name))</p></article>" }) -join ''
  $schoolFaq = @(
    @("$name 시험 범위와 진도에 맞춰 수업하나요?", "네. $name 교과서와 진도, 시험 범위와 학사 일정을 확인해 단원별 학습 계획을 세웁니다."),
    @("$name 근처에서 수업을 받을 수 있나요?", "$($region.Name) $($school.Town) 등 $name 주변 학생과 상담하고 있습니다. 방문 수업 가능 여부와 일정은 전화 상담 시 안내해 드립니다."),
    $grade.Faq[1]
  )
  $founded = if ($school.Founded) { "<div><dt>설립일</dt><dd>$($school.Founded)</dd></div>" } else { "" }
  $regionLinks = (@("<a href=`"../regions/$($region.Slug).html`">$($region.Short) 수학과외 전체</a>") + ($grades | ForEach-Object { "<a href=`"../regions/$($region.Slug)-$($_.Key).html`">$($region.Short) $($_.Label) 수학과외</a>" })) -join ''
  $schoolMain = @"
    <section class="hero" aria-labelledby="school-title">
      <div class="hero-content">
        <p class="eyebrow">$($region.En) · SCHOOL MATH TUTORING</p>
        <h1 id="school-title">$name 수학과외,<br><em>$($program.Tagline)</em></h1>
        <p class="hero-copy">$($region.Name) $($school.Town)에 있는 $name 학생의 교과 진도와 시험 범위, 현재 실력을 함께 살펴 1:1로 수학을 지도합니다.</p>
        <div class="hero-actions"><a class="primary-button" href="tel:01029283614">무료 학습 상담</a><a class="phone-link" href="tel:01029283614">$phone</a></div>
      </div>
    </section>
    <nav class="breadcrumb" aria-label="현재 위치"><a href="../">충북 수학과외</a><span aria-hidden="true">/</span><a href="../regions/$($region.Slug).html">$($region.Name) 수학과외</a><span aria-hidden="true">/</span><a href="$gradeHref">$($grade.Label) 수학</a><span aria-hidden="true">/</span><span aria-current="page">$name</span></nav>
    <section class="section topics">
      <div class="section-heading"><p class="eyebrow dark">SCHOOL PROGRAM</p><h2>$name<br>수학, 이렇게 준비합니다.</h2></div>
      <p class="section-copy">$($region.Focus)</p>
      <div class="topic-grid school-topics">$topics</div>
    </section>
    <section class="section school-info">
      <div class="section-heading"><p class="eyebrow dark">SCHOOL INFO</p><h2>$name<br>학교 정보</h2></div>
      <dl class="info-list"><div><dt>학교급</dt><dd>$($school.Level)</dd></div><div><dt>설립 구분</dt><dd>$($school.Type)</dd></div>$founded<div><dt>소재지</dt><dd>$($school.Address)</dd></div><div><dt>교육지원청</dt><dd>$($school.Office)</dd></div></dl>
      <p class="data-note">출처: 전국초중등학교위치표준데이터 (2026-10-26 기준)</p>
    </section>
    <section class="section nearby">
      <div class="nearby-column"><h2>$name 인근 $($school.Level)</h2>$(Get-NearbyList $school $school.Level 6)</div>
      <div class="nearby-column"><h2>$name $($program.NextLabel)</h2>$(Get-NearbyList $school $program.Next 4)</div>
    </section>
    <section class="section faq"><div class="section-heading"><p class="eyebrow dark">FAQ</p><h2>$name 수학과외<br>자주 묻는 질문</h2></div><div class="faq-list">$(Get-FaqHtml $schoolFaq)</div></section>
    <section class="section region-navigation"><p class="eyebrow dark">$($region.En) PROGRAM</p><h2>$($region.Name) 수학과외 더 보기</h2><nav class="region-links grade-links" aria-label="$($region.Name) 수학과외">$regionLinks</nav></section>
    <section class="cta"><p>START YOUR WAY</p><h2>$name 수학과외,<br>편하게 상담해 보세요.</h2><div><a class="primary-button" href="tel:01029283614">전화 상담하기</a><a class="phone-link" href="tel:01029283614">$phone</a></div></section>
"@
  Write-Page "$($school.Id).html" (Get-Page @{
    Title="$name 수학과외 | $($region.Short) $($grade.Label) $($program.Tail) 수업"; Description=$description; Url=$schoolUrl
    BackHref=$gradeHref; BackText="$($region.Short) $($grade.Label) 수학과외"; Main=$schoolMain
    JsonLd=(Get-JsonLd $schoolUrl "$name 수학과외" $description @(@("충북 수학과외", "$siteUrl/"), @("$($region.Name) 수학과외", "$siteUrl/regions/$($region.Slug).html"), @("$($grade.Label) 수학과외", "$siteUrl/regions/$($region.Slug)-$($grade.Key).html"), @("$name 수학과외", $schoolUrl)) $schoolFaq)
  }) $schoolDirectory
  $sitemapUrls += $schoolUrl
}

$sitemapEntries = ($sitemapUrls | ForEach-Object {
  $priority = if ($_ -eq "$siteUrl/") { "1.0" } elseif ($_ -like "*/schools/*") { "0.6" } elseif ($_ -match '-(elementary|middle|high)(-\d)?\.html$') { "0.7" } else { "0.8" }
  "  <url><loc>$_</loc><lastmod>$today</lastmod><priority>$priority</priority></url>"
}) -join "`n"
$sitemap = "<?xml version=`"1.0`" encoding=`"UTF-8`"?>`n<urlset xmlns=`"http://www.sitemaps.org/schemas/sitemap/0.9`">`n$sitemapEntries`n</urlset>"
[System.IO.File]::WriteAllText((Join-Path $PSScriptRoot "sitemap.xml"), $sitemap + "`n", (New-Object System.Text.UTF8Encoding $false))

Write-Host "Generated $($regions.Count) regional pages, $($regions.Count * $grades.Count) grade pages, $($regions.Count * $years.Count) year pages and $($schools.Count) school pages."
