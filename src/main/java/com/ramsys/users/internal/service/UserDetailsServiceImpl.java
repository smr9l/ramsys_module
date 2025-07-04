package com.ramsys.users.internal.service;

import com.ramsys.users.internal.model.Function;
import com.ramsys.users.internal.model.Role;
import com.ramsys.users.internal.model.RoleFunction;
import com.ramsys.users.internal.model.User;
import com.ramsys.users.internal.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private final UserRepository userRepository;

    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with username: " + username));

        Set<GrantedAuthority> authorities = new HashSet<>();
        if (user.getRole() != null) {
            Role role = user.getRole();
            authorities.add(new SimpleGrantedAuthority("ROLE_" + role.getCode()));

            Set<RoleFunction> safeCopy = new HashSet<>(role.getRoleFunctions());  // ✅ copie défensive

            List<Function> functionList = safeCopy.stream()
                    .map(RoleFunction::getFunction)
                    .collect(Collectors.toList());

            if(functionList != null) {
                authorities.addAll(functionList.stream()
                        .map(function -> new SimpleGrantedAuthority(function.getCode()))
                        .collect(Collectors.toSet()));
            }
        }

            return new org.springframework.security.core.userdetails.User(
                user.getUsername(),
                user.getPasswordHash(),
                user.isActive(),
                true,
                true,
                true,
                authorities);
    }
} 