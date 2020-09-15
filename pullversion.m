function groups=pullversion(pull)

if pull==1
    %These are the clutter echos not amp corrected
    groups=struct;
    groups.cyls.nums=[54 55 56];
    groups.cubes.nums=[57 58 59];
    groups.spheres.nums=[61 60]; %this is not a good solution, but will keep code from breaking
    groups.LDs.nums=[62 63 64];
    groups.SDs.nums=[65 66 67];
    groups.MPs.nums=[68 69 70];
elseif pull==2
    %These are the clutter echos amp corrected
    groups=struct;
    groups.cyls.nums=[36 37 38];
    groups.cubes.nums=[39 40 41];
    groups.spheres.nums=[53 42 43];
    groups.LDs.nums=[44 45 46];
    groups.SDs.nums=[47 48 49];
    groups.MPs.nums=[50 51 52];
    
elseif pull==3
    %These are the clutter not amp corrected
    groups=struct;
    groups.cyls.nums=[1 2 3];
    groups.cubes.nums=[4 5 6];
    groups.spheres.nums=[18 7 8];
    groups.LDs.nums=[9 10 11];
    groups.SDs.nums=[12 13 14];
    groups.MPs.nums=[15 16 17];
    
elseif pull==4
    %These are the clutter amp corrected
    groups=struct;
    groups.cyls.nums=[1 2 3];
    groups.cubes.nums=[4 5];
    groups.LDs.nums=[7 8 9];
    groups.SDs.nums=[10 11 12];
    
    
elseif pull==5
    %these are 3d echoes not amp corrected
    groups=struct;
    groups.cyls.nums=[23 24 25];
    groups.cubes.nums=[26 27];
    groups.LDs.nums=[28 29 30];
    groups.SDs.nums=[31 32 33];
elseif pull==6
    %these are 3d echoes amp corrected
    groups=struct;
    groups.cyls.nums=[34 35 36];
    groups.cubes.nums=[37 38];
    groups.LDs.nums=[39 40 41];
    groups.SDs.nums=[42 43 44];
elseif pull==7
    %these are 3d not amp corrected
    groups=struct;
    groups.cyls.nums=[1 2 3];
    groups.cubes.nums=[4 5];
    groups.LDs.nums=[6 7 8];
    groups.SDs.nums=[9 10 11];
elseif pull==8
    %these are 3d amp corrected
    groups=struct;
    groups.cyls.nums=[12 13 14];
    groups.cubes.nums=[15 16];
    groups.LDs.nums=[17 18 19];
    groups.SDs.nums=[20 21 22];
    
    %%this is bad and disorganized but whatever
elseif pull==9
    %V2 pairs, not amp corrected clutter with 10ms delay
    groups=struct;
    groups.cyls.nums=[2 5 8];
    groups.cubes.nums=[11 14 17];
    groups.spheres.nums=[53 20 23];
    groups.LDs.nums=[26 29 32];
    groups.SDs.nums=[35 38 41];
    groups.MPs.nums=[44 47 50];
end
