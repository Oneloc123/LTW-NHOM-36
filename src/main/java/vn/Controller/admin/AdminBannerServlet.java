
package vn.Controller.admin;

import vn.model.Banner;
import vn.services.BannerSevice;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/admin/banners")
public class AdminBannerServlet extends HttpServlet {

    private BannerSevice bannerService;
    private DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @Override
    public void init() {
        bannerService = new BannerSevice();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("id") == null || session.getAttribute("role") == null) {
            req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
            return;
        }

        String action = req.getParameter("action");

        if (action == null) {
            listBanners(req, resp);
            return;
        }

        switch (action) {
            case "view":
                viewBanner(req, resp);
                break;
            case "delete":
                deleteBanner(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                Banner editBanner = bannerService.getBannerById(id);
                req.setAttribute("editBanner", editBanner);
                listBanners(req, resp);
                break;
            default:
                listBanners(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            addBanner(req, resp);
        } else if ("edit".equals(action)) {
            editBanner(req, resp);
        }
    }

    // ===== METHODS =====

    private void listBanners(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        String status = req.getParameter("status");

        List<Banner> banners;

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasStatus = status != null && !status.isEmpty();

        if (hasKeyword || hasStatus) {
            banners = bannerService.filterBanners(keyword, status);
        } else {
            banners = bannerService.getAllBanners();
        }

        req.setAttribute("banners", banners);
        req.getRequestDispatcher("/admin/admin-banners.jsp").forward(req, resp);
    }

    private void viewBanner(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Banner banner = bannerService.getBannerById(id);

        req.setAttribute("banner", banner);
        req.getRequestDispatcher("/admin/banner-detail.jsp").forward(req, resp);
    }

    private void addBanner(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Banner banner = new Banner();
        banner.setTitle(req.getParameter("Title"));
        banner.setImageURL(req.getParameter("ImageURL"));
        banner.setLinkURL(req.getParameter("LinkURL"));
        banner.setAltText(req.getParameter("AltText"));

        // Xử lý LocalDate
        try {
            String startDateStr = req.getParameter("StartDate");
            if (startDateStr != null && !startDateStr.isEmpty()) {
                banner.setStartDate(LocalDate.parse(startDateStr, dateFormatter));
            }

            String endDateStr = req.getParameter("EndDate");
            if (endDateStr != null && !endDateStr.isEmpty()) {
                banner.setEndDate(LocalDate.parse(endDateStr, dateFormatter));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        banner.setSortOrder(Integer.parseInt(req.getParameter("SortOrder")));
        banner.setStatus(Integer.parseInt(req.getParameter("Status")));

        bannerService.addBanner(banner);
        resp.sendRedirect("banners");
    }

    private void editBanner(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Banner banner = new Banner();
        banner.setId(Integer.parseInt(req.getParameter("id")));
        banner.setTitle(req.getParameter("Title"));
        banner.setImageURL(req.getParameter("ImageURL"));
        banner.setLinkURL(req.getParameter("LinkURL"));
        banner.setAltText(req.getParameter("AltText"));

        // Xử lý LocalDate
        try {
            String startDateStr = req.getParameter("StartDate");
            if (startDateStr != null && !startDateStr.isEmpty()) {
                banner.setStartDate(LocalDate.parse(startDateStr, dateFormatter));
            } else {
                banner.setStartDate(null);
            }

            String endDateStr = req.getParameter("EndDate");
            if (endDateStr != null && !endDateStr.isEmpty()) {
                banner.setEndDate(LocalDate.parse(endDateStr, dateFormatter));
            } else {
                banner.setEndDate(null);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        banner.setSortOrder(Integer.parseInt(req.getParameter("SortOrder")));
        banner.setStatus(Integer.parseInt(req.getParameter("Status")));

        bannerService.updateBanner(banner);
        resp.sendRedirect("banners");
    }

    private void deleteBanner(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        bannerService.deleteBannerById(id);
        resp.sendRedirect("banners");
    }
}
