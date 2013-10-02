% wavelet_factory_2d_pyramid: Create wavelet cascade
% Usage
%    [Wop, filters] = wavelet_factory_2d_pyramid(filt_opt, scat_opt)
%
% Input
%    filt_opt: The filter options, same as for morlet_filter_bank_2d 
%	 scat_opt: The scattering and wavelet options, same as
%		wavelet_layer_1d/wavelet_1d.
%
% Output
%    Wop: A cell array of wavelet transforms needed for the scattering trans-
%       form.
%    filters: A cell array of the filters used in defining the wavelets.

function [Wop, filters] = wavelet_factory_2d_pyramid(filt_opt, scat_opt)
	
    if(nargin<1)
        filt_opt=struct;
    end
    if(nargin<2)
        scat_opt=struct;
    end

	% filt_opt.null = 1; EDOUARD 01/10/13
	% scat_opt.null = 1; EDOUARD 01/10/13
	scat_opt = fill_struct(scat_opt, 'M', 2);
	
	% filters :
	filt_opt = fill_struct(filt_opt, 'type', 'morlet');
	switch (filt_opt.type)
		case 'morlet'
            %%%%%% 01/10/13 EDOUARD
            filt_opt=rmfield(filt_opt,'type');
			filters = morlet_filter_bank_2d_pyramid(filt_opt);
			
		case 'haar'
            %%%%%% 01/10/13 EDOUARD
            filt_opt=rmfield(filt_opt,'type');
			filters = haar_filter_bank_2d_spatial(filt_opt);
			
	end
	
	% wavelet transforms :
	for m = 1:scat_opt.M+1
		Wop{m} = @(x)(wavelet_layer_2d_pyramid(x, filters, scat_opt));
	end
end
