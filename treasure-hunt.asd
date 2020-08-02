;;;; treasure-hunt.asd

(asdf:defsystem #:treasure-hunt
  :description "Describe treasure-hunt here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:drakma #:flexi-streams #:yason)
  :components ((:file "package")
               (:file "treasure-hunt")
               (:file "queue")))
