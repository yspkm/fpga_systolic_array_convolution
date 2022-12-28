function C = get_conv(A, B)
    C = [0, 0; 0, 0];
    C(1, 1) = sum(sum(A(1:3, 1:3) .* rot90(B,2)));
    C(1, 2) = sum(sum(A(1:3, 2:4) .* rot90(B,2)));
    C(2, 1) = sum(sum(A(2:4, 1:3) .* rot90(B,2)));
    C(2, 2) = sum(sum(A(2:4, 2:4) .* rot90(B,2)));
end