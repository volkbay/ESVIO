;; Auto-generated. Do not edit!


(when (boundp 'mpl_dataset_toolbox::Event)
  (if (not (find-package "MPL_DATASET_TOOLBOX"))
    (make-package "MPL_DATASET_TOOLBOX"))
  (shadow 'Event (find-package "MPL_DATASET_TOOLBOX")))
(unless (find-package "MPL_DATASET_TOOLBOX::EVENT")
  (make-package "MPL_DATASET_TOOLBOX::EVENT"))

(in-package "ROS")
;;//! \htmlinclude Event.msg.html


(defclass mpl_dataset_toolbox::Event
  :super ros::object
  :slots (_x _y _ts _polarity ))

(defmethod mpl_dataset_toolbox::Event
  (:init
   (&key
    ((:x __x) 0)
    ((:y __y) 0)
    ((:ts __ts) (instance ros::time :init))
    ((:polarity __polarity) nil)
    )
   (send-super :init)
   (setq _x (round __x))
   (setq _y (round __y))
   (setq _ts __ts)
   (setq _polarity __polarity)
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:ts
   (&optional __ts)
   (if __ts (setq _ts __ts)) _ts)
  (:polarity
   (&optional (__polarity :null))
   (if (not (eq __polarity :null)) (setq _polarity __polarity)) _polarity)
  (:serialization-length
   ()
   (+
    ;; uint16 _x
    2
    ;; uint16 _y
    2
    ;; time _ts
    8
    ;; bool _polarity
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint16 _x
       (write-word _x s)
     ;; uint16 _y
       (write-word _y s)
     ;; time _ts
       (write-long (send _ts :sec) s) (write-long (send _ts :nsec) s)
     ;; bool _polarity
       (if _polarity (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint16 _x
     (setq _x (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _y
     (setq _y (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; time _ts
     (send _ts :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _ts :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _polarity
     (setq _polarity (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get mpl_dataset_toolbox::Event :md5sum-) "40d339b261445b8ce9a6fef01267cd5d")
(setf (get mpl_dataset_toolbox::Event :datatype-) "mpl_dataset_toolbox/Event")
(setf (get mpl_dataset_toolbox::Event :definition-)
      "# This message is copied from Prophesee ROS Wrapper.
# A single event message
uint16 x
uint16 y
time ts
bool polarity

")



(provide :mpl_dataset_toolbox/Event "40d339b261445b8ce9a6fef01267cd5d")


