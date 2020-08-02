;;;; queue.lisp

(in-package #:treasure-hunt)

(defun make-queue () (cons '() '()))

(defun front-ptr (queue) (car queue))
(defun rear-ptr (queue) (cdr queue))
(defun set-front-ptr (queue item)
  (setf (car queue) item))
(defun set-rear-ptr (queue item)
  (setf (cdr queue) item))

(defun empty-queue (queue)
  (null (front-ptr queue)))

(defun front-queue (queue)
  (if (empty-queue queue)
      (error "FRONT called with an empty queue")
      (car (front-ptr queue))))

(defun insert-queue (queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue queue)
           (set-front-ptr queue new-pair)
           (set-rear-ptr queue new-pair)
           queue)
          (t
           (setf (cdr (rear-ptr queue)) new-pair)
           (set-rear-ptr queue new-pair)
           queue))))

(defun delete-queue (queue)
  (cond ((empty-queue queue)
         (error "DELETE! called with an empty queue"))
        (t (set-front-ptr queue (cdr (front-ptr queue)))
           queue)))

(defun contains-queue (queue item)
  (member item (front-ptr queue) :test #'equal))

(defun unique-insert-queue (queue item)
  (if (null (contains-queue queue item))
      (insert-queue queue item)
      queue))

(defun length-queue (queue)
  (length (front-ptr queue)))

(defun print-queue (queue)
  (print (front-ptr queue)))
