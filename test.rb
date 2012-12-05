# Algorithms and defaults taken from
# http://www.easyrgb.com/index.php?X=MATH

Ref_x =  95.047
Ref_y = 100.000
Ref_z = 108.883

def rgb_to_xyz(r,g,b)
    vR, vG, vB = r/255.0, g/255.0, b/255.0

    if vR > 0.04045 then
        vR = ( ( vR + 0.055) / 1.055) ** 2.4
    else
        vR = vR / 12.92
    end

    if vG > 0.04045 then
        vG = ( ( vG + 0.055) / 1.055) ** 2.4
    else
        vG = vG / 12.92
    end

    if vB > 0.04045 then
        vB = ( ( vB + 0.055) / 1.055) ** 2.4
    else
        vB = vB / 12.92
    end

    vR = vR * 100
    vG = vG * 100
    vB = vB * 100

    x = vR * 0.4124 + vG * 0.3576 + vB * 0.1805
    y = vR * 0.2126 + vG * 0.7152 + vB * 0.0722
    z = vR * 0.0193 + vG * 0.1192 + vB * 0.9505

    return x, y, z
end

def xyz_to_lab(x,y,z)
    vX, vY, vZ = x/Ref_x, y/Ref_y, z/Ref_z
    
    if vX > 0.008856 then
        vX = vX ** (1.0/3)
    else
        vX = (7.787 * vX) + (16.0/116)
    end

    if vY > 0.008856 then
        vY = vY ** (1.0/3)
    else
        vY = (7.787 * vY) + (16.0/116)
    end

    if vZ > 0.008856 then
        vZ = vZ ** (1.0/3)
    else
        vZ = (7.787 * vZ) + (16.0/116)
    end

    l = ( 116 * vY ) - 16
    a = 500 * ( vX - vY )
    b = 200 * ( vY - vZ )

    return l, a, b
end

def rgb_to_lab(r,g,b)
    x,y,z = rgb_to_xyz(r,g,b)
    l,a,b = xyz_to_lab(x,y,z)

    return l,a,b
end

colours = [
    [0,0,0], [255,0,0], [0,255,0], [0,0,255], [255,255,255]
]

# pure blue
bl,ba,bb = rgb_to_lab(0,0,255)

colours.each do |c|
    l,a,b = rgb_to_lab(*c)

    distance = (l-bl)**2 + (a-ba)**2 + (b-bb)**2

    puts "#{c} => #{distance} => #{l},#{a},#{b}"
end
