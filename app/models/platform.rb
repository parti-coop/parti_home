class Platform
  DICTIONARY = {
    groups: {
      image_path: 'soft_solution_1.png',
      title: '빠띠 그룹스',
      description: '''
      팀과 커뮤니티의 협업을 위한 플랫폼
      <br><br>
      핵심 기능: 주제/이슈별 채널 관리, 공동문서 작성, 찬반 투표와 설문으로 토론하기, 아카이빙
      ''',
      url: 'https://parti.xyz'
    },
    demosx: {
      image_path: 'soft_solution_4.png',
      title: '데모스X',
      description: '''
      시민과 기관이 함께 정책을 논의하고 실행하는 시민참여 플랫폼
      <br><br>
      핵심 기능: 오픈소스 운영 가이드, 플랫폼 소스
      ''',
      url: 'http://demosx.org'
    },
    townhall: {
      image_path: 'soft_solution_2.png',
      title: '빠띠 타운홀',
      description: '''
      참가자 중심의 실시간 토론 플랫폼
      <br><br>
      핵심 기능: 상반되는 의견 중 하나를 선택하는 배틀, 최적의 결론을 도출하는 투표, 참가자와 소통하는 제안, 발표를 극적으로 연출하는 응원
      ''',
      url: 'https://townhall.kr'
    },
    campaigns: {
      image_path: 'soft_solution_3.png',
      title: '빠띠 캠페인즈',
      description: '''
      세상을 바꾸는 시민, 시민단체, 조직, 정당의 캠페인 플랫폼
      <br><br>
      핵심 기능: 지지를 얻기 위한 서명/지도/인증샷/목소리 모으기, 변화를 만들기 위한 촉구/아카이브하기
      ''',
      url: 'https://campaigns.kr'
    },
    datapublic: {
      image_path: 'soft_solution_5.png',
      title: '데이터퍼블릭',
      description: '''
      사회적으로 이슈가 된 사안들의 원본 데이터들을 출처와 함께 모읍니다.
      ''',
      url: 'https://datapublic.kr/data_sets'
    },
    archives: {
      image_path: 'soft_solution_6.png',
      title: '아카이브 (제작 중)',
      description: '',
      url: ''
    }
  }

  INFO = {
      slug: :soft,
      path_text: :solutions_soft_path,
      title: '민주주의 플랫폼',
      subtitle: '일상과 세상을 더 민주적으로',
      image_path: 'solutions/card-soft.png',
      items_name: '디지털 플랫폼',
      items: Platform::DICTIONARY.map { |key, item| item.merge(slug: key) },
      seo_desc: '플랫폼으로 사람들의 일상과 세상을 더 민주적으로 만듭니다.'
  }
end
