from dipy.data import fetch_sherbrooke_3shell
fetch_sherbrooke_3shell

from os.path import expanduser, join
home = expanduser('~')

dname = join(home, '.dipy', 'sherbrooke_3shell')

fdwi = join(dname, 'HARDI193.nii.gz')

fbval = join(dname, 'HARDI193.bval')

fbvec = join(dname, 'HARDI193.bvec')

import nibabel as nib
img = nib.load(fdwi)
data = img.get_data()
print('Here is the size of your data: \n')
print(data.shape)
print('Here is the dimensions of each voxel: \n')
print(img.get_header().get_zooms()[:3])