;;; ensime-var.el --- Customizaton variables

(require 's)

(defgroup ensime nil
  "Interaction with the ENhanced Scala Environment."
  :group 'tools)

(defgroup ensime-ui nil
  "Interaction with the ENhanced Scala Environment UI."
  :group 'ensime)

(defcustom ensime-default-buffer-prefix "inferior-ensime-server-"
  "The prefix of the buffer that the ENSIME server process runs in."
  :type 'string
  :group 'ensime-ui)

(defcustom ensime-truncate-lines t
  "Set `truncate-lines' in popup buffers.
  This applies to buffers that present lines as rows of data, such as
  debugger backtraces and apropos listings."
  :type 'boolean
  :group 'ensime-ui)

(defcustom ensime-kill-without-query-p t
  "If non-nil, kill ENSIME processes without query when quitting Emacs."
  :type 'boolean
  :group 'ensime-ui)

(defcustom ensime-save-before-compile t
  "If non-nil, save all buffers before compiling."
  :type 'boolean
  :group 'ensime-ui)

(defcustom ensime-tooltip-hints t
  "If non-nil, mouse tooltips are activated."
  :type 'boolean
  :group 'ensime-ui)

(defcustom ensime-tooltip-type-hints t
  "If non-nil, type-inspecting tooltips are activated."
  :type 'boolean
  :group 'ensime-ui)

(defcustom ensime-graphical-tooltips nil
  "If non-nil, show graphical bubbles for tooltips."
  :type 'boolean
  :group 'ensime-ui)

(defgroup ensime-server nil
  "Server configuration."
  :prefix "ensime-"
  :group 'ensime)

(defcustom ensime-connected-hook nil
  "List of functions to call when ENSIME connects to Lisp."
  :type 'hook
  :group 'ensime-server)

(defcustom ensime-sbt-command
  (executable-find "sbt")
  "Location of the sbt executable for starting the server."
  :type 'string
  :group 'ensime-server)

(defcustom ensime-default-server-env ()
  "A `process-environment' compatible list of environment variables"
  :type '(repeat string)
  :group 'ensime-server)

(defcustom ensime-default-java-home
  (cond ((getenv "JDK_HOME"))
	((getenv "JAVA_HOME"))
	((file-exists-p "/usr/libexec/java_home")
	 (s-chomp (shell-command-to-string "/usr/libexec/java_home")))
	('t (let ((java (file-truename (executable-find "javac"))))
	      (warn "JDK_HOME and JAVA_HOME are not set, inferring from %s" java)
	      (ensime--parent-dir (ensime--parent-dir java)))))
  "Location of the JDK's base directory"
  :type 'string
  :group 'ensime-server)

(defcustom ensime-default-java-flags ()
  "Flags sent to the java instance when the server is started"
  :type '(repeat string)
  :group 'ensime-server)

(defcustom ensime-default-scala-version
  "2.10.4"
  "Default version of scala. An appropriate version of the server
   will be obtained. May need to be exact to minor release."
  :type 'string
  :group 'ensime-server)

(defgroup ensime-mode nil
  "Settings for ensime-mode scala source buffers."
  :prefix "ensime-"
  :group 'ensime)

(defcustom ensime-mode-key-prefix [?\C-c]
  "The prefix key for ensime-mode commands."
  :group 'ensime-mode
  :type 'sexp)

(defcustom ensime-typecheck-when-idle t
  "Controls whether a modified buffer should be typechecked automatically.
A typecheck is started when emacs is idle, if the buffer was modified
since the last typecheck."
  :type 'boolean
  :group 'ensime-ui)

(defcustom ensime-typecheck-interval 2
  "Minimum time to wait between two automatic typechecks."
  :type 'number
  :group 'ensime-ui)

(defcustom ensime-typecheck-idle-interval 0.5
  "Idle time to wait before starting an automatic typecheck."
  :type 'number
  :group 'ensime-ui)

(defcustom ensime-sem-high-enabled-p t
  "If true, ensime semantic highlighting is applied whenever the buffer
is saved."
  :type 'boolean
  :group 'ensime-ui)

(defcustom ensime-sem-high-faces
  '((var . scala-font-lock:var-face)
    (val . (:inherit font-lock-constant-face :slant italic))
    (varField . scala-font-lock:var-face)
    (valField . (:inherit font-lock-constant-face :slant italic))
    (functionCall . font-lock-function-name-face)
    (operator . font-lock-keyword-face)
    (param . (:slant italic))
    (class . font-lock-type-face)
    (trait .  (:inherit font-lock-type-face :slant italic))
    (object . font-lock-constant-face)
    (package . font-lock-preprocessor-face))
  "Faces for semantic highlighting. Symbol types not mentioned here
will not be requested from server.  The format is an alist of the form
  ( SYMBOL-TYPE . FACE-SPEC )
where SYMBOL-TYPE is one of:
  var val varField valField functionCall
  operator params class trait object package"
  :type 'alist
  :group 'ensime-ui)

(provide 'ensime-vars)

;; Local Variables:
;; no-byte-compile: t
;; End:
