package com.ramsys.users.internal.mapper;

import com.ramsys.users.dto.CreateUserRequest;
import com.ramsys.users.dto.UpdateUserRequest;
import com.ramsys.users.dto.UserDTO;
import com.ramsys.users.internal.model.User;
import org.mapstruct.*;

import java.util.List;

@Mapper(componentModel = "spring",
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE,
        unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserMapper {
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "passwordHash", ignore = true)
    @Mapping(target = "role", ignore = true)
    @Mapping(target = "manager", ignore = true)
    User toUser(CreateUserRequest request);
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "passwordHash", ignore = true)
    @Mapping(target = "role", ignore = true)
    @Mapping(target = "manager", ignore = true)
    void updateUserFromDto(UpdateUserRequest request, @MappingTarget User user);
    
    @Mapping(target = "role", ignore = true)
    @Mapping(target = "location", ignore = true)
    @Mapping(target = "division", ignore = true)
    @Mapping(target = "manager", ignore = true)
    UserDTO toDto(User user);
    
    List<UserDTO> toDtoList(List<User> users);
} 