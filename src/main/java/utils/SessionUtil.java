package utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionUtil {

    public static boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false); // Don't create new
        return session != null && session.getAttribute("user") != null;
    }

    public static void setUserSession(HttpServletRequest request, Object user) {
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
    }

    public static void logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
