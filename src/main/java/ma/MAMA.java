package ma;

public class MAMA {
	public static void main(String[] args) {
		String s = "Hello World";

		char[] charArray = s.toCharArray();
		System.out.print("反轉後的字串 (方法一): ");
		for (int i = charArray.length - 1; i >= 0; i--) {
			System.out.print(charArray[i]);
		}

	}

}

