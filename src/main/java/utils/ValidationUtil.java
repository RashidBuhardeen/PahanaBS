package utils;

import java.util.regex.Pattern;

public class ValidationUtil {

    // Check if a string is null or empty
    public static boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    // Check if a string is a valid integer
    public static boolean isInteger(String value) {
        if (isEmpty(value)) return false;
        try {
            Integer.parseInt(value);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    // Check if a string is a valid double
    public static boolean isDouble(String value) {
        if (isEmpty(value)) return false;
        try {
            Double.parseDouble(value);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    // Check if a string is a valid email
    public static boolean isEmail(String value) {
        if (isEmpty(value)) return false;
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return Pattern.matches(emailRegex, value);
    }

    // Check if a string is a valid phone number (simple, digits only)
    public static boolean isPhoneNumber(String value) {
        if (isEmpty(value)) return false;
        String phoneRegex = "\\d{10,15}"; // allows 10-15 digits
        return Pattern.matches(phoneRegex, value);
    }

    // Check if a string contains only letters and spaces
    public static boolean isAlphabetic(String value) {
        if (isEmpty(value)) return false;
        return Pattern.matches("[a-zA-Z ]+", value);
    }

    // Validate string length (min and max)
    public static boolean isLengthValid(String value, int min, int max) {
        if (value == null) return false;
        int length = value.trim().length();
        return length >= min && length <= max;
    }
}
