package module;

import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.concurrent.*;

public class Schema {
    ScheduledExecutorService executor = Executors.newScheduledThreadPool(1);
    ScheduledFuture<?> scheduledTask = null;

    /**
     * => void run(String input)
     * 1. schemaTask(ScheduledExecutorService executor, ScheduledFuture<?>
     * scheduledTask) // Đặt lịch hẹn
     * setting--hh/mm/ss//period
     * 2. void stop(ScheduledExecutorService executor, ScheduledFuture<?>
     * scheduledTask) // Dừng
     * 3. void emergencyStop(ScheduledExecutorService executor) // Dừng hẳn
     */
    private static long calculateInitialDelay(LocalTime now, LocalTime targetTime) {
        long initialDelay = now.until(targetTime, ChronoUnit.SECONDS);
        System.out.println(now.toString());
        if (initialDelay < 0) {
            // Nếu đã qua thời điểm cần chạy, tính lại thời gian đợi cho ngày tiếp theo
            LocalTime endOfDay = LocalTime.of(23, 59, 59); // Thời điểm cuối ngày
            long timeUntilEndOfDay = now.until(endOfDay, ChronoUnit.SECONDS);
            long timeFromStartOfDay = endOfDay.until(targetTime, ChronoUnit.SECONDS);
            initialDelay = timeUntilEndOfDay + timeFromStartOfDay;
        }
        return initialDelay;
    }

    private static void schemaTask(ScheduledExecutorService executor, ScheduledFuture<?> scheduledTask) {
        LocalTime now = LocalTime.now();
        LocalTime targetTime = LocalTime.of(8, 30, 00); // Thời gian cần chạy (8:0:0 giờ)
        long initialDelay = calculateInitialDelay(now, targetTime);
        scheduledTask = executor.scheduleAtFixedRate(() -> {
            System.out.println("hi.");
            new Staging().staging();
        }, initialDelay, 5, TimeUnit.SECONDS);
    }

    private static void stop(ScheduledExecutorService executor, ScheduledFuture<?> scheduledTask) {
        executor.schedule(() -> {
            scheduledTask.cancel(false);
            executor.shutdown();
        }, 1, TimeUnit.DAYS);
    }

    private static void emergencyStop(ScheduledExecutorService executor) {
        executor.shutdown();
    }

    public void run(String input) {
        if (input.equals("stop--emergency")) {
            emergencyStop(executor);
        } else if (input.equals("stop")) {
            stop(executor, scheduledTask);
        } else if (input.equals("run--hands")) {
            stop(executor, scheduledTask);
            new Staging().staging();
        } else if (input.equals("run--auto")){
            schemaTask(executor, scheduledTask);
        }
    }
        /**
         * chạy auto
         * chạy tay
         * dừng - thời gian sẽ dừng
         * dừng hẳn - chạy tay => vẫn còn những tiến trình đang chạy
         * input nhập vào ???????
         */
    
}
