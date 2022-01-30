# Doc4SM

**Doc4SM**은 ITIL 기반으로 IT 서비스를 프로세스화 하여 관리하는 시스템 입니다.
고객의 서비스 요청에 대한 관리 및 통계 등 종합적인 정보를 제공합니다.

## 기능 설명

### 1. 업무 관리

사용자 및 담당자가 쉽게 서비스에 대한 요청을 등록하고, 할당된 업무, 처리중인 업무, 완료된 업무에 대하여 관리 하는 기능을 제공 합니다.

###  2. 표준화된 방법론 활용

한국정보통신기술협회에서 제공하는 TTAS.KO-10.0256(정보시스템 구성 및 변경관리 지침)과 TTAS_KO-10_0261_(서비스데스크 운영관리 지침)의 표준 방법론을 활용합니다.

### 3. 최적화된 시스템 구축

CMDB 설계/구현을 지원 하며, 인프라 관리, 외부업체관리 등 유지관리에서 필요한 최적화된 시스템 환경을 제공합니다.

### 4. 산출물 자동 생성

한국정보통신기술협회(TTAS) 에서 제공하는 상위 지침의 산출물 생성을 지원 하며, 기타 유지관리에 필요한 산출물의 생성 기능을 제공합니다.

### 5. 통계 제공

완료된 업무의 기간별로 간트 차트, 업무통계, 서비스 별 통계, 태그 클라우드 등의 통계기능을 제공합니다.

## 환경

1. JAVA 1.8 이상
2. MAVEN

## 설치

1. Maven install

```
mvn clean install
```

2. target/doc4sm.war 파일을 Tomcat/webapps 로 이동


## DEMO SITE

~~* [DOC4SM DEMO](http://14.55.235.194:9025) - 계정&비번 : admin ~~ 


## License

This project is licensed under the GPL License - see the [WIKI-LICENSE](https://en.wikipedia.org/wiki/GNU_General_Public_License) file for details

