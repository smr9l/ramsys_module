package com.ramsys.users.internal.service;

import com.ramsys.common.exception.BusinessException;
import com.ramsys.common.i18n.MessageService;
import com.ramsys.reference.api.OrganizationalApi;
import com.ramsys.users.dto.CreateUserRequest;
import com.ramsys.users.dto.UpdateUserRequest;
import com.ramsys.users.dto.UserDTO;
import com.ramsys.users.internal.mapper.UserMapper;
import com.ramsys.users.internal.model.Role;
import com.ramsys.users.internal.model.User;
import com.ramsys.users.internal.repository.RoleRepository;
import com.ramsys.users.internal.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;
    private final OrganizationalApi organizationalApi;
    private final MessageService messageService;

    @Transactional
    public UserDTO createUser(CreateUserRequest request) {
        var locale = LocaleContextHolder.getLocale();
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new BusinessException(messageService.getMessage("user.username.exists", locale, request.getUsername()));
        }
        if (request.getEmail() != null && userRepository.existsByEmail(request.getEmail())) {
            throw new BusinessException(messageService.getMessage("user.email.exists", locale, request.getEmail()));
        }

        User user = userMapper.toUser(request);
        user.setPasswordHash(passwordEncoder.encode(request.getPassword()));

        Role role = roleRepository.findById(request.getRoleId())
                .orElseThrow(() -> new BusinessException(messageService.getMessage("role.not.found", locale, request.getRoleId())));
        user.setRole(role);

        if (request.getManagerId() != null) {
            User manager = userRepository.findById(request.getManagerId())
                    .orElseThrow(() -> new BusinessException(messageService.getMessage("user.manager.not.found", locale, request.getManagerId())));
            user.setManager(manager);
        }

        user = userRepository.save(user);
        return enrich(userMapper.toDto(user), user);
    }

    @Transactional
    public UserDTO updateUser(Long id, UpdateUserRequest request) {
        var locale = LocaleContextHolder.getLocale();
        User user = findUserEntityById(id);

        if (request.getUsername() != null && !request.getUsername().equals(user.getUsername()) && userRepository.existsByUsername(request.getUsername())) {
            throw new BusinessException(messageService.getMessage("user.username.exists", locale, request.getUsername()));
        }
        if (request.getEmail() != null && !request.getEmail().equals(user.getEmail()) && userRepository.existsByEmail(request.getEmail())) {
            throw new BusinessException(messageService.getMessage("user.email.exists", locale, request.getEmail()));
        }

        userMapper.updateUserFromDto(request, user);

        if (request.getPassword() != null && !request.getPassword().isEmpty()) {
            user.setPasswordHash(passwordEncoder.encode(request.getPassword()));
        }

        if (request.getRoleId() != null) {
            Role role = roleRepository.findById(request.getRoleId())
                    .orElseThrow(() -> new BusinessException(messageService.getMessage("role.not.found", locale, request.getRoleId())));
            user.setRole(role);
        }

        if (request.getManagerId() != null) {
            if (request.getManagerId().equals(id)) {
                throw new BusinessException(messageService.getMessage("user.manager.self", locale));
            }
            User manager = findUserEntityById(request.getManagerId());
            user.setManager(manager);
        }

        user = userRepository.save(user);
        return enrich(userMapper.toDto(user), user);
    }
    
    @Transactional(readOnly = true)
    public Page<UserDTO> findAllUsers(Pageable pageable) {
        return userRepository.findAll(pageable)
                .map(user -> enrich(userMapper.toDto(user), user));
    }

    @Transactional(readOnly = true)
    public Optional<UserDTO> findUserById(Long id) {
        return userRepository.findById(id)
                .map(user -> enrich(userMapper.toDto(user), user));
    }

    @Transactional(readOnly = true)
    public UserDTO findUserByUsername(String username) {
        var locale = LocaleContextHolder.getLocale();
        return userRepository.findByUsername(username)
                .map(user -> enrich(userMapper.toDto(user), user))
                .orElseThrow(() -> new BusinessException(messageService.getMessage("user.not.found.username", locale, username)));
    }

    @Transactional
    public void deactivateUser(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new BusinessException("user.not.found"));
        user.setIsActive(false);
        userRepository.save(user);
    }

    @Transactional(readOnly = true)
    public Page<UserDTO> searchUsers(String searchTerm, Pageable pageable) {
        return userRepository.searchUsers(searchTerm, pageable)
                .map(user -> enrich(userMapper.toDto(user), user));
    }

    public void changePassword(Long id, String newPassword) {
        User user = findUserEntityById(id);
        user.setPasswordHash(passwordEncoder.encode(newPassword));
        userRepository.save(user);
    }
    
    private User findUserEntityById(Long id) {
        var locale = LocaleContextHolder.getLocale();
        return userRepository.findById(id)
                .orElseThrow(() -> new BusinessException(messageService.getMessage("user.not.found", locale, id)));
    }

    private UserDTO enrich(UserDTO dto, User user) {
        if (user.getLocationId() != null) {
            organizationalApi.findLocationById(user.getLocationId())
                    .ifPresent(dto::setLocation);
        }

        if (user.getDivisionId() != null) {
            organizationalApi.findDivisionById(user.getDivisionId())
                    .ifPresent(dto::setDivision);
        }
        
        return dto;
    }
}