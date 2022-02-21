(setq user-full-name "son-of-satan"
      user-mail-address "mtataryn555@gmail.com")

(setq doom-leader-alt-key "C-SPC")
(setq doom-localleader-alt-key "C-SPC l")

(map! "S-SPC" 'set-mark-command)

(map! :leader
      "p" 'projectile-command-map)

(add-to-list 'default-frame-alist '(alpha . (98 . 98)))

(setq doom-font (font-spec :family "Hack" :size 15))

(setq doom-theme 'doom-dracula)

(setq +doom-dashboard-menu-sections
      '(("Reload last session"
         :icon (all-the-icons-octicon "history" :face 'doom-dashboard-menu-title)
         :when (cond ((featurep! :ui workspaces)
                      (file-exists-p (expand-file-name persp-auto-save-fname persp-save-dir)))
                     ((require 'desktop nil t)
                      (file-exists-p (desktop-full-file-name))))
         :face (:inherit (doom-dashboard-menu-title bold))
         :action doom/quickload-session)
        ("Open org-agenda"
         :icon (all-the-icons-octicon "calendar" :face 'doom-dashboard-menu-title)
         :when (fboundp 'org-agenda)
         :action org-agenda)
        ("Recently opened files"
         :icon (all-the-icons-octicon "file-text" :face 'doom-dashboard-menu-title)
         :action recentf-open-files)
        ("Open project"
         :icon (all-the-icons-octicon "briefcase" :face 'doom-dashboard-menu-title)
         :action projectile-switch-project)
        ("Jump to bookmark"
         :icon (all-the-icons-octicon "bookmark" :face 'doom-dashboard-menu-title)
         :action bookmark-jump)
        ("Open private configuration"
         :icon (all-the-icons-octicon "tools" :face 'doom-dashboard-menu-title)
         :when (file-directory-p doom-private-dir)
         :action doom/open-private-config)))

(setq fancy-splash-image (concat (file-name-as-directory doom-private-dir) "pictures/kurisu.png"))

(setq +doom-quit-messages '("It's not like I'll miss you or anything, b-baka!"))

(after! org
  (setq org-directory "~/Org")
  (setq org-roam-directory
        (concat (file-name-as-directory org-directory) "roam")))
