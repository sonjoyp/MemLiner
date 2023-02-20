
#include "rswap_dram.h"

#define ONEGB (1024UL * 1024 * 1024)
#define REMOTE_BUF_SIZE (ONEGB * 8) /* must match what server is allocating */

static void *local_dram; // a buffer created via vzalloc

int rswap_dram_write(struct page *page, size_t roffset)
{
	pr_info("CPU_Server_Start---------:rswap_dram_write------\n");
	void *page_vaddr;

	page_vaddr = kmap_atomic(page); // map the physical page to a virtual address
	copy_page((void *)(local_dram + roffset), page_vaddr);
	kunmap_atomic(page_vaddr);
	pr_info("CPU_Server_END---------:rswap_dram_write------\n");
	return 0;
}

int rswap_dram_read(struct page *page, size_t roffset)
{
	pr_info("CPU_Server_Start---------:rswap_dram_read------\n");
	void *page_vaddr;

	VM_BUG_ON_PAGE(!PageSwapCache(page), page);
	VM_BUG_ON_PAGE(!PageLocked(page), page);
	VM_BUG_ON_PAGE(PageUptodate(page), page);

	page_vaddr = kmap_atomic(page);
	copy_page(page_vaddr, (void *)(local_dram + roffset));
	kunmap_atomic(page_vaddr);

	SetPageUptodate(page); // [?] what's this for ?
	unlock_page(page);
	pr_info("CPU_Server_END---------:rswap_dram_read------\n");
	return 0;
}

/**
 * Alloca a local DRAM to debug frontswap
 *
 */
int rswap_init_local_dram(void)
{
	pr_info("CPU_Server_Start---------:rswap_init_local_dram------\n");
	local_dram = vzalloc(REMOTE_BUF_SIZE);
	pr_info("Allocate local dram 0x%lx bytes for debug\n", REMOTE_BUF_SIZE);
	pr_info("CPU_Server_END---------:rswap_init_local_dram------\n");
	return 0;
}

int rswap_remove_local_dram(void)
{
	pr_info("CPU_Server_Start---------:rswap_remove_local_dram------\n");
	vfree(local_dram);
	pr_info("Free the allocated local_dram 0x%lx bytes \n", REMOTE_BUF_SIZE);
	pr_info("CPU_Server_END---------:rswap_remove_local_dram------\n");
	return 0;
}
