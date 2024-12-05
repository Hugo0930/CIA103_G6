package Hugo.reservation;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.List;

public class ReservationSystem {
    private List<Reservation> reservations;

    public ReservationSystem() {
        reservations = new ArrayList<>();
    }

    // 查看是否有空位
    public boolean isAvailable(LocalDateTime dateTime) {
        for (Reservation reservation : reservations) {
            if (reservation.getReservationTime().equals(dateTime)) {
                return false; // 時間已被預約
            }
        }
        return true; // 時間可用
    }

    // 新增預約
    public String makeReservation(String userName, LocalDateTime dateTime) {
        if (isAvailable(dateTime)) {
            reservations.add(new Reservation(userName, dateTime));
            return "Reservation successful for " + userName + " at " + dateTime;
        } else {
            return "Sorry, the selected time is already booked.";
        }
    }

    // 顯示所有預約
    public void showReservations() { 
        if (reservations.isEmpty()) {
            System.out.println("No reservations yet.");
        } else {
            for (Reservation reservation : reservations) {
                System.out.println(reservation);
            }
        }
    }
}
