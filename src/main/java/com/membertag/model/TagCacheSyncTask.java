package com.membertag.model;

import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class TagCacheSyncTask implements Runnable {
    private static final TagService tagService;

    static {
        try {
            tagService = new TagService();
        } catch (Exception e) {
            throw new RuntimeException("初始化 TagService 失敗: " + e.getMessage(), e);
        }
    }

    @Override
    public void run() {
        long startTime = System.currentTimeMillis();
        try {
            System.out.println("【同步開始】開始同步 MySQL 到 Redis...");

            List<TagVO> allTags = tagService.getAllTagsFromMySQL();
            tagService.syncAllTagsToRedis(allTags);

            long endTime = System.currentTimeMillis();
            System.out.println("【同步完成】同步成功，標籤數量: " + allTags.size() + "，耗時：" + (endTime - startTime) + " ms");
        } catch (Exception e) {
            System.err.println("【同步失敗】錯誤: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
        scheduler.scheduleAtFixedRate(new TagCacheSyncTask(), 0, 5, TimeUnit.MINUTES);

        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            try {
                tagService.close();
                System.out.println("【關閉資源】資源關閉完成");
            } catch (Exception e) {
                System.err.println("【關閉資源失敗】錯誤: " + e.getMessage());
            }
        }));
    }
}
