(eval-after-load "org"
  '(require 'ox-md nil t))

;; fontify code in code blocks
(setq org-src-fontify-natively t)

;;; support for Jekyll blogs
(setq org-publish-project-alist
      '(

  ("org-blog"
          ;; Path to your org files.
          :base-directory "~/dashohoxha.github.io/_org/"
          :base-extension "org"

          ;; Path to your Jekyll project.
          :publishing-directory "~/dashohoxha.github.io/"
          :recursive t
          :publishing-function org-html-publish-to-html
          :headline-levels 4
          :html-extension "html"
          :body-only t ;; Only export section between <body> </body>
	  :section-numbers nil
	  :with-toc nil
    )

    ("org-static-blog"
          :base-directory "~/dashohoxha.github.io/_org/"
          :base-extension any
	  :exclude ".*\.org"
          :publishing-directory "~/dashohoxha.github.io/"
          :recursive t
          :publishing-function org-publish-attachment)

    ("blog" :components ("org-blog" "org-static-blog"))

))

