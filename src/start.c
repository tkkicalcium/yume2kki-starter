#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>

#define RPG_RT_COMMAND L"cmd /c start \"\" /affinity 1 \"ゆめ2っき\\RPG_RT.exe\" 0 0 Window"

void kbdreset()
{
	int c;
	for (c = 1; c < 255; c++){
		if (c == 93) continue; // contextmenu
		keybd_event(c, 0, KEYEVENTF_KEYUP, (ULONG_PTR)NULL);
	}
}

int main()
{
#ifdef WITH_KBD_RESET
	kbdreset();
#endif
	
	WCHAR binDirPath[MAX_PATH] = L"";
	if (GetModuleFileNameW(NULL, binDirPath, MAX_PATH)) {
		WCHAR *pSlash = NULL;
		for (WCHAR *p = binDirPath; *p; ++p)
		{
			if (*p == '\\') pSlash=p;
		}
		if (pSlash) *pSlash = '\0';
	}
	else {
		fprintf(stderr,"GetModuleFileNameW error\n");
		return -1;
	}

	STARTUPINFO si = { sizeof(STARTUPINFO) };
	PROCESS_INFORMATION pi = {};
	if (!CreateProcessW(
		NULL,
		RPG_RT_COMMAND,
		NULL,
		NULL,
		FALSE,
		CREATE_NO_WINDOW,
		NULL,
		(LPCWSTR)&binDirPath,
		&si, 
		&pi
	)) {
		fprintf(stderr,"CreateProcessW error\n");
		return -1;
	}

	if (!CloseHandle(pi.hThread)) {
		fprintf(stderr,"CloseHandler(hThread) error\n");
		return -1;
	}

	DWORD r = WaitForSingleObject(pi.hProcess, INFINITE);
	switch(r) {
	case WAIT_OBJECT_0:
		break;
	default:
		fprintf(stderr, "Wait error(%d)\n", r);
		return -1;
	}

	DWORD exitCode;
	if (!GetExitCodeProcess(pi.hProcess, &exitCode)) {
		fprintf(stderr, "GetExitCodeProcess error");
		return -1;
	}
 	if (exitCode != 0) {
		fprintf(stderr, "GetExitCodeProcess error");
		return -1;
	}

	return exitCode;
}
