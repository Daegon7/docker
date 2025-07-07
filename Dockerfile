# 1단계: Gradle로 JAR 빌드
FROM gradle:8.5.0-jdk17 AS builder

WORKDIR /app

# Gradle 관련 파일 먼저 복사 (캐시 최적화)
COPY build.gradle settings.gradle gradlew gradlew.bat /app/
COPY gradle /app/gradle/
RUN chmod +x gradlew

# 의존성 다운로드 (캐시 최적화)
RUN ./gradlew dependencies --no-daemon

# 소스 코드 복사
COPY src /app/src/

# JAR 빌드 (테스트 생략)
RUN ./gradlew clean bootJar -x test --no-daemon

# 2단계: 실행용 이미지 (JDK 24)
FROM eclipse-temurin:24-jdk

WORKDIR /app

# 비루트 사용자 생성 (보안)
RUN addgroup --system spring && adduser --system spring --ingroup spring

# 빌드된 JAR 복사
COPY --from=builder /app/build/libs/*.jar app.jar

# 소유권 변경
RUN chown spring:spring app.jar

# 사용자 변경
USER spring:spring

EXPOSE 8080

# 헬스체크 (선택사항)
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

# JAR 실행
CMD ["java", "-Xmx512m", "-Xms256m", "-jar", "app.jar"]