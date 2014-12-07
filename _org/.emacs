(require 'org)

(eval-after-load "org"
  '(require 'ox-md nil t))

;;; Fontify code in code blocks.
(setq org-src-fontify-natively t)

;;; Support for Jekyll blogs.
;;; For more details see:
;;;  - http://orgmode.org/worg/org-tutorials/org-jekyll.html
;;;  - http://www.gorgnegre.com/linux/using-emacs-orgmode-to-blog-with-jekyll.html
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
