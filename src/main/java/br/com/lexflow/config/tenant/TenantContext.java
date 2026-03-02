package br.com.lexflow.config.tenant;

public final class TenantContext {

    private static final ThreadLocal<String> CURRENT_TENANT =
            new InheritableThreadLocal<>();

    private TenantContext() {}

    public static void setTenant(String tenantId) {
        if (tenantId == null) throw new IllegalArgumentException(
                "tenantId não pode ser nulo");
        CURRENT_TENANT.set(tenantId);
    }

    public static String getTenant() {
        return CURRENT_TENANT.get();
    }

    public static void clear() {
        CURRENT_TENANT.remove();
    }
}
