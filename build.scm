;; Example build file for Schemake v0.1

(project :name "DXVK"
         :languages ('c 'cpp)
         :version "v1.10.1"
         :sm-version ">= 0.1"
         :compiler-opts ("cpp_std=c++17"))

(define cpu-family target-machine->cpu-family)

(define cpp (get-compiler 'cpp))
(define c (get-compiler 'c))
(define dxvk-is-msvc (eqv? (get-id cpp) "msvc"))

(define compiler-args (list
                       "-DNOMINMAX"
                       "-D_WIN32_WINNT=0xa00"
                       "-msse"
                       "-msse2"
                       "-msse3"
                       "-mfpmath=sse"
                       "-Wimplicit-fallthrough"
                       ;; clang
                       "-Wno-unused-private-field"
                       "-Wno-microsoft-exception-spec"))

(define link-args (list
                   "-static"
                   "-static-libgcc"
                   "-static-libstdc++"
                   ;; We need to set the section alignment for debug symbols to
                   ;; work properly as well as avoiding a memcpy from the Wine loader.
                   "-Wl--file-alignment=4096"))

(cond (and
     (option "debug")
     (eqv? (get-target-machine system) "windows"))
    (append compiler-args (list
                           "-gstrict-dwarf" "-gdwarf-2")))

(if (option "build_id")
    (append link-args "-Wl,--build-id"))

(if (eqv? cpu-family "x86")
    (append link-args (list
                       "-Wl,--enable-stdcall-fixup"
                       "-Wl,--add-stdcall-alias")))

(define dxvk-include-path (inc "./include"))

(define dxvk-library-path
  (cond ((eqv? cpu-family "x86_64")
      (string-append source-root "/lib"))
      (else (string-append source-root "/lib32"))))

(define lib-vulkan (find-library cpp ("vulkan-1" :dirs dxvk-library-path)))
(define lib-d3d9 (find-library cpp ("d3d9")))
(define lib-d3d11 (find-library cpp ("d3d11")))
(define lib-dxgi (find-library cpp ("dxgi")))
(define lib-d3dcompiler-43 (find-library cpp ("d3dcompiler_43" :dirs dxvk-library-path)))

(define lib-d3dcompiler-47
  (cond ((dxvk-is-msvc) (find-library cpp "d3dcompiler"))
        else(find-library cpp "d3dcompiler_47")))

(define glsl-compiler (find-program "glslangValidator"))
(define glsl-args (list
                   "--target-env"
                   "vulkan1.2"
                   "--vn"
                   "@BASENAME@"
                   "@INPUT@"
                   "-o"
                   "@OUTPUT@"))

(cond (let output (open-output-pipe "glslValidator --quiet --version") (eqv? 0 (status:exit-val (close-pipe output))))
      (string-append glsl-args "--quiet"))
