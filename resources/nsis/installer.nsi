!include "MUI2.nsh"
;!include "FileFunc.nsh"
!include "/portecle-installer/resources/nsis/build/FileAssociation.nsh"

;--------------------------------
;General

  ;Name and file
  Name "Portecle"
  Caption "Portecle ${VERSION} Setup"
  OutFile "/portecle-installer/portecle/Portecle-Installer-${VERSION}.exe"

  SetCompressor /SOLID lzma

  ;Default installation folder
  InstallDir "$PROGRAMFILES\Portecle"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKLM "Software\Portecle" "Install_Dir"

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "Polish"

;--------------------------------
;Version Information

  VIProductVersion "${FILE_VERSION}"
  VIAddVersionKey "FileVersion" "$FILE_VERSION"
  VIAddVersionKey "ProductName" "Portecle Installer"
  VIAddVersionKey "ProductVersion" "${PRODUCT_VERSION}"
  VIAddVersionKey "Comments" "A test comment"
  VIAddVersionKey "FileDescription" "Installer for the Portecle application"

;--------------------------------
;Installer Sections

Section $(SectionApplicationName) SectionApplicationDesc

  SectionIn RO
  SetOutPath "$INSTDIR"
  
  File /r "/portecle-installer/portecle/"
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\Portecle "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Portecle" "DisplayName" "Portecle"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Portecle" "DisplayIcon" '"$INSTDIR\portecle.ico"'
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Portecle" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Portecle" "Publisher" "Avo Software"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Portecle" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Portecle" "EstimatedSize" 3810
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Portecle" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Portecle" "NoRepair" 1
  WriteUninstaller "uninstall.exe"

SectionEnd

; Optional section (can be disabled by the user)
Section $(SectionMenuShortcutsName) SectionMenuShortcutsDesc

  CreateDirectory "$SMPROGRAMS\Portecle"
  CreateShortCut "$SMPROGRAMS\Portecle\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\Portecle\Portecle.lnk" "$INSTDIR\Portecle.exe" "" "$INSTDIR\Portecle.exe" 0
  
SectionEnd

; Optional section (can be disabled by the user)
Section $(SectionDesktopShortcutsName) SectionDesktopShortcutsDesc

  CreateShortCut "$DESKTOP\Portecle.lnk" "$INSTDIR\Portecle.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section $(SectionFileAssociationsName) SectionFileAssociationsDesc

  ${RegisterExtension} "$INSTDIR\Portecle.exe" ".jks" "JKS Key Store"
  ${RegisterExtension} "$INSTDIR\Portecle.exe" ".ks" "KS Key Store"
  ${RegisterExtension} "$INSTDIR\Portecle.exe" ".p12" "P12 Key Store"
  ${RegisterExtension} "$INSTDIR\Portecle.exe" ".pfx" "PFX Key Store"
  
SectionEnd

;--------------------------------
;Installer Functions

Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SectionApplication ${LANG_ENGLISH} "Portecle application files"
  LangString DESC_SectionMenuShortcuts ${LANG_ENGLISH} "Adding Start Menu shortcuts"
  LangString DESC_SectionDesktopShortcuts ${LANG_ENGLISH} "Adding Desktop shortcut"
  LangString DESC_SectionFileAssociations ${LANG_ENGLISH} "Adding File Associations for JKS, KS, P12 and PFX key stores"
  
  LangString DESC_SectionApplication ${LANG_POLISH} "Pliki programu Portecle"
  LangString DESC_SectionMenuShortcuts ${LANG_POLISH} "Dodaje skróty w Menu Start"
  LangString DESC_SectionDesktopShortcuts ${LANG_POLISH} "Dodaje skrót na Pulpicie"
  LangString DESC_SectionFileAssociations ${LANG_POLISH} "Dodaje skojarzenia plików dla magazynów kluczy JKS, KS, P12 i PFX"
  
  LangString SectionApplicationName ${LANG_ENGLISH} "Portecle (required)"
  LangString SectionMenuShortcutsName ${LANG_ENGLISH} "Start Menu Shortcuts"
  LangString SectionDesktopShortcutsName ${LANG_ENGLISH} "Desktop Shortcut"
  LangString SectionFileAssociationsName ${LANG_ENGLISH} "File Associations"
  
  LangString SectionApplicationName ${LANG_POLISH} "Portecle (wymagane)"
  LangString SectionMenuShortcutsName ${LANG_POLISH} "Skróty w Menu Start"
  LangString SectionDesktopShortcutsName ${LANG_POLISH} "Skrót na Pulpicie"
  LangString SectionFileAssociationsName ${LANG_POLISH} "Skojarzenia plików"
  
  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionApplicationDesc} $(DESC_SectionApplication)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionMenuShortcutsDesc} $(DESC_SectionMenuShortcuts)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionDesktopShortcutsDesc} $(DESC_SectionDesktopShortcuts)
    !insertmacro MUI_DESCRIPTION_TEXT ${SectionFileAssociationsDesc} $(DESC_SectionFileAssociations)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Portecle"
  DeleteRegKey HKLM SOFTWARE\Portecle

  ; Remove file accosiations
  ${UnregisterExtension} ".jks" "JKS Key Store"
  ${UnregisterExtension} ".ks" "KS Key Store"
  ${UnregisterExtension} ".p12" "P12 Key Store"
  ${UnregisterExtension} ".pfx" "PFX Key Store"
 
  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\Portecle\*.*"
  Delete "$DESKTOP\Portecle.lnk"
  
  ; Remove directories used
  RMDir "$SMPROGRAMS\Portecle"
  RMDir /r "$INSTDIR"

SectionEnd