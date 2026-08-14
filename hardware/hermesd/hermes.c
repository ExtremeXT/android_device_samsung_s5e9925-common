#include <hwvault.h>
#include <unistd.h>

int main() {
    nwd_tz_open();
    hwvault_get_cred();
    pause();
    nwd_tz_close();
    return 0;
}
