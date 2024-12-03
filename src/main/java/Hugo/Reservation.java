package Hugo;

import java.time.LocalDateTime;

public class Reservation {
    private String userName;
    private LocalDateTime reservationTime;

    public Reservation(String userName, LocalDateTime reservationTime) {
        this.userName = userName;
        this.reservationTime = reservationTime;
    }

    public String getUserName() {
        return userName;
    }

    public LocalDateTime getReservationTime() {
        return reservationTime;
    }

    @Override
    public String toString() {
        return "Reservation for " + userName + " at " + reservationTime;
    }
}
