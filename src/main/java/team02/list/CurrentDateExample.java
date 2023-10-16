package team02.list;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class CurrentDateExample {
    public static void main(String[] args) {
        // 현재 날짜를 가져오기
        LocalDate currentDate = LocalDate.now();

        // 원하는 형식으로 날짜를 포맷
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        String formattedDate = currentDate.format(formatter);

        // 결과 출력
        System.out.println("현재 날짜(YYYYMMDD 형식): " + formattedDate);
    }
}
