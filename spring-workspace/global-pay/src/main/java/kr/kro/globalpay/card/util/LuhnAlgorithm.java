package kr.kro.globalpay.card.util;

public class LuhnAlgorithm {

	public static int getLastNum(String cardNO) {
		
	    char[] array = cardNO.toCharArray();
		
		int sum = 0;
		int sumOne = 0;
		int sumTwo = 0;
		
		for (int i = 0; i < array.length - 1; i++) {
			
			int n = Character.getNumericValue(array[i]);
			
			// 홀수이면?
			if ((i - 1)  % 2 == 0) {
				sumOne += n;
			} 
			// 짝수이면?
			else {
				final int two = n * 2;
				sumTwo += two;
			}
			
		}

		// 곱한 수가 두 자리이면?
		if(sumOne / 10 > 0) {
			int one = sumOne / 10;
			int two = sumOne % 10;
			
			sumOne = (one + two);
		}
		
		sum = (sumOne + sumTwo);
		
		return 10 - (sum % 10);
	}

}