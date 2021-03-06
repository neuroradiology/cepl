;; This software is Copyright (c) 2012 Chris Bagley
;; (techsnuffle<at>gmail<dot>com)
;; Chris Bagley grants you the rights to
;; distribute and use this software as governed
;; by the terms of the Lisp Lesser GNU Public License
;; (http://opensource.franz.com/preamble.html),
;; known as the LLGPL.

;;;; package.lisp

(defpackage :cepl-utils
  (:use :cl)
  (:nicknames :utils)
  (:export :gdefun 
           :dbind
           :assoc-bind
           :sn-equal
           :listify
           :replace-nth 
           :hash-values
           :lambda-list-split
           :hash-keys 
           :intersperse
           :walk-replace
           :file-to-string
           :flatten
           :find-in-tree
           :mkstr
           :symb
           :symb-package
           :make-keyword
           :kwd
           :group
           :safe-read-from-string
           :sub-at-index
           :symbolicate-package
           :lispify-name
           :symbol-name-equal
           :range
           :rangei
           :arange
           :arangei
           :mapcat
           :deferror
           :split-seq-by-seq
           :dbg
           :print-mem))

(defpackage :base-macros
  (:use :cl :cepl-utils)
  (:export :once-only
           :continuable
           :apply-across-elements))

(defpackage :base-maths
  (:use :cl)
  (:export :clamp
           :clampf
           :+float-threshold+
           :+one-degree-in-radians+
           :+pi+
           :float-zero
           :float>=0
           :float<=0
           :float>0
           :float<0
           :float-greater-than-zero
           :c-sqrt
           :c-inv-sqrt
           :degrees
           :radians))

(defpackage :maths
  (:use :cl)
  (:export :lerp :mix :stepv :clamp :smoothstep :pulse
           :spline))

(defpackage :base-vectors
  (:use :cl)
  (:export :v! :v-x :v-y :v-z :v-w
           :v!byte :v!ubyte :v!int))

(defpackage :base-matrices
  (:use :cl)
  (:export :m!))

(defpackage :vector2
  (:use :cl)
  (:nicknames :v2)
  (:export :make-vector2 :v+ :v+1 :v- :v-1 :v* :v-eq
           :v*vec :v/ :v/vec :negate :vlength-squared
           :vlength :distance-squared :distance :dot
           :absolute-dot :normalize :perp-dot
           :*unit-x* :*unit-y* :*unit-scale*
           :vzerop :unitp :cross :face-foreward :lerp
           :bezier :spline)
  (:import-from :base-maths :float-zero
                :c-sqrt
                :c-inv-sqrt)
  (:import-from :base-macros
                :apply-across-elements)
  (:import-from :base-vectors :v-x :v-y))

(defpackage :vector3
  (:use :cl)
  (:nicknames :v3)
  (:export :make-vector3 :v+ :v+1 :v- :v-1 :v* :v-eq
           :v*vec :v/ :v/vec :negate :vlength-squared
           :vlength :distance-squared :distance :dot
           :absolute-dot :normalize :cross
           :*unit-x* :*unit-y* :*unit-z* :*unit-scale*
           :vzerop :unitp :cross :face-foreward :lerp
           :bezier :spline)
  (:import-from :base-maths :float-zero
                :c-sqrt
                :c-inv-sqrt)
  (:import-from :base-macros
                :apply-across-elements)
  (:import-from :base-vectors :v-x :v-y :v-z))

(defpackage :vector4
  (:use :cl)
  (:nicknames :v4)
  (:export :make-vector4 :v+ :v+1 :v- :v-1 :v* :v3* :v-eq
           :v*vec :v/ :v/vec :negate :vlength-squared
           :vlength :distance-squared :distance :dot
           :absolute-dot :normalize :cross
           :*unit-x* :*unit-y* :*unit-z* :*unit-w* :*unit-scale*
           :vzerop :unitp :face-foreward :lerp
           :bezier :spline)
  (:import-from :base-maths :float-zero
                :c-sqrt
                :c-inv-sqrt)
  (:import-from :base-macros
                :apply-across-elements)
  (:import-from :base-vectors :v-x :v-y :v-z :v-w))

(defpackage :vectors
  (:use :cl)
  (:nicknames :v)
  (:export :v :make-vector :zerop :unitp := :+ :/= :1+ :1- :- :*
           :/ :length :length-squared :distance :distance-squared
           :dot :absolute-dot :perp-dot :normalize :cross :eq
           :swizzle :merge-into-vector :negate :face-foreward :lerp
           :mix :bezier) 
  (:shadow :zerop :+ :eq := :/= :1+ :1- :- :* :/ :length)
  (:import-from :vector2
                :make-vector2)
  (:import-from :vector3 
                :make-vector3)
  (:import-from :vector4
                :make-vector4))

(defpackage :matrix3
  (:use :cl)
  (:nicknames :m3)
  (:export :melm :identity-matrix3 :zero-matrix3 
           :make-matrix3 :make-from-rows :get-rows
           :get-row :make-from-columns :get-columns
           :get-column :determinate-cramer :inverse
           :mzerop :identityp :meql :transpose :adjoint
           :mtrace :rotation-from-euler 
           :rotation-from-axis-angle :scale
           :rotation-x :rotation-y :rotation-z
           :get-fixed-angles :get-axis-angle :m+ :m- :negate
           :m* :mcol*vec3 :mrow*vec3 :m*scalar)
  (:import-from :base-maths :float-zero
                :c-sqrt)
  (:import-from :vector3 
                :make-vector3)
  (:import-from :base-macros
                :apply-across-elements)
  (:import-from :base-vectors :v-x :v-y :v-z :v-w))

(defpackage :matrix4
  (:use :cl)
  (:nicknames :m4)
  (:export :melm :identity-matrix4 :zero-matrix4 
           :2dclipspace-to-imagespace-matrix4 :make-matrix4
           :mzerop :identityp :meql :minor :adjoint 
           :determinant :affine-inverse :transpose 
           :translation :rotation-from-matrix3
           :rotation-from-euler :rotation-from-axis-angle
           :scale :rotation-x :rotation-y
           :rotation-z :get-fixed-angles :mtrace
           :get-axis-angle :m+ :m- :negate :m*scalar
           :mcol*vec4 :mrow*vec4 :m* :transform
           :to-matrix3 :get-row :get-rows :get-column
           :get-columns)
  (:import-from :base-maths :float-zero
                :c-sqrt)
  (:import-from :vector3 
                :make-vector3)
  (:import-from :vector4
                :make-vector4)
  (:import-from :base-macros
                :apply-across-elements)
  (:import-from :base-vectors :v-x :v-y :v-z :v-w))


(defpackage :matrices
  (:use :cl)
  (:nicknames :m)
  (:export :zerop :unitp :+ :eq := :/= :1+ :1- :- :*
           :identityp :elt :elm :get-rows :get-row
           :get-columns :get-column :determinant
           :inverse :transpose :trace :negate
           :print-matrix) 
  (:shadow :zerop :unitp :+ :eq := :/= :1+ :1- :- :*
           :elt :trace))

(defpackage :quaternions
  (:use :cl :base-maths)
  (:nicknames :q)
  (:shadow :lerp)
  (:export :w :x :y :z :zero-quit :zero-quatp 
           :unit-quatp :identity-quat :identity-quatp
           :make-quat :make-quat-from-vec3 
           :make-quat-from-rotation-matrix3 
           :make-quat-from-axis-angle
           :make-quat-from-vectors
           :make-quat-from-fixed-angles 
           :magnitude :norm :quat-eql :quat-!eql
           :copy :get-axis-angle :normalize :qconjugate
           :inverse :q+1 :q+ :q-1 :q- :q* :q*quat
           :dot :rotate :lerp :slerp :approx-slerp
           :to-matrix3 :to-matrix4))

(defpackage :declarative-values
  (:use :cl)
  (:nicknames :dvals)
  (:export :make-dval :dval :bind :unbind :brittle-bind :unbind-all))

(defpackage :base-space
  (:use :cl :base-macros :base-vectors :base-matrices)
  (:nicknames :cspace)
  ;;(:export :things)
  )

(defpackage :cepl-gl
  (:use :cl :cffi :base-macros :cepl-utils :varjo)
  (:nicknames :cgl)
  (:import-from :cl-opengl
                :clear-color
                :enable
                :disable
                :cull-face
                :front-face
                :depth-mask
                :depth-func
                :depth-range
                :clear
                :clear-depth
                :flush
                :viewport
                :delete-shader)
  (:import-from :utils
                :deferror
                :print-mem)
  (:shadow :float)
  (:export :gl-context
           :clear-gl-context-cache
           :gl-free
           :update-display
           :valid-pixel-format-p
           :pixel-format
           :internal-format-from-pixel-format
           :pixel-format-from-internal-format
           :pixel-format-of
           :describe-pixel-format
           :defglstruct
           :c-array-byte-size
           :gl-calc-byte-size
           :make-c-array-from-pointer
           :with-c-array
           :free-c-array
           :clone-c-array
           :make-c-array
           :aref-c
           :%aref-c
           :c-populate
           :gl-subseq
           :gl-pull
           :gl-pull-1
           :gl-push
           :dimensions ; [TODO] this isnt really inline with array-dimensions
           :backed-by ; [TODO] is this the right name for the job?
           :element-type
           :1d-p
           :bind-buffer
           :force-bind-buffer
           :unbind-buffer
           :gen-buffer
           :buffer-data-raw
           :buffer-data
           :buffer-sub-data
           :multi-buffer-data
           :buffer-reserve-block-raw
           :buffer-reserve-block
           :buffer-reserve-blocks
           :make-gpu-array
           :make-gpu-arrays
           :with-gpu-array-as-c-array
           :suitable-array-for-index-p
           :bind-vao
           :bind-vertex-array
           :make-vao-from-formats
           :make-vao
           :make-raw-vertex-stream
           :make-vertex-stream
           :make-texture
           :bind-texture
           :with-texture-bound
           :mutable-texturep
           :upload-c-array-to-gpuarray-t ; this is a crap name
           :calc-sampler-type
           :dimensions-at-mipmap-level
           :establish-texture-type
           :gl-texture
           :gpu-array-t
           :texref
           :defpipeline
           :defvshader
           :deffshader
           :defgshader
           :defshader
           :defsmacro
           :defsfun
           :with-instances
           :free-managed-resources
           :free-buffer
           :free-buffers
           :free-vertex-stream
           :free-texture
           :free-gpu-array
           :free-vao
           :g-pn
           :g-pc
           :g-pt
           :g-pnc
           :g-pnt
           :g-pntc
           :pos
           :norm
           :tex
           ;;----------
           :delete-shader
           :clear-color
           :cls
           :enable
           :disable
           :cull-face
           :front-face
           :depth-mask
           :depth-func
           :depth-range
           :clear
           :clear-depth
           :flush
           :viewport
           ;;----------
           :make-fbo
           :make-fbos
           :with-bind-fbo
           :fbo-attach
           :attachment-compatible
           :fbo-detach
           ;;----------
           :def-gl-equivalent))

(defpackage :varjo-bridge-types
  (:use :cl))

(defpackage :%cgl
  (:use :cl :varjo :cgl))

(defpackage :cepl-camera
  (:nicknames :ccam)
  (:use :cl)
  (:export :camera
           :make-camera
           :orthographic-projection
           :perspective-projection
           :world->cam
           :look-at
           :world-up
           :pos
           :dir
           :frame-size
           :fov
           :far
           :near
           :cam->clip-func
           :cam->clip
           :world->cam
           :make-cam-clip-matrix)
  (:import-from :vector2
                :make-vector2)
  (:import-from :vector3 
                :make-vector3)
  (:import-from :vector4
                :make-vector4))

(defpackage :model-parsers
  (:use :cl)
  (:export :parse-obj-file
           :parse-lisp-model
           :load-lisp-model)
  (:import-from :vector2
                :make-vector2)
  (:import-from :vector3 
                :make-vector3)
  (:import-from :vector4
                :make-vector4))

(defpackage :primitives
  (:use :cl
        :base-vectors
        :base-matrices
        :base-maths)
  (:export :primitive-data
           :plain-data
           :box-data
           :sphere-data
           :prim-array))

(defpackage :tools
  (:use :cl
        :base-vectors
        :base-matrices
        :base-maths)
  (:export :rqpos))

(defpackage :live
  (:use :cl :cepl-utils)
  (:export :defdemo
           :update-swank
           :peek))

(defpackage :cepl
  (:use :cl
        :declarative-values
        :base-vectors
        :base-matrices
        :base-maths
        :base-macros
        :temporal-functions
        :cepl-camera
        :live)
  (:import-from :cepl-gl
                :cls
                :pixel-format
                :pixel-format-of
                :describe-pixel-format
                :with-instances
                :defpipeline
                :defvshader
                :deffshader
                :defgshader
                :defshader
                :defsfun
                :defsmacro
                :defglstruct
                :gl-pull
                :gl-pull-1
                :gl-push
                :make-c-array
                :with-c-array                
                :free-c-array
                :aref-c
                :c-populate
                :make-gpu-array
                :make-gpu-arrays
                :gl-subseq
                :with-gpu-array-as-c-array
                :make-vertex-stream
                :make-texture                
                :with-texture-bound
                :g-pn
                :g-pc
                :g-pt
                :g-pnc
                :g-pnt
                :g-pntc
                :texref
                ;;---
                :make-fbo
                :make-fbos
                :with-bind-fbo
                :fbo-attach
                :attachment-compatible
                :fbo-detach
                ;;---
                :def-gl-equivalent)
  (:import-from :utils
                :deferror
                :print-mem)
  (:export :cepl-gl
           :cls
           :pixel-format
           :pixel-format-of
           :describe-pixel-format
           :with-instances
           :defpipeline
           :defvshader
           :deffshader
           :defgshader
           :defshader
           :defsfun
           :defsmacro
           :defglstruct
           :gl-pull
           :gl-pull-1
           :gl-push
           :make-c-array
           :with-c-array                
           :free-c-array
           :aref-c
           :c-populate
           :make-gpu-array
           :make-gpu-arrays
           :gl-subseq
           :with-gpu-array-as-c-array
           :make-vertex-stream
           :make-texture                
           :with-texture-bound
           :g-pn
           :g-pc
           :g-pt
           :g-pnc
           :g-pnt
           :g-pntc
           :texref
           ;;---
           :make-fbo
           :make-fbos
           :with-bind-fbo
           :fbo-attach
           :attachment-compatible
           :fbo-detach
           ;;---
           :def-gl-equivalent
           :repl
           ;;---
           :case-events
           :collect-event-types
           :evt+>
           :evt->
           :update-swank
           :peek
           ))
