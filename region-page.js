const regionLinks = [
  ['청주시', 'cheongju-si'], ['충주시', 'chungju-si'], ['제천시', 'jecheon-si'],
  ['보은군', 'boeun-gun'], ['옥천군', 'okcheon-gun'], ['영동군', 'yeongdong-gun'],
  ['증평군', 'jeungpyeong-gun'], ['진천군', 'jincheon-gun'], ['괴산군', 'goesan-gun'],
  ['음성군', 'eumseong-gun'], ['단양군', 'danyang-gun'],
  ['상당구', 'cheongju-sangdang-gu'], ['서원구', 'cheongju-seowon-gu'],
  ['흥덕구', 'cheongju-heungdeok-gu'], ['청원구', 'cheongju-cheongwon-gu']
];

const currentRegion = document.body.dataset.region;
const links = regionLinks.map(([name, slug]) => {
  const fullName = name.endsWith('구') ? `청주시 ${name}` : name;
  const current = fullName === currentRegion ? ' aria-current="page"' : '';
  return `<a href="${slug}.html"${current}>${name}</a>`;
});

document.querySelector('.region-links').innerHTML = links.join('');
document.querySelector('#year').textContent = new Date().getFullYear();