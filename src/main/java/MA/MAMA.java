package MA;

public class MAMA {
	public static void main(String[] args) {
		String s = "Hello World";

		char[] charArray = s.toCharArray();
		System.out.print("反轉後的字串 (方法一): ");
		for (int i = charArray.length - 1; i >= 0; i--) {
			System.out.print(charArray[i]);
		}

	}

//		請建立一個字串，經過程式執行後，輸入結果是反過來的
//		例如String s = “Hello World”，執行結果即為dlroW olleH(提示：String方法，陣列)

}

