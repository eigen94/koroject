package org.kosta.crolling.domain;

import java.io.IOException;
import java.io.InputStream;
 
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

public class HttpUtils {

	 /**
     * apache httpclient 4.x 를 사용한 uri 의 html source 가져와서 문자열로 리턴
     * @param uri
     * @return
     */
    public static String toHtmlStr(String uri) {
        InputStream is = null;
        try {
            DefaultHttpClient httpclient = new DefaultHttpClient();
            HttpGet httpget = new HttpGet(uri);
            HttpResponse response = httpclient.execute(httpget);
            HttpEntity entity = response.getEntity();
            is = entity.getContent();
            StringBuffer out = new StringBuffer();
            byte[] b = new byte[4096];
            for (int n; (n = is.read(b)) != -1;) {
                out.append(new String(b, 0, n));
            }
            return out.toString();
        } catch (IllegalStateException | IOException e) {
            throw new RuntimeException(e);
        } finally {
            if (is != null) try { is.close(); } catch (Exception e) {}
        }
    }
}
