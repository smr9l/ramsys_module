package com.ramsys.users.internal.service;

import com.ramsys.users.api.UserManagement;
import com.ramsys.users.dto.CreateUserRequest;
import com.ramsys.users.dto.UpdateUserRequest;
import com.ramsys.users.dto.UserDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
class UserManagementImpl implements UserManagement {

    private final UserService userService;

    @Override
    public UserDTO createUser(CreateUserRequest request) {
        return userService.createUser(request);
    }

    @Override
    public UserDTO updateUser(Long id, UpdateUserRequest request) {
        return userService.updateUser(id, request);
    }

    @Override
    public Optional<UserDTO> findUserById(Long id) {
        return userService.findUserById(id);
    }

    @Override
    public Page<UserDTO> findAllUsers(Pageable pageable) {
        return userService.findAllUsers(pageable);
    }

    @Override
    public void deactivateUser(Long id) {
        userService.deactivateUser(id);
    }
} 