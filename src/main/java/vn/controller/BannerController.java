package vn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.model.Banner;
import vn.services.BannerSevice;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class BannerController extends HttpServlet
{

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        BannerSevice  bs = new BannerSevice();
        List<Banner> list = bs.getBanner();
        request.setAttribute("list", list);
        request.getRequestDispatcher("/pages/home.jsp").forward(request, response);
    }
}
