;;;; treasure-hunt.lisp

(in-package #:treasure-hunt)

(defparameter mobile "")
(defparameter token "")
(defparameter num-nodes 50000)

(defparameter *urls* (make-queue))
(unique-insert-queue *urls* "https://findtreasure.app/api/v1/games/test/start")

(defparameter *visited* (make-hash-table :size num-nodes))

(defun make-request (url)
  (drakma:http-request url
                       :want-stream t
                       :additional-headers
                       `(("Authorization" . ,(concatenate 'string "Bearer " token))
                         ("gomoney" . ,mobile))))

(defun append-urls (urls)
  (if (null urls)
      t
      (let ((url (car urls)))
        (if (null (gethash url *visited*))
            (unique-insert-queue *urls* url))
        (append-urls (cdr urls)))))

(defun run-next ()
  (cond ((empty-queue *urls*)
         (error "No requests left to make!"))
        (T (let ((url (front-queue *urls*)))
             (delete-queue *urls*)
             (multiple-value-bind (stream status)
                 (make-request url)
               (cond ((eq status 200)
                      (setf (flexi-streams:flexi-stream-external-format stream)
                            :utf-8)
                      (let ((response (yason:parse stream)))
                        (append-urls (gethash "paths" response))
                        (format t "Updated nodes to visit, now ~d"
                                (length-queue *urls*))))
                     (t
                      (format t "Unhandled response: ~S ~S" status stream))))
             (setf (gethash url *visited*) t)))))
