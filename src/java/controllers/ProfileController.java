package controllers;

import entities.User;
import java.util.Date;
import javax.ejb.EJB;
import sessionbeans.UserFacade;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProfileController {

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/UserFacade")
    private UserFacade userFacade;

    /**
     * Trang xem profile
     */
    @RequestMapping("/profile")
    public ModelAndView profile(HttpSession session) {
        User user = (User) session.getAttribute("currentUser");
        ModelAndView mv = new ModelAndView("authentication/profile");

        if (user != null) {
            mv.addObject("user", user);
        } else {
            mv.setViewName("authentication/login");
        }

        return mv;
    }

    /**
     * Trang edit profile (GET)
     */
    @RequestMapping("/editProfile")
    public ModelAndView editProfile(HttpSession session) {
        User user = (User) session.getAttribute("currentUser");
        ModelAndView mv = new ModelAndView("authentication/editProfile");

        if (user != null) {
            mv.addObject("user", user);
        } else {
            mv.setViewName("authentication/login");
        }

        return mv;
    }

    @RequestMapping(value = "/updateFullName", method = RequestMethod.POST)
    public String updateFullName(HttpSession session, @RequestParam String fullName) {
        User user = (User) session.getAttribute("currentUser");
        user.setFullName(fullName);
        user.setUpdatedAt(new Date());
        userFacade.edit(user);
        session.setAttribute("currentUser", user);
        return "redirect:/profile";
    }

    @RequestMapping(value = "/updatePhoneNumber", method = RequestMethod.POST)
    public String updatePhoneNumber(HttpSession session, @RequestParam String phoneNumber) {
        User user = (User) session.getAttribute("currentUser");
        user.setPhoneNumber(phoneNumber);
        user.setUpdatedAt(new Date());
        userFacade.edit(user);
        session.setAttribute("currentUser", user);
        return "redirect:/profile";
    }

    @RequestMapping(value = "/updateGender", method = RequestMethod.POST)
    public String updateGender(HttpSession session, @RequestParam String gender) {
        User user = (User) session.getAttribute("currentUser");
        user.setGender(gender);
        user.setUpdatedAt(new Date());
        userFacade.edit(user);
        session.setAttribute("currentUser", user);
        return "redirect:/profile";
    }

    @RequestMapping(value = "/updateDateOfBirth", method = RequestMethod.POST)
    public String updateDateOfBirth(HttpSession session,
            @RequestParam("dateOfBirth") @DateTimeFormat(pattern = "yyyy-MM-dd") Date dateOfBirth) {
        User user = (User) session.getAttribute("currentUser");
        user.setDateOfBirth(dateOfBirth);
        user.setUpdatedAt(new Date());
        userFacade.edit(user);
        session.setAttribute("currentUser", user);
        return "redirect:/profile";
    }

    // Hiển thị form đổi mật khẩu
    @RequestMapping("/changePassword")
    public ModelAndView changePasswordPage(HttpSession session) {
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }
        return new ModelAndView("authentication/changePassword");
    }

// Xử lý form đổi mật khẩu
    @RequestMapping(value = "/changePassword", method = RequestMethod.POST)
    public ModelAndView changePasswordProcess(
            HttpSession session,
            @RequestParam("currentPassword") String currentPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword) {

        User user = (User) session.getAttribute("currentUser");
        ModelAndView mv = new ModelAndView("authentication/changePassword");

        if (user == null) {
            mv.setViewName("redirect:/login");
            return mv;
        }

        // Kiểm tra mật khẩu hiện tại
        if (!BCrypt.checkpw(currentPassword, user.getHashPassword())) {
            mv.addObject("error", "Current password is incorrect.");
            return mv;
        }

        // Kiểm tra mật khẩu mới và xác nhận
        if (!newPassword.equals(confirmPassword)) {
            mv.addObject("error", "New password and confirmation do not match.");
            return mv;
        }

        // Cập nhật mật khẩu mới
        String hashedNewPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        user.setHashPassword(hashedNewPassword);
        user.setUpdatedAt(new Date());
        userFacade.edit(user);

        mv.addObject("success", "Password updated successfully.");
        return mv;
    }
}
