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

    User toUser(CreateUserRequest request);
    

    void updateUserFromDto(UpdateUserRequest request, @MappingTarget User user);
    

    UserDTO toDto(User user);
    
    List<UserDTO> toDtoList(List<User> users);
} 