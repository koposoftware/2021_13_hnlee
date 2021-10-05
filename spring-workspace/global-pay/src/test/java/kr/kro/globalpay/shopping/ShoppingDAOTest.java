package kr.kro.globalpay.shopping;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import kr.kro.globalpay.Configure;
import kr.kro.globalpay.shopping.dao.ShoppingDAO;
import kr.kro.globalpay.shopping.vo.FavouriteListVO;
import kr.kro.globalpay.shopping.vo.ProductVO;

public class ShoppingDAOTest extends Configure {
	
	@Autowired
	private ShoppingDAO sDao;
	
	@Ignore
	@Test
	public void 찜목록_추가_test() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", "hanny");
		map.put("product", 60);
		
		sDao.addFavourite(map);
		
	}

	@Ignore
	@Test
	public void 찜목록_중복_확인_test() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", "hanny");
		map.put("product", 428);
		
		int cnt = sDao.countFavoiriteById(map);
		System.out.println(cnt);
	}
	
	@Test
	public void 찜목록_조회_test() {
		String id = "hanny";
		List<FavouriteListVO> list = sDao.selectAllFavoiriteById(id);
		System.out.println(list);
	}

}
