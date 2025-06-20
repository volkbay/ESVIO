;; Auto-generated. Do not edit!


(when (boundp 'mpl_dataset_toolbox::EventArray)
  (if (not (find-package "MPL_DATASET_TOOLBOX"))
    (make-package "MPL_DATASET_TOOLBOX"))
  (shadow 'EventArray (find-package "MPL_DATASET_TOOLBOX")))
(unless (find-package "MPL_DATASET_TOOLBOX::EVENTARRAY")
  (make-package "MPL_DATASET_TOOLBOX::EVENTARRAY"))

(in-package "ROS")
;;//! \htmlinclude EventArray.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass mpl_dataset_toolbox::EventArray
  :super ros::object
  :slots (_header _height _width _events ))

(defmethod mpl_dataset_toolbox::EventArray
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:height __height) 0)
    ((:width __width) 0)
    ((:events __events) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _height (round __height))
   (setq _width (round __width))
   (setq _events __events)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:events
   (&rest __events)
   (if (keywordp (car __events))
       (send* _events __events)
     (progn
       (if __events (setq _events (car __events)))
       _events)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _height
    4
    ;; uint32 _width
    4
    ;; mpl_dataset_toolbox/Event[] _events
    (apply #'+ (send-all _events :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _height
       (write-long _height s)
     ;; uint32 _width
       (write-long _width s)
     ;; mpl_dataset_toolbox/Event[] _events
     (write-long (length _events) s)
     (dolist (elem _events)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _height
     (setq _height (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _width
     (setq _width (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; mpl_dataset_toolbox/Event[] _events
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _events (let (r) (dotimes (i n) (push (instance mpl_dataset_toolbox::Event :init) r)) r))
     (dolist (elem- _events)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get mpl_dataset_toolbox::EventArray :md5sum-) "5e8beee5a6c107e504c2e78903c224b8")
(setf (get mpl_dataset_toolbox::EventArray :datatype-) "mpl_dataset_toolbox/EventArray")
(setf (get mpl_dataset_toolbox::EventArray :definition-)
      "# This message is copied from Prophesee ROS Wrapper.
# This message contains an array of events
# (0, 0) is at top-left corner of image
#

Header header

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# an array of events
Event[] events

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: mpl_dataset_toolbox/Event
# This message is copied from Prophesee ROS Wrapper.
# A single event message
uint16 x
uint16 y
time ts
bool polarity

")



(provide :mpl_dataset_toolbox/EventArray "5e8beee5a6c107e504c2e78903c224b8")


