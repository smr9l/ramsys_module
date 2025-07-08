package com.ramsys.common.security;

/**
 * Enum centralizing all authority/function codes used in security annotations.
 * These codes correspond to the 'code' field in the ref_function table.
 * 
 * Authority Design Strategy:
 * - Module authorities (REF_PRT, REF_INS) grant full access to the module
 * - Operation authorities provide granular control when needed
 * - Use module authorities for most cases, operation authorities for sensitive operations
 */
public enum Authority {
    
    // === MODULE-LEVEL AUTHORITIES (Full Access) ===
    
    /**
     * Policy Maintenance authority
     * Allows full access to insurance policy maintenance
     */
    MNT_CTR("MNT_CTR"),
    
    /**
     * Partners Reference Data authority
     * Allows full access to partner management (READ/WRITE/DELETE)
     */
    REF_PRT("REF_PRT"),
    
    /**
     * Insureds Reference Data authority  
     * Allows full access to insured management (READ/WRITE/DELETE)
     */
    REF_INS("REF_INS"),
    
    // === OPERATION-LEVEL AUTHORITIES (Granular Control) ===
    
    /**
     * Partners Read authority - View only
     */
    REF_PRT_READ("REF_PRT_READ"),
    
    /**
     * Partners Write authority - Create/Update
     */
    REF_PRT_WRITE("REF_PRT_WRITE"),
    
    /**
     * Partners Delete authority - Delete/Deactivate
     */
    REF_PRT_DELETE("REF_PRT_DELETE"),
    
    /**
     * Insureds Read authority - View only
     */
    REF_INS_READ("REF_INS_READ"),
    
    /**
     * Insureds Write authority - Create/Update
     */
    REF_INS_WRITE("REF_INS_WRITE"),
    
    /**
     * Insureds Delete authority - Delete/Deactivate
     */
    REF_INS_DELETE("REF_INS_DELETE");
    
    // === Constants for @PreAuthorize annotations ===
    
    // Module-level authorities (recommended for most use cases)
    public static final String HAS_MNT_CTR = "hasAuthority('MNT_CTR')";
    public static final String HAS_REF_PRT = "hasAuthority('REF_PRT')";
    public static final String HAS_REF_INS = "hasAuthority('REF_INS')";
    
    // Combined authorities for flexible access control
    public static final String CAN_READ_PARTNERS = "hasAuthority('REF_PRT') or hasAuthority('REF_PRT_READ')";
    public static final String CAN_WRITE_PARTNERS = "hasAuthority('REF_PRT') or hasAuthority('REF_PRT_WRITE')";
    public static final String CAN_DELETE_PARTNERS = "hasAuthority('REF_PRT') or hasAuthority('REF_PRT_DELETE')";
    
    public static final String CAN_READ_INSUREDS = "hasAuthority('REF_INS') or hasAuthority('REF_INS_READ')";
    public static final String CAN_WRITE_INSUREDS = "hasAuthority('REF_INS') or hasAuthority('REF_INS_WRITE')";
    public static final String CAN_DELETE_INSUREDS = "hasAuthority('REF_INS') or hasAuthority('REF_INS_DELETE')";
    
    private final String code;
    
    Authority(String code) {
        this.code = code;
    }
    
    /**
     * Gets the authority code as used in the database and security annotations
     * @return the authority code string
     */
    public String getCode() {
        return code;
    }
    
    @Override
    public String toString() {
        return code;
    }
} 