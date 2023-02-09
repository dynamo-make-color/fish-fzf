function __fzf_binding -d "Setup key bindings with callback"
  if not test -n "$argv[2]"
    echo "Must have callback"
    return 1
  end

  if not test -n "$argv[2]"
    echo "Must have binding"
    return 1
  end

  bind --preset "$argv[1]" "$argv[2]"
  if test "$fish_key_bindings" = fish_vi_key_bindings
    bind --preset -M insert "$argv[1]" "$argv[2]"
  end
end
