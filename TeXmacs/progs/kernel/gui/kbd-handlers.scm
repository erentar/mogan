
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : kbd-handlers.scm
;; DESCRIPTION : Default keyboard handlers
;; COPYRIGHT   : (C) 2010  Joris van der Hoeven
;;
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(texmacs-module (kernel gui kbd-handlers)
  (:use (kernel texmacs tm-define)))

(tm-define ShiftMask     256)
(tm-define LockMask      512)
(tm-define ControlMask  1024)
(tm-define Mod1Mask     2048)
(tm-define Mod2Mask     4096)
(tm-define Mod3Mask     8192)
(tm-define Mod4Mask    16384)
(tm-define Mod5Mask    32768)

(tm-define (keyboard-press key time)
  (key-press key))

(tm-define (keyboard-focus has-focus? time)
  (noop))

(tm-define (mouse-event key x y mods time data)
  ;;(display* "mouse-event " key ", " x ", " y ", " mods ", " time ", " data "\n")
  (mouse-any key x y mods (+ time 0.0) data))

(tm-define (mouse-drop-event x y obj)
  ;;(display* "mouse-drop-event " x ", " y ", " (tm->stree obj) "\n")
  (insert obj))

(tm-define (kbd-insert s)
  (insert s))

(tm-define (speech-make S)
  (with lan (get-preference "language")
    (when (!= lan "english")
      (set! S (translate-from-to S lan "english"))))
  (with s (string-replace (locase-all S) " " "-")
    (and (style-has? s)
         (>= (string-length s) 3)
         (begin
           (make (string->symbol s))
           #t))))

(tm-define (kbd-speech s)
  ;;(display* "Speech " s "\n")
  (cond ((speech-make s) (noop))
        (else (kbd-insert s))))
