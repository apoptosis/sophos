(require 'org)
(require 'ox-org)

(defun build (project dest)
  (dolist (item (directory-files project t ".*\\.org$"))
    (let* ((base-name (file-name-base item))
           (el-name (format "%s.el" base-name))
           (final-name (concat dest el-name)))
      (org-babel-tangle-file item final-name))))

(defun build-all (dest)
  (dolist (project (directory-files "src" t "^[^.]"))
    (build project dest)))
