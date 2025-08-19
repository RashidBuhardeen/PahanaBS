
package utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionUtil {
    public static boolean isLoggedIn(HttpServletRequest request) {
        HttpSession s = request.getSession(false);
        return s != null && s.getAttribute("username") != null && s.getAttribute("role") != null;
    }

    public static boolean hasRole(HttpServletRequest request, String role) {
        HttpSession s = request.getSession(false);
        return isLoggedIn(request) && role.equalsIgnoreCase(String.valueOf(s.getAttribute("role")));
    }
}
