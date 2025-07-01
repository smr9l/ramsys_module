package com.ramsys.common.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.*;

/**
 * Filter that extracts a JWT token from an HttpOnly cookie (named "jwt") and
 * exposes it as an <code>Authorization: Bearer &lt;token&gt;</code> header so that the
 * standard Spring Security Bearer token flow can continue to work without
 * requiring the client to store the token in localStorage.
 */
@RequiredArgsConstructor
public class CookieJwtFilter extends OncePerRequestFilter {

    private static final String COOKIE_NAME = "jwt";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        // If an Authorization header is already present, just continue the filter chain
        if (request.getHeader(HttpHeaders.AUTHORIZATION) != null) {
            filterChain.doFilter(request, response);
            return;
        }

        // Look for the JWT cookie
        String jwt = extractJwtFromCookies(request.getCookies());
        if (jwt == null) {
            filterChain.doFilter(request, response);
            return;
        }

        // Wrap the request to add the Authorization header
        HttpServletRequest wrappedRequest = new HttpServletRequestWrapper(request) {
            @Override
            public String getHeader(String name) {
                if (HttpHeaders.AUTHORIZATION.equalsIgnoreCase(name)) {
                    return "Bearer " + jwt;
                }
                return super.getHeader(name);
            }

            @Override
            public Enumeration<String> getHeaders(String name) {
                if (HttpHeaders.AUTHORIZATION.equalsIgnoreCase(name)) {
                    return Collections.enumeration(List.of("Bearer " + jwt));
                }
                return super.getHeaders(name);
            }

            @Override
            public Enumeration<String> getHeaderNames() {
                List<String> names = Collections.list(super.getHeaderNames());
                names.add(HttpHeaders.AUTHORIZATION);
                return Collections.enumeration(names);
            }
        };

        filterChain.doFilter(wrappedRequest, response);
    }

    private String extractJwtFromCookies(Cookie[] cookies) {
        if (cookies == null) return null;
        for (Cookie cookie : cookies) {
            if (COOKIE_NAME.equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return null;
    }
} 