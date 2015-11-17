# RTWRTM

This is the code for the RTWRTM model, a very simple ray-tracing Radiative Transfer Model written as part of my MSc thesis. It is *not* suitable for any production use in any way - but may be useful to others in seeing how Radiative Transfer Models can be implemented.

The thesis I wrote is available in the `docs` folder, along with an extract from the thesis showing how each individual ray is treated.

The code is written in IDL, and has been tested using IDL 8.5. To run it, load IDL and change to the directory containing the code and then run something like the following:

```
result = RUN_RTM(0, 0, 0)
```

This will produce results with the default parameterisation with *no* cloud in the sky. To include the pre-defined cloud, change the values of `0, 0, 0` to `x, y, 1` where `x` and `y` are the location of the centre of the cloud on the grid.

If you're interested in a model that can do this sort of thing *properly* then investigate the Discrete Anisotropic Radiative Transfer model (DART) - see http://www.cesbio.ups-tlse.fr/us/dart.html.
