### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ 578ebd0a-d6d3-11ec-1589-55fe742489b1
begin
	import Pkg; Pkg.activate()
	using Controlz, CairoMakie, PlutoUI

	TableOfContents()
end

# ╔═╡ f7a9117f-6f41-44b2-be0b-c5a08ff2990d
set_theme!(Controlz.cool_theme)

# ╔═╡ abefda5a-0fc0-44c8-83c4-4d28fe7b3ac9
md"# QCM-MOF sensors

> Metal-organic frameworks (MOFs) are nanoporous materials with high prospects as recognition elements for enhanced gas sensors, owing to their adsorptive sensitivity and selectivity. A QCM-MOF sensor is a gravimetric sensor composed of a quartz crystal microbalance (QCM) coated with a thin film of MOF serving as the sensing element. Nanogram-scale changes in the adsorbed mass of gas in the MOF film can be inferred from changes in the vibration frequency of the piezoelectric quartz crystal, forced by an alternating voltage. [source](https://iopscience.iop.org/article/10.1088/1361-648X/ac1e49/meta)

To learn more about a QCM-MOF sensor, see the research paper (posted on Canvas with my highlights):

> L. Wang. \"Metal-organic frameworks for QCM-based gas sensors: A review\". _Sensors and Actuators A: Physical_. 2020.
"

# ╔═╡ 6d6f5be6-cfc0-4dc9-a75e-6886c348af89
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE461_S2023/main/studios/qcm_mofs.png\" width=400>"

# ╔═╡ 29e4e996-ccd4-4957-8ba3-e95186fec645
md"the top figure above shows three different crystal structures of MOFs. Note the nano-sized pores that host gas molecules, attracted to the walls of the pores. the bottom left figure shows a QCM---a quartz disk sandwiched between two gold electrodes. you can't see the thin film of MOF from the naked eye, but the bottom right figure shows an image of the film taken from a scanning electron microscope.

💡 the QCM-MOF sensor has a certain _response time_. when a new species appears in the gas phase, it must adsorb and diffuse into the thin film of MOF to produce the response of the sensor–-this takes time!

eg. the figure below shows the dynamic response of a QCM-MOF sensor when exposed to air, then air containing acetone, then air again---so, a rectangular pulse in the concentration of acetone in the gas phase. 
"

# ╔═╡ 52c894f7-a247-402c-b90e-de32c433a8d1
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE461_S2023/main/studios/uptake_curve.png\" width=300>"

# ╔═╡ 578f7eaa-c2cc-49b6-bea1-3bb415e7c467
md"
# frequency response of a QCM-MOF sensor

a QCM-MOF sensor for acetone (ie., the MOF exhibits adsorptive selectivity towards acetone) reports the measured acetone concentration in the air, $c_m(t)$ [ppm].

let $c(t)$ [ppm] be the _true_ acetone concentration in the air.

💡 unfortunately, generally $c_m(t)\neq c(t)$. why not? if $c(t)$ increases (decreases), additional acetone will adsorb (desorb) and diffuse into (out of) the thin film of MOF to produce the gravimetric response of the sensor---this takes time!

## dynamics of the sensor response
the time constant of the sensor, provided below, was determined by introducing a step change in the acetone concentration and observing the response (see Fig. 5b of Wang).

the sensor exhibits first-order dynamics with a time constant of $\tau=12/60$ min. 
```math
\begin{equation}
G(s)=\frac{C_m^*(s)}{C^*(s)}=\dfrac{1}{\frac{12}{60}s+1}.
\end{equation}
```

🐺 define the transfer function of the sensor as a variable `g` below.
"

# ╔═╡ 7b883807-52d3-4fdb-ad9c-6a11f47081e7

# ╔═╡ 1390383a-5b87-4f6c-8831-23c59c415420
md"
## Bode plot showing frequency response characteristics of the sensor

🐺 draw the Bode plot showing the frequency response characteristic of the gas sensor by passing `g` to `bode_plot` (see [docs](https://simonensemble.github.io/Controlz.jl/dev/viz/#Bode-plot)). display over the range of input frequencies $10^{-2}$ to $10^1$ rad/min.

!!! hint
    the keyword arguments `log10_ω_min` and `log10_ω_max` to `bode_plot` give control over the range of frequencies displayed in the Bode plot.
"

# ╔═╡ 1268ea9a-624d-4d49-b89a-81bf3cdd31b8

# ╔═╡ a62f3c02-251f-4570-a68c-b5cee5b22c25
md"
🐺 explain intuitively what a Bode plot tells us about the dynamics of the acetone sensor.

* a Bode plot tells us about the output of a system in response to [... your answer...].

specifically:
* the top panel of the Bode plot shows [... your answer ...].

* the bottom panel of the Bode plot shows [... your answer ...].
"

# ╔═╡ 9c9317ad-e712-4468-a758-1b0d9e529d28
md"
## predicting the frequency response of the sensor

**the input.** suppose the acetone concentration in the air $c(t)$ is oscillating sinusoidally, between 400 ppm and 1000 ppm, with a period (time between peaks) of 1 minute. 

🐺 define the frequency, amplitude, and average value of this oscillating input as variables `ω` [radians/min], `A` [ppm], and `c̄` [ppm] below.
"

# ╔═╡ 0eeee419-4817-4afe-8961-cdd2803e235e
# period of oscillating input [min]

# ╔═╡ 9efd6364-17de-4436-bb86-db1c17eda0a3
# frequency of oscillating input [rad/min]

# ╔═╡ 6e386475-56a3-4494-8324-bf2315a92f70
# amplitude of oscillating input [ppm]

# ╔═╡ a7762d8b-b2ee-4172-8e31-5d414725c8ad
# average value of oscillating input

# ╔═╡ 042a9300-5de9-4dcc-8e6c-d11bb40049fb
md"🐺 use (\"eyeball\") the Bode plot to answer the following questions:

1. what is the period of the oscillations of the _measured_ concentration $c_m(t)$? 

[... your answer ...]

2. what is the amplitude of the oscillations of the _measured_ concentration $c_m(t)$?

[... your answer ...]

3. what is the phase lag (in radians) of the _measured_ concentration $c_m(t)$ from the actual concentration $c(t)$?

[... your answer ...]
"

# ╔═╡ 6cc20a99-a981-459d-8bd5-1561dada0892
md"though the grid lines help, it's difficult to accurately read the amplitude ratio and phase shift from a Bode plot. 

below, re-answer questions 1-4, more accurately, by using `evaluate` (see [docs](https://simonensemble.github.io/Controlz.jl/dev/tfs/#Controlz.evaluate)) to evaluate the transfer function at the appropriate complex number. 

!!! hint
	define a complex number in Julia as, eg. `1 + 3 * im` for $1 + 3i$.

!!! hint
	the magnitude of a complex number `z` can be computed in Julia via `abs(z)`. the angle in radians is `angle(z)`.

🐺 below, define as a variable the special complex number that determines this frequency response of the sensor.
"

# ╔═╡ 86b24468-3560-4e40-b064-c04830546fc1

# ╔═╡ 95b0bff4-24c9-4113-bfd1-396bf8a84961
md" 🐺 compute the amplitude of the oscillations in the measured concentration $c_m(t)$."

# ╔═╡ b198ce6d-83cd-4744-b4ae-32f76760fc7f

# ╔═╡ 9ad4e705-82c6-4285-b94f-5a80599d4e6e
md"🐺 compute the phase lag (in radians) of the oscillations in the measured concentration $c_m(t)$ from the oscillations in the actual concentration $c(t)$.
"

# ╔═╡ aba19445-e181-4103-b1f8-9355ba58611b

# ╔═╡ f75d6156-3d42-4807-b803-4f5960a8f19a
md"
## simulating the frequency response of the sensor
🐺 to qualitatively verify that you correctly predicted the amplitude of $c_m(t)$ from the Bode plot:
* simulate the response of the sensor to this oscillating input $c(t)$ using `simulate` for $t\in[0, 5]$ min. follow the `Controlz.jl` example [here](https://simonensemble.github.io/Controlz.jl/dev/). 
* on the same panel, plot the true input $c(t)$.
* use a legend via `axislegend()` to label which curve is the measured and actual acetone concentration.
* instead of deviation form, plot the variables in the actual ppm concentration.

does the output amplitude in the simulation match what you predicted above?
"

# ╔═╡ 0337dc6e-c10a-4a1e-ba54-7125d861bf78
begin
	# define input C
	
	# define output Cm
	
	# simulate for t in [0, 10]. use nb_time_points=300 so the response is smooth.
	
    # visualize response (3 lines to add)
	fig = Figure()
	ax  = Axis(fig[1, 1], xlabel="time, t [min]", ylabel="acetone conc. [ppm]")
    # draw true conc
    # draw sensor response
    # legend
	fig
end

# ╔═╡ ca2a232e-3464-4380-aa4f-d922ffdf9605
md"
🐺 does the amplitude of the measured concentration of acetone, $c_m(t)$, reflect the true variation of the concentration of acetone in the gas phase?

[...your answer...]

## research on acetone sensing
🐺 why is acetone sensing important? [do some research]

!!! hint
    there are two major applications of acetone sensors. the first pertains to our health. see \"Breath Sensors for Health Monitoring\" on Canvas. the second pertains to the typical industrial application of a gas sensor (see the paper by L. Wang, pg. 4.).

[...your answer here...]
"

# ╔═╡ Cell order:
# ╠═578ebd0a-d6d3-11ec-1589-55fe742489b1
# ╠═f7a9117f-6f41-44b2-be0b-c5a08ff2990d
# ╟─abefda5a-0fc0-44c8-83c4-4d28fe7b3ac9
# ╠═6d6f5be6-cfc0-4dc9-a75e-6886c348af89
# ╟─29e4e996-ccd4-4957-8ba3-e95186fec645
# ╟─52c894f7-a247-402c-b90e-de32c433a8d1
# ╟─578f7eaa-c2cc-49b6-bea1-3bb415e7c467
# ╠═7b883807-52d3-4fdb-ad9c-6a11f47081e7
# ╟─1390383a-5b87-4f6c-8831-23c59c415420
# ╠═1268ea9a-624d-4d49-b89a-81bf3cdd31b8
# ╟─a62f3c02-251f-4570-a68c-b5cee5b22c25
# ╟─9c9317ad-e712-4468-a758-1b0d9e529d28
# ╠═0eeee419-4817-4afe-8961-cdd2803e235e
# ╠═9efd6364-17de-4436-bb86-db1c17eda0a3
# ╠═6e386475-56a3-4494-8324-bf2315a92f70
# ╠═a7762d8b-b2ee-4172-8e31-5d414725c8ad
# ╟─042a9300-5de9-4dcc-8e6c-d11bb40049fb
# ╟─6cc20a99-a981-459d-8bd5-1561dada0892
# ╠═86b24468-3560-4e40-b064-c04830546fc1
# ╟─95b0bff4-24c9-4113-bfd1-396bf8a84961
# ╠═b198ce6d-83cd-4744-b4ae-32f76760fc7f
# ╟─9ad4e705-82c6-4285-b94f-5a80599d4e6e
# ╠═aba19445-e181-4103-b1f8-9355ba58611b
# ╟─f75d6156-3d42-4807-b803-4f5960a8f19a
# ╠═0337dc6e-c10a-4a1e-ba54-7125d861bf78
# ╟─ca2a232e-3464-4380-aa4f-d922ffdf9605
