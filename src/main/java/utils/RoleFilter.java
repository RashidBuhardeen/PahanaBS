package utils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {"/cashier", "/cashier/*"})
public class RoleFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req  = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        boolean loggedIn = SessionUtil.isLoggedIn(req);
        boolean isCashier = SessionUtil.hasRole(req, "cashier");
        boolean isAdmin   = SessionUtil.hasRole(req, "admin");

        if (!loggedIn || !(isCashier || isAdmin)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override public void init(FilterConfig filterConfig) {}
    @Override public void destroy() {}
}
