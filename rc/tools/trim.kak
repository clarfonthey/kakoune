define-command trim -params .. -docstring "trim [<key>]...: trims trailing whitespace from selected lines after running the given keys" %{
    try %{ execute-keys -draft %arg{@} <a-x> s \h+$ <ret> d }
}

define-command -hidden run-autotrim nop

define-command autotrim-enable -docstring "autotrim-enable: register hooks to run trim-whitespace while editing" %{
    define-command -hidden -override -params .. run-autotrim trim
    hook window -group autotrim ModeChange pop:insert:.* trim
    hook window -group autotrim BufWritePre .* %{ trim <percent> }
}

define-command autotrim-disable -docstring "autotrim-disable: remove hooks to run trim while editing" %{
    define-command -hidden -override -params .. run-autotrim nop
    remove-hooks window autotrim
}
