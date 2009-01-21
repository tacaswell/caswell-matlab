function out = t_trim_md(in,shift_cut,rg_ucut,e_cut)
%o function out = t_trim_md(in,shift_cut,rg_ucut,e_cut)
%o summary: filters the peaks returned by peter's code based on how much
%they shifted, the radius of gyration, and the ecentricity.  Also removes
%peaks that did not have any x or y offset, meaning only a very small
%number of pixels were involved
%o outputs:
%-out:filtered peaks, same format as input
%o input:
%-in: unfiltered peak posistions in form [1d_cord x y x_offset
%y_offset, total_mass, r2_val, multiplicity_val, e]
%-shift_cut: any peaks that shifted more than this from the local max are
%removed, this shift is indicative of heavy bias due to adjacent
%particles
%-rg_ucut: cuts particles with a radius of gyration greater than this
%-e_cut: cuts eccentricities greater than this value
    
    in = in((in(:,4)~=0)&(in(:,5)~=0),:);
    %%removes points that did not get any x-y offset correction
    %%as this means they are very small
    in = in(sqrt(sum(in(:,[4 5]).^2,2))<shift_cut,:);
    %%removes all points who are shifted more thanshift_cut pixel off of the max
    in = in(in(:,7)<rg_ucut,:);
    %%removes everything above a certian rg
    in = in(in(:,9)<e_cut,:);
    %%removes everything with an 'e' great than e_cut
    out =in;
end
    