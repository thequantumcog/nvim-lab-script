local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep -- YOU NEED THIS LINE

return {
	s("init", {
		t({
			"#include <stdio.h>",
			"#include <stdlib.h>",
			"",
			"int main() {",
			"    ",
		}),
		i(1),
		t({
			"",
			"    return 0;",
			"}",
		}),
	}),

	s("uinit", {
		t({
			"#include <stdio.h>",
			"#include <stdlib.h>",
			"#include <unistd.h>",
			"#include <sys/wait.h>",
			"#include <fcntl.h>",
			"",
			"int main() {",
			"    ",
		}),
		i(1),
		t({
			"",
			"    return 0;",
			"}",
		}),
	}),

	s("pinit", {
		t({
			"#include <stdio.h>",
			"#include <stdlib.h>",
			"#include <unistd.h>",
			"#include <sys/wait.h>",
			"#include <fcntl.h>",
			"#include <pthread.h>",
			"",
			"int main() {",
			"    ",
		}),
		i(1),
		t({
			"",
			"    return 0;",
			"}",
		}),
	}),
	s("fori", {
		t("for (int "),
		i(1, "i"), -- This is the actual insert node where you type
		t(" = 0; "),
		rep(1), -- This mirrors whatever you typed in i(1)
		t(" < "),
		i(2, "n"), -- Your second jump (the limit)
		t("; "),
		rep(1), -- This also mirrors i(1)
		t("++) {"),
		t({ "", "    " }),
		i(3), -- Your third jump (inside the loop)
		t({ "", "}" }),
	}),
	s("pjoin", {
		t("for (int "),
		i(1, "i"), -- First jump: The loop variable
		t(" = 0; "),
		rep(1), -- Mirrors "i"
		t(" < "),
		i(2, "2"), -- Second jump: The limit (you can change 2 to num_threads, etc.)
		t("; "),
		rep(1), -- Mirrors "i"
		t("++) {"),
		t({ "", "    pthread_join(" }),
		i(3, "threads"), -- Third jump: The array name
		t("["),
		rep(1), -- Mirrors "i" inside the array brackets
		t("], NULL);"),
		t({ "", "}" }),
	}),
	s("pcreate", {
		t("for (int "),
		i(1, "i"), -- First jump: The loop variable
		t(" = 0; "),
		rep(1), -- Mirrors "i"
		t(" < "),
		i(2, "2"), -- Second jump: The limit
		t("; "),
		rep(1), -- Mirrors "i"
		t("++) {"),
		t({ "", "    pthread_create(&" }),
		i(3, "threads"), -- Third jump: The array name (no need to type &)
		t("["),
		rep(1), -- Mirrors "i" inside the array brackets
		t("], NULL, "),
		i(4, "start_routine"), -- Fourth jump: The function the thread will run
		t(", "),
		i(5, "NULL"), -- Fifth jump: The argument passed to that function
		t(");"),
		t({ "", "}" }),
	}),
	s("check_sys", {
		t("#define CHECK_SYSCALL("),
		i(1, "fd"),
		t(", "),
		i(2, "msg"),
		t({
			") do { \\",
			"    if ((",
		}),
		rep(1),
		t({ ") < 0) { \\", "        perror(" }),
		rep(2),
		t({ "); \\", "        exit(EXIT_FAILURE); \\", "    } \\", "} while (0)" }),
	}),
	s("cond_fork", {
		t({ "pid_t " }),
		i(1, "p"),
		t({ " = fork();", "if (" }),
		rep(1),
		t({ " == 0) {", "    " }),
		i(2),
		t({ "", "}", "else if (" }),
		rep(1),
		t({ " > 0) {", "    " }),
		i(3),
		t({ "", "}", "else {", '    perror("fork");', "    exit(EXIT_FAILURE);", "}" }),
	}),
}
