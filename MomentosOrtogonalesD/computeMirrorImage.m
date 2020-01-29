function m_mirror = computeMirrorImage(m)

[n_r, n_c] = size(m);

for i=1:1:n_c
    m_mirror(:,i) = m(:,n_c - i + 1);
end