### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 39ac6c72-00f8-11ee-2195-0b3177e05808
begin
	import Pkg; Pkg.activate()
	using Controlz, CairoMakie, PlutoUI, PlutoTeachingTools
end

# ╔═╡ fad75812-cf9d-488f-97e0-a45809fe3c05
TableOfContents()

# ╔═╡ a02d83e7-8ae4-4f25-b698-4605a0cde40e
set_theme!(theme_ggplot2())

# ╔═╡ 3280331f-cad5-4299-ab6d-997e345f0660
md"# the Bode criterion for closed-loop stability

consider the closed-loop system below.
the process exhibits first order dynamics. 
the sensor has a time delay of $\theta$ in its measurement.
the controller is a PI controller with gain $K_c$ and integral time constant $\tau_I$.

![](https://raw.githubusercontent.com/SimonEnsemble/CHE461_S2023/main/studios/bode_stability_studio.png)

!!! note \"objective\"
	our goal is to use the Bode stability criterion and Bode plots to assess the stability of this closed loop system to different values of $\theta$, $K_c$, and $\tau_I$.

to start, suppose $K_c$, $\tau_I$, and $\theta$ are as below.
"

# ╔═╡ 87713842-d8df-466d-b8a1-3ea3f9eb33cc
begin
	Kc = 2/3  # gain of controller
	τ_I = 2.0 # integral time constant of controller
	θ = 0.25  # time delay in sensor
end

# ╔═╡ d461ec4b-4f0f-44c2-be2d-99f49bfb7c40
md"
## setup
🐒 as variables `gc`, `gu`, and `gs`, define the transfer functions for the controller, process, and sensor.

!!! hint
	do not hard-code the controller gain, integral time constant, and sensor time delay. use the variables above so that, when you change them, these changes take effect downstream in your code.
"

# ╔═╡ 0e9d4eb0-afc7-4a57-8108-39cd88778780
begin
end

# ╔═╡ 407352bb-7f2b-4f0d-adca-f19ff5410276
md"🐒 as a variable `gol`, define the open-loop transfer function."

# ╔═╡ df317270-9596-41a0-ab05-857a95933be7

# ╔═╡ 1e0aa14c-f03b-4628-8cf3-5dadca3bd139
md"
## Bode stability
🐒 draw the Bode plot that depicts the frequency response characteristics of $G_{OL}(s)$ by passing `gol` to `bode_plot`. restrict the frequencies to $[10^{-3}, 10]$ using the optional keyword arguments `log10_ω_min` and `log10_ω_max`. see [docs](https://simonensemble.github.io/Controlz.jl/dev/viz/#Bode-plot)."

# ╔═╡ 587aff3d-157c-4e7f-afb3-48c770a19857

# ╔═╡ 6601db0d-e70f-4d39-b052-8000ce0ab003
question_box(md"what is the critical frequency $\omega_c$ of the closed loop?")

# ╔═╡ 7522df53-35db-4235-968b-beeff569e9c8
md"
🐒 first, visually inspect the Bode diagram to determine $\omega_c$.
the critical frequency of the closed loop is $\omega_c=$ [...] because this is the input frequency such that [...].
"

# ╔═╡ 38cf2791-d460-4c32-81f4-19e4277831d0
md"🐒 second, determine the critical frequency $\omega_c$ more accurately by passing `gol` to `gain_phase_margins`, which computes the critical frequency for you. define the critical frequency as a variable `ω_c` for later (the docs show how to extract it from the output of `gain_phase_margins`).

!!! note
	the _gain margin_ is the factor by which can increase the controller gain before the onset of instability. the _phase margin_ tells us how much time delay we can add to the system before the onset of instability.

!!! hint
	see [docs](https://simonensemble.github.io/Controlz.jl/dev/tfs/#frequency-response-of-an-open-loop-transfer-function). this is a numerical solver, so you need to pass in a good guess, via the argument `ω_c_guess`. use the value you got from visually inspecting the Bode plot. I had to change the guess when I changed `Kc` and `θ`. if your guess is poor, it will converge to the wrong solution or give `NaN` (not a number).
"

# ╔═╡ ec393f32-1a39-4adf-aa96-d7600b424aff

# ╔═╡ aa0c7ac5-5a7c-468e-a325-ef5a2efaf142

# ╔═╡ cd784844-29de-4959-9d25-208e9190f97b
question_box(md"what is the amplitude ratio at the critical frequency, $|G_{OL}(i\omega_c)|$, that determines the stability of the closed loop?")

# ╔═╡ dd4478e2-b766-419d-b178-50aa53abe274
md"🐒 first, visually inspect the Bode diagram to obtain $|G_{OL}(i\omega_c)|$.

it looks like $|G_{OL}(i\omega_c)|$ is approximately [...].
"

# ╔═╡ 29ed90ce-d482-458d-901e-01491611f281
md"🐒 second, use the `evaluate` function to evaluate the open-loop transfer function $G_{OL}(s)$ at $i\omega_c$ then the `abs` function to determine the magnitude of this complex number, giving $|G_{OL}(i\omega_c)|$.
!!! hint
	see [docs](https://simonensemble.github.io/Controlz.jl/dev/tfs/#evaluate-a-transfer-function-at-a-complex-number).


"


# ╔═╡ fbb381f5-05ca-43ed-b9fd-431b704629ec

# ╔═╡ 7cbd6912-303c-4077-a7fa-336d1012ee16

# ╔═╡ 05997c6a-e948-4d0b-90f0-765670dc0f0a

# ╔═╡ b689b4f2-0586-463f-a066-a692d3495547
question_box(md"is the closed-loop stable to set point changes, based on the Bode stability criterion?")

# ╔═╡ adf356f3-b1b3-4b9d-a723-ca52128b01dc
md"🐒 according to the Bode stability criterion, the closed-loop [is / is not] stable because [...]."

# ╔═╡ 3c7ed468-d184-4000-8c8c-2e853134ebac
md"## simulation

to check your asssessment of the stability of the closed loop, let's simulate its response to a set point change.

🐒 simulate the response of this closed loop to a set point change of +1.0 for $t\in[0, 15]$. draw the response.

!!! hint
	you need to use the `ClosedLoopTransferFunction` because there is a time delay in the sensor. see [here](https://simonensemble.github.io/Controlz.jl/dev/tfs/#closed-loop-transfer-functions).
"

# ╔═╡ d890a8bb-7f35-4af2-93b6-1049f7dced00
begin
	# input, Ysp★
	
	# output, Y★
	
	# simulate response to get time series data
	
	# viz the response
end

# ╔═╡ 1a21873b-9631-42cf-8d7f-6100a2364ded
md"## increasing the controller gain
"

# ╔═╡ 17b5df4a-3b3b-40a1-9f37-3a1a47a9d8a6
md"increase the controller gain to 7/3. 

🐒 is the closed loop still stable? 
based on the Bode stability criterion, [...].
my simulation [does / does not] confirm this.
"

# ╔═╡ 36025ebe-b774-427b-b658-375c17e8966b
md"## increasing the time delay
change the controller gain back to 2/3. now increase the time delay of the sensor to 1.0. 

🐒 is the closed loop still stable? based on the Bode stability criterion, [...]. my simulation [does / does not] confirm this.
"

# ╔═╡ a8db7a4c-1dc1-4169-baa8-74fc8d27d8cb
md"## making the system marginally stable"

# ╔═╡ c860a1a5-9e0b-495f-89cf-48d6c69ea680
md"🐒 multiply the gain $K_c$ by $1/|G_{OL}(i\omega_c)|$, the _gain margin_. what do you observe?

observation about $|G_{OL}(i\omega_c)|$: [...]

observation about the simulation:

"

# ╔═╡ 20762f90-d3f6-4681-8e8a-bd8e7333f156
TODO("when you turn in the studio, return the parameters to the default settings Kc = 2/3 and θ = 0.25.")

# ╔═╡ Cell order:
# ╠═39ac6c72-00f8-11ee-2195-0b3177e05808
# ╠═fad75812-cf9d-488f-97e0-a45809fe3c05
# ╠═a02d83e7-8ae4-4f25-b698-4605a0cde40e
# ╟─3280331f-cad5-4299-ab6d-997e345f0660
# ╠═87713842-d8df-466d-b8a1-3ea3f9eb33cc
# ╟─d461ec4b-4f0f-44c2-be2d-99f49bfb7c40
# ╠═0e9d4eb0-afc7-4a57-8108-39cd88778780
# ╟─407352bb-7f2b-4f0d-adca-f19ff5410276
# ╠═df317270-9596-41a0-ab05-857a95933be7
# ╟─1e0aa14c-f03b-4628-8cf3-5dadca3bd139
# ╠═587aff3d-157c-4e7f-afb3-48c770a19857
# ╟─6601db0d-e70f-4d39-b052-8000ce0ab003
# ╟─7522df53-35db-4235-968b-beeff569e9c8
# ╟─38cf2791-d460-4c32-81f4-19e4277831d0
# ╠═ec393f32-1a39-4adf-aa96-d7600b424aff
# ╠═aa0c7ac5-5a7c-468e-a325-ef5a2efaf142
# ╟─cd784844-29de-4959-9d25-208e9190f97b
# ╟─dd4478e2-b766-419d-b178-50aa53abe274
# ╟─29ed90ce-d482-458d-901e-01491611f281
# ╠═fbb381f5-05ca-43ed-b9fd-431b704629ec
# ╠═7cbd6912-303c-4077-a7fa-336d1012ee16
# ╠═05997c6a-e948-4d0b-90f0-765670dc0f0a
# ╟─b689b4f2-0586-463f-a066-a692d3495547
# ╟─adf356f3-b1b3-4b9d-a723-ca52128b01dc
# ╟─3c7ed468-d184-4000-8c8c-2e853134ebac
# ╠═d890a8bb-7f35-4af2-93b6-1049f7dced00
# ╟─1a21873b-9631-42cf-8d7f-6100a2364ded
# ╟─17b5df4a-3b3b-40a1-9f37-3a1a47a9d8a6
# ╟─36025ebe-b774-427b-b658-375c17e8966b
# ╟─a8db7a4c-1dc1-4169-baa8-74fc8d27d8cb
# ╟─c860a1a5-9e0b-495f-89cf-48d6c69ea680
# ╟─20762f90-d3f6-4681-8e8a-bd8e7333f156
