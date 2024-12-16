package com.membertag.controller;

import com.membertag.model.MemberTagsVO;
import com.membertag.model.TagVO;
import com.membertag.model.TagService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@WebServlet("/tagServlet")
public class TagServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private TagService tagService;

    @Override
    public void init() throws ServletException {
        this.tagService = new TagService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = Optional.ofNullable(request.getParameter("action")).orElse("");

        switch (action) {
            case "getMemberTags":
                getMemberTags(request, response);
                break;
            case "getTag":
                getTag(request, response);
                break;
            case "getAllTags":
                getAllTags(request, response);
                break;
            case "loadTagOptions":
                loadTagOptions(request, response);
                break;
            case "searchMembersByTagName":
                searchMembersByTagName(request, response);
                break;
            default:
                response.getWriter().write("無效的操作");
        }
    }

    private void getMemberTags(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            int memId = Integer.parseInt(request.getParameter("memId"));
            List<TagVO> tags = tagService.getTags(memId);
            MemberTagsVO memberTags = new MemberTagsVO(memId, tags);
            request.setAttribute("memberTags", memberTags);
            request.getRequestDispatcher("/back-end/tag/tags.jsp").forward(request, response);
        } catch (Exception e) {
            handleException(response, "查詢會員標籤失敗", e);
        }
    }

    private void getTag(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int tagId = Integer.parseInt(request.getParameter("tagId"));
            TagVO tag = tagService.getTag(tagId);
            request.setAttribute("tag", tag);
            request.getRequestDispatcher("/back-end/tag/tag.jsp").forward(request, response);
        } catch (Exception e) {
            handleException(response, "查詢標籤失敗", e);
        }
    }

    private void getAllTags(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            List<TagVO> tags = tagService.getAllTagsFromMySQL();
            request.setAttribute("tags", tags);
            request.getRequestDispatcher("/back-end/tag/allTags.jsp").forward(request, response);
        } catch (Exception e) {
            handleException(response, "查詢所有標籤失敗", e);
        }
    }

    private void loadTagOptions(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            List<TagVO> tags = tagService.getTagsByCategory(categoryId);

            response.setContentType("text/html;charset=UTF-8");
            StringBuilder options = new StringBuilder();

            options.append("<option value='' selected disabled>請選擇一個標籤</option>");
            for (TagVO tag : tags) {
                options.append("<option value='").append(tag.getTagId()).append("'>").append(tag.getTagName())
                        .append("</option>");
            }

            response.getWriter().write(options.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("無法加載標籤選項: " + e.getMessage());
        }
    }

    private void searchMembersByTagName(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String partialName = request.getParameter("partialName");

            if (partialName == null || partialName.trim().isEmpty()) {
                response.getWriter().write("標籤名稱不得為空");
                return;
            }

            // 通過服務層執行模糊搜索
            Set<Integer> memberIds = tagService.searchMembersByPartialTagName(partialName);

            // 返回 JSON 格式的結果
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(new com.google.gson.Gson().toJson(memberIds));
        } catch (Exception e) {
            handleException(response, "模糊搜尋失敗", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = Optional.ofNullable(request.getParameter("action")).orElse("");

        switch (action) {
            case "addTag":
                addTag(request, response);
                break;
            case "updateTag":
                updateTag(request, response);
                break;
            default:
                response.getWriter().write("無效的操作");
        }
    }

    private void addTag(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String tagName = request.getParameter("tagName");
            int tagTypeNo = Integer.parseInt(request.getParameter("tagTypeNo"));
            TagVO tag = new TagVO(0, tagTypeNo, tagName);
            tagService.addTag(tag);
            response.sendRedirect("tagServlet?action=getAllTags");
        } catch (Exception e) {
            handleException(response, "新增標籤失敗", e);
        }
    }

    private void updateTag(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int tagId = Integer.parseInt(request.getParameter("tagId"));
            String tagName = request.getParameter("tagName");
            int tagTypeNo = Integer.parseInt(request.getParameter("tagTypeNo"));
            TagVO tag = new TagVO(tagId, tagTypeNo, tagName);
            tagService.updateTag(tag);
            response.sendRedirect("tagServlet?action=getAllTags");
        } catch (Exception e) {
            handleException(response, "更新標籤失敗", e);
        }
    }

    private void handleException(HttpServletResponse response, String errorMessage, Exception e) throws IOException {
        e.printStackTrace();
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().write(errorMessage + ": " + e.getMessage());
    }
}
