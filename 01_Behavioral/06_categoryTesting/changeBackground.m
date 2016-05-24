img=imread('zupudsovor1-01.jpg');

for i=1:320
    for j=1:640
        for k=1:3
            if img(i,j,k)>128
                img(i,j,k)=128;
            end
        end
    end
end

imwrite(img, 'zupudsovor1.jpg', 'JPG')

%%

img=imread('zupudsovor2-01.jpg');

for i=1:320
    for j=1:640
        for k=1:3
            if img(i,j,k)>128
                img(i,j,k)=128;
            end
        end
    end
end

imwrite(img, 'zupudsovor2.jpg', 'JPG')