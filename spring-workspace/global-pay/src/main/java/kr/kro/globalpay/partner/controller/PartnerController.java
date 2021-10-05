package kr.kro.globalpay.partner.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.kro.globalpay.currency.service.CurrencyService;
import kr.kro.globalpay.currency.vo.NationCodeVO;
import kr.kro.globalpay.partner.service.PartnerService;
import kr.kro.globalpay.partner.vo.PartnerVO;
import kr.kro.globalpay.shopping.vo.ProductVO;

@Controller
public class PartnerController {

	@Autowired
	ServletContext servletContext;

	@Autowired
	private PartnerService service;

	@Autowired
	private CurrencyService cService;

	@RequestMapping("/partner")
	public String index() {
		return "partner/index";
	}

	@GetMapping("/partner/product/upload")
	public ModelAndView addProduct(Authentication authentication) {

		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String memberId = userDetails.getUsername();

		PartnerVO vo = service.selectOnePartner(memberId);
		List<NationCodeVO> nations = cService.nationAll();

		ModelAndView mav = new ModelAndView("partner/product/upload");
		mav.addObject("vo", vo);
		mav.addObject("nations", nations);

		return mav;
	}

	@PostMapping("/partner/product/upload")
	public String addProduct(ProductVO product) {
		service.insertProductOne(product);

		return "redirect:/partner";
	}

	@GetMapping("/partner/product/upload-mass")
	public ModelAndView addProductsForm(Authentication authentication) {

		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String memberId = userDetails.getUsername();

		PartnerVO vo = service.selectOnePartner(memberId);
		List<NationCodeVO> nations = cService.nationAll();

		ModelAndView mav = new ModelAndView("partner/product/upload-mass");
		mav.addObject("vo", vo);
		mav.addObject("nations", nations);

		return mav;
	}

	/**
	 * 업로드된 엑셀 파일 읽어서 list로 만드는 컨트롤러
	 * @param testFile
	 * @param request
	 * @return
	 */
	@PostMapping("/partner/product/excel")
	public ModelAndView convertExcel(@RequestPart("excelFile") MultipartFile file, HttpServletRequest request) throws Exception{
		
		List<ProductVO> dataList = new ArrayList<>();

	    String extension = FilenameUtils.getExtension(file.getOriginalFilename()); 

	    if (!extension.equals("xlsx") && !extension.equals("xls")) {
	      throw new IOException("엑셀파일만 업로드 해주세요.");
	    }

	    Workbook workbook = null;

	    if (extension.equals("xlsx")) {
	      workbook = new XSSFWorkbook(file.getInputStream());
	    } else if (extension.equals("xls")) {
	      workbook = new HSSFWorkbook(file.getInputStream());
	    }

	    Sheet worksheet = workbook.getSheetAt(0);

	    for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); i++) { 

	      Row row = worksheet.getRow(i);

	      ProductVO product = new ProductVO();

	      product.setUrl( row.getCell(0).getStringCellValue());
	      product.setImg( row.getCell(1).getStringCellValue());
	      product.setBrand( row.getCell(2).getStringCellValue());
	      product.setName( row.getCell(3).getStringCellValue());
	      product.setCurrency(row.getCell(4).getStringCellValue());
	      product.setPrice((int)row.getCell(5).getNumericCellValue());

	      dataList.add(product);
	    }
	    
	    HttpSession session = request.getSession();
	    
	    if(session.getAttribute("excelProducts") != null) {
	    	session.removeAttribute("excelProducts");
	    }
	    
	    session.setAttribute("excelProducts", dataList);

	    
	    ModelAndView mav = new ModelAndView("/partner/product/excel");
	    mav.addObject("list", dataList);

	    return mav;
	}
	
	/*
	파일 저장하는 컨트롤러
	
	@PostMapping("/partner/product/upload-mass")
	public ModelAndView addProducts(MultipartHttpServletRequest mRequest) throws Exception{
		
		// 실행되는 웹어플리케이션의 실제 경로 가져오기
		String uploadDir = servletContext.getRealPath("/upload/");
		System.out.println(uploadDir);
		
		ModelAndView mav = new ModelAndView("file/uploadResult");
		
		String id = mRequest.getParameter("id");
		System.out.println("id : " + id);
		
		Iterator<String> iter = mRequest.getFileNames();
		while (iter.hasNext()) {
			
			String formFileName = iter.next();
			// 폼에서 파일을 선택하지 않아도 객체 생성됨
			MultipartFile mFile = mRequest.getFile(formFileName);
			
			// 원본 파일명
			String oriFileName = mFile.getOriginalFilename();
			System.out.println("원본 파일명 : " + oriFileName);
			
			if (oriFileName != null && !oriFileName.equals("")) {
				
				// 확장자 처리
				String ext = "";
				// 뒤쪽에 있는 . 의 위치
				int index = oriFileName.lastIndexOf(".");
				if (index != -1) {
					// 파일명에서 확장자명(.포함)을 추출
					ext = oriFileName.substring(index);
				}
				
				// 파일 사이즈
				long fileSize = mFile.getSize();
				System.out.println("파일 사이즈 : " + fileSize);
				
				// 고유한 파일명 만들기
				String saveFileName = "gp" + UUID.randomUUID().toString() + ext;
				System.out.println("저장할 파일명 : " + saveFileName);
				
				// 임시저장된 파일을 원하는 경로에 저장
				mFile.transferTo(new File(uploadDir + saveFileName));
			}
		}
		return mav;
	}
	*/
	
	@PostMapping("/partner/product/upload-mass")
	public String addProducts(Authentication authentication, HttpServletRequest request) {

		// 엑셀에 없는 내용 : seller_id, shop_code
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String memberId = userDetails.getUsername();
		PartnerVO vo = service.selectOnePartner(memberId);

		// 엑셀 내용 : url, img, brand, name, price, currency
		HttpSession session = request.getSession();
		List<ProductVO> products = (List<ProductVO>) session.getAttribute("excelProducts");
		session.removeAttribute("excelProducts");
		
		for(ProductVO product : products) {
			product.setSellerId(memberId);
			product.setShopCode(vo.getShopCode());
		}
		
		System.out.println(products);
		
		service.insertProductMass(products);
		
		return "redirect:/partner";
	}
		
	

}
