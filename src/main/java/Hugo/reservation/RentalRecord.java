package Hugo.reservation;


	import java.util.ArrayList;
	import java.util.Scanner;

	class RentalRecord {
	    private String borrowerName;
	    private String itemName;
	    private String rentalDate;
	    private String returnDate;

	    public RentalRecord(String borrowerName, String itemName, String rentalDate, String returnDate) {
	        this.borrowerName = borrowerName;
	        this.itemName = itemName;
	        this.rentalDate = rentalDate;
	        this.returnDate = returnDate;
	    }

	    public String getBorrowerName() {
	        return borrowerName;
	    }

	    public String getItemName() {
	        return itemName;
	    }

	    public String getRentalDate() {
	        return rentalDate;
	    }

	    public String getReturnDate() {
	        return returnDate;
	    }

	    public void setReturnDate(String returnDate) {
	        this.returnDate = returnDate;
	    }

	    @Override
	    public String toString() {
	        return "租借者: " + borrowerName + ", 物品: " + itemName +
	                ", 租借日期: " + rentalDate + ", 歸還日期: " + (returnDate.isEmpty() ? "未歸還" : returnDate);
	    }
	}

	 class RentalManagement {
	    private static ArrayList<RentalRecord> records = new ArrayList<>();
	    private static Scanner scanner = new Scanner(System.in);

	    public static void main(String[] args) {
	        while (true) {
	            System.out.println("\n租借記錄管理系統");
	            System.out.println("1. 新增租借記錄");
	            System.out.println("2. 查看所有記錄");
	            System.out.println("3. 查詢記錄");
	            System.out.println("4. 更新記錄");
	            System.out.println("5. 刪除記錄");
	            System.out.println("6. 離開");
	            System.out.print("選擇功能: ");

	            int choice = scanner.nextInt();
	            scanner.nextLine(); // 清除緩衝區

	            switch (choice) {
	                case 1:
	                    addRecord();
	                    break;
	                case 2:
	                    viewRecords();
	                    break;
	                case 3:
	                    searchRecords();
	                    break;
	                case 4:
	                    updateRecord();
	                    break;
	                case 5:
	                    deleteRecord();
	                    break;
	                case 6:
	                    System.out.println("退出系統。");
	                    return;
	                default:
	                    System.out.println("無效的選擇，請重新輸入。");
	            }
	        }
	    }

	    private static void addRecord() {
	        System.out.print("輸入租借者姓名: ");
	        String borrower = scanner.nextLine();
	        System.out.print("輸入物品名稱: ");
	        String item = scanner.nextLine();
	        System.out.print("輸入租借日期 (YYYY-MM-DD): ");
	        String rentalDate = scanner.nextLine();

	        records.add(new RentalRecord(borrower, item, rentalDate, ""));
	        System.out.println("記錄已新增！");
	    }

	    private static void viewRecords() {
	        if (records.isEmpty()) {
	            System.out.println("目前沒有租借記錄。");
	        } else {
	            System.out.println("\n所有租借記錄:");
	            for (int i = 0; i < records.size(); i++) {
	                System.out.println((i + 1) + ". " + records.get(i));
	            }
	        }
	    }

	    private static void searchRecords() {
	        System.out.print("輸入查詢條件 (租借者/物品名稱): ");
	        String keyword = scanner.nextLine();
	        boolean found = false;

	        for (RentalRecord record : records) {
	            if (record.getBorrowerName().contains(keyword) || record.getItemName().contains(keyword)) {
	                System.out.println(record);
	                found = true;
	            }
	        }

	        if (!found) {
	            System.out.println("未找到相關記錄。");
	        }
	    }

	    private static void updateRecord() {
	        System.out.print("輸入要更新的記錄編號: ");
	        int index = scanner.nextInt() - 1;
	        scanner.nextLine(); // 清除緩衝區

	        if (index >= 0 && index < records.size()) {
	            System.out.print("輸入新的歸還日期 (YYYY-MM-DD): ");
	            String returnDate = scanner.nextLine();
	            records.get(index).setReturnDate(returnDate);
	            System.out.println("記錄已更新！");
	        } else {
	            System.out.println("無效的記錄編號。");
	        }
	    }

	    private static void deleteRecord() {
	        System.out.print("輸入要刪除的記錄編號: ");
	        int index = scanner.nextInt() - 1;

	        if (index >= 0 && index < records.size()) {
	            records.remove(index);
	            System.out.println("記錄已刪除！");
	        } else {
	            System.out.println("無效的記錄編號。");
	        }
	    }
	}
