package com.utils.datasource;

import javax.sql.DataSource;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class HikariDataSourceUtil {

    // 靜態初始化 HikariDataSource
    private static final HikariDataSource dataSource;

    static {
        // 配置 HikariCP
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:mysql://localhost:3306/voicebus?serverTimezone=Asia/Taipei");
        config.setUsername("root");
        config.setPassword("liupeter480");
        config.setDriverClassName("com.mysql.cj.jdbc.Driver");

        // HikariCP 相關設定
        config.setMaximumPoolSize(20);
        config.setMinimumIdle(5);
        config.setIdleTimeout(60000); // 空閒連線的超時時間 (毫秒)
        config.setMaxLifetime(1800000); // 連線的最大存活時間 (毫秒)
        config.setConnectionTimeout(30000); // 等待連線的最大時間 (毫秒)

        // 初始化 DataSource
        dataSource = new HikariDataSource(config);
    }

    // 獲取 DataSource
    public static DataSource getDataSource() {
        return dataSource;
    }
}
