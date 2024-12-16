package com.matchingcases.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.sql.DataSource;
import com.zaxxer.hikari.HikariDataSource;
import com.utils.datasource.HikariDataSourceUtil; // 修改為你的工具類的實際路徑

@WebListener
public class AppContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // 初始化數據源並保存到 ServletContext
        DataSource dataSource = HikariDataSourceUtil.getDataSource();
        ServletContext context = sce.getServletContext();
        context.setAttribute("dataSource", dataSource);
        System.out.println("數據源已初始化並存儲到 ServletContext。");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();

        // 關閉 HikariDataSource 資源
        HikariDataSource dataSource = (HikariDataSource) context.getAttribute("dataSource");
        if (dataSource != null) {
            try {
                dataSource.close();
                System.out.println("HikariDataSource 已關閉。");
            } catch (Exception e) {
                System.err.println("關閉 HikariDataSource 時出現錯誤：" + e.getMessage());
                e.printStackTrace();
            }
        }

        // 清理 MySQL 驅動的清理線程
        try {
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("MySQL AbandonedConnectionCleanupThread 已清理。");
        } catch (Exception e) {
            System.err.println("清理 MySQL 清理線程時出現錯誤：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
