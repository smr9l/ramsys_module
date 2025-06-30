package com.ramsys.common.security;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.security.authentication.event.AbstractAuthenticationEvent;
import org.springframework.security.authentication.event.AuthenticationFailureBadCredentialsEvent;
import org.springframework.security.authentication.event.AuthenticationSuccessEvent;
import org.springframework.security.authorization.event.AuthorizationDeniedEvent;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class SecurityEventListener {

    @EventListener
    public void onAuthenticationSuccess(AuthenticationSuccessEvent event) {
        String username = event.getAuthentication().getName();
        String authorities = event.getAuthentication().getAuthorities().toString();
        
        log.info("Authentication successful for user: {} with authorities: {}", username, authorities);
        
        // Here you could add additional logic like:
        // - Recording login timestamp
        // - Updating user statistics
        // - Sending notifications
    }

    @EventListener
    public void onAuthenticationFailure(AuthenticationFailureBadCredentialsEvent event) {
        String username = event.getAuthentication().getName();
        String errorMessage = event.getException().getMessage();
        
        log.warn("Authentication failed for user: {} - {}", username, errorMessage);
        
        // Here you could add additional logic like:
        // - Recording failed login attempts
        // - Implementing account lockout mechanisms
        // - Sending security alerts
    }

    @EventListener
    public void onAuthorizationDenied(AuthorizationDeniedEvent event) {
        String username = event.getAuthentication().get().getName();
        String resource = event.getAuthorizationDecision().toString();
        
        log.warn("Authorization denied for user: {} accessing resource: {}", username, resource);
        
        // Here you could add additional logic like:
        // - Recording unauthorized access attempts
        // - Implementing rate limiting
        // - Sending security alerts
    }

    @EventListener
    public void onAbstractAuthenticationEvent(AbstractAuthenticationEvent event) {
        // Catch-all for other authentication events
        log.debug("Authentication event: {} for user: {}", 
                event.getClass().getSimpleName(), 
                event.getAuthentication().getName());
    }
} 
