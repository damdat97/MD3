package filter;

import conn.ConnectionUtils;
import utils.MyUtils;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Collections;
import java.util.Map;

@WebFilter(filterName = "JDBCFilter", urlPatterns = {"/*"})
public class JDBCFilter implements Filter {
    public JDBCFilter() {
    }

    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    //Kiem tra muc tieu cua request hien tai la 1 servlet
    private boolean needJBDC(HttpServletRequest request) {
        System.out.println("JDBC filter");
        String servletPath = request.getServletPath();
        String pathInfo = request.getPathInfo();
        String urlPattern = servletPath;
        if (pathInfo != null) {
            urlPattern = servletPath + "/*";
        }
        Map<String, ? extends  ServletRegistration> servletRegistrations = request.getServletContext().getServletRegistrations();
        Collection<? extends ServletRegistration> values = servletRegistrations.values();
        for (ServletRegistration sr : values) {
            Collection<String> mappings = sr.getMappings();
            if (mappings.contains(urlPattern)) {
                return true;
            }
        }
        return false;
    }
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        if (this.needJBDC(req)) {
            System.out.println("Open Connection for: " + req.getServletPath());
            Connection conn = null;
            try {
                //Tao doi tuong Connection ket noi database
                conn = ConnectionUtils.getConnection();
                conn.setAutoCommit(false);
                MyUtils.storeConnection(request, conn);
                chain.doFilter(request, response);
                conn.commit();
            } catch (SQLException e) {
                e.printStackTrace();
                ConnectionUtils.rollbackQuietly(conn);
                throw new ServletException();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                ConnectionUtils.closeQuietly(conn);
            }
        }
        else {
            chain.doFilter(request, response);
        }
    }
}
