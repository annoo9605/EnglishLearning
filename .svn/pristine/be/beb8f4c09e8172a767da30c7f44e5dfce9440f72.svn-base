package com.learning.eng.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map<String, Object> down = (Map<String, Object>) model.get("down");
		List<Map<String, Object>> list = (List<Map<String, Object>>)down.get("fileList");
		
		String dspFileName = (String) list.get(0).get("DSP_FILE_NAME")+"."+list.get(0).get("EXTENSION");
		File file = (File) down.get("file");
		
		response.setHeader("Content-Disposition", "attachment; filename="
					+ new String(dspFileName.getBytes(), "utf-8") + ";charset=utf-8");
		
//		Internet Explorer Browser
//		response.setHeader("Content-Disposition", "attachment; filename="
//				+ URLEncoder.encode(dspFileName, "utf-8") + ";charset=utf-8");
		
		OutputStream out = response.getOutputStream();
		
		FileInputStream in = null;
		
		try {
			in = new FileInputStream(file);
			FileCopyUtils.copy(in, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			in.close();
			out.close();
		}
	}

}
