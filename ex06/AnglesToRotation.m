function R = AnglesToRotation( alpha, beta, gamma )
    cosa = cos(alpha);
    cosb = cos(beta);
    cosc = cos(gamma);
    sina = sin(alpha);
    sinb = sin(beta);
    sinc = sin(gamma);
    R = [cosa * cosc - sina * sinb * sinc , -cosb * sina , sina * sinb * cosc + cosa * sinc;
        sina * cosc + cosa * sinb * sinc, cosa * cosb, sina * sinc - cosa * sinb * cosc;
        - cosb * sinc, sinb, cosb * cosc];
%     R = [cosa * cosb, - sina * cosc + cosa * sinb * sinc, sina * sinc + cosa * sinb * cosc;
%          sina * cosb, cosa * cosc + sina * sinb * sinc, - cosa * sinc + sina * sinb * cosc;
%          sinb, cosb * sinc, cosb * cosc];
end

