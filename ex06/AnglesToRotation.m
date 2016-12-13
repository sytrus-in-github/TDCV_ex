function R = AnglesToRotation( alpha, beta, gamma )
    cosa = cos(alpha);
    cosb = cos(beta);
    cosc = cos(gamma);
    sina = sin(alpha);
    sinb = sin(beta);
    sinc = sin(gamma);
    R = [cosa * cosc - sina * cosb * sinc , - cosa * sinc - sina * cosb * cosc , sina * sinc;
        sina * cosc + cosa * cosb * sinc , - sina * sinc + cosa * cosb * cosc , -cosa * sinc;
        sinb * sinc , sinb * cosc , cosb];
end

