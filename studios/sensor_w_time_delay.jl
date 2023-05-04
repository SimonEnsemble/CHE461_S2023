### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ 1225e7da-c723-11ec-24b2-d7f809be5f4b
begin
	import Pkg; Pkg.activate()
	using Controlz, CairoMakie, PlutoUI
end

# ╔═╡ ce3580fe-8419-4abf-a7e0-38fa4a9fbe66
TableOfContents()

# ╔═╡ 39dbedf6-ad18-409a-ac1d-932c743773ed
set_theme!(Controlz.cool_theme)

# ╔═╡ 1980e4d0-ec55-4f19-b724-0cb8c8ebc6a6
md"
# how does a time delay affect a closed-loop control system?

a closed-loop control system is depicted in the block diagram below.
*  $Y^*$: controlled variable
*  $D^*$: disturbance variable
*  $U^*$: manipulated variable

💡 the sensor exhibits a time delay of $\theta$. the goal of this studio is to study the influence of this time delay---and the PI controller settings---on the closed-loop response.

![](https://raw.githubusercontent.com/SimonEnsemble/CHE461_S2022/main/random/sensorwithtimedelay.png)
"

# ╔═╡ b1aad9d7-847b-4866-a067-a1236b3a603d
md"
## setting up the sim

🐯 assign the process transfer functions $G_u(s)$ and $G_d(s)$ as variables `G_u` and `G_d`."

# ╔═╡ 15b62f12-a8d8-476e-91ab-cd1307480ddc

# ╔═╡ 10e21ce0-c4b8-42b0-a824-d55931a480e4

# ╔═╡ 1d2184aa-2d2c-48ba-9b12-1f01c8a9eb82
md"🐯 assign the sensor transfer function $G_s(s)$ as a variable `G_s`. 

for now, take the time delay associated with the sensor as $\theta=1$.
"

# ╔═╡ 9f1ef0b1-7f4a-47e1-9fc7-018655a2f25d
θ = 1.0

# ╔═╡ b8aab0d0-fff8-4c97-92bd-32a3ed8df72c

# ╔═╡ 7cff5e4b-b1aa-4dc0-872c-71e72024728c
md"
## designing the PI-controller
🐯 apply the smart and busy operator (SBO) PI controller tuning rule to design a PI-control law $G_c(s)$. assign it as a variable `G_c`. 

!!! note
	to apply the SBO PI-controller tuning rules, set the integral time constant $\tau_I$ of the controller as the time constant of the process _plus_ the time delay of the sensor. the idea is to add the time scales of the process and sensor which _together_ comprise the open-loop transfer function to which SBO PI-controller rules pertain. compared to ignoring the time delay in the sensor, this rule effectively reduces I-action when there is an additional time delay in the sensor.

!!! hint
	check out the `PIController` helper functions [here](https://simonensemble.github.io/Controlz.jl/dev/controls/#P,-PI,-PID-controller-transfer-functions).
"

# ╔═╡ 997abb4d-21a6-4810-b9bf-d4b26d787729

# ╔═╡ 6d005433-6589-4e84-99a4-e0b7d44df3df
md"
## obtaining the closed-loop transfer function
🐯 assign the open-loop transfer function $G_{OL}(s)$ as a variable `G_OL`. use the transfer function variables you constructed previously."

# ╔═╡ 9832413b-4b86-4dd0-bd47-d38df62cb8ff

# ╔═╡ fed8b942-d11e-4740-b24d-24e2e4768623
md"🐯 assign the closed-loop transfer function governing the closed-loop response $Y^*$ to a disturbance $D^*$ as a variable `G_reg` (reg for \"regulator\" response). 

!!! note
	use (i) the open-loop transfer function `G_OL` you defined previously and (ii) the `ClosedLoopTransferFunction` constructor [here](https://simonensemble.github.io/Controlz.jl/dev/controls/#feedback-loops-with-time-delays). this is necessary to handle the time delay.

"

# ╔═╡ e90883d5-5d3c-499a-bcfd-25c97662e643

# ╔═╡ 12af4f60-0758-423d-ab20-fa1d04fd3948
md"
## simulating the closed-loop response to a disturbance
🐯 consider a unit step change in the disturbance variable. assign the disturbance input $D^*(s)$ for this input as a variable `D★`."

# ╔═╡ 4d40b37b-809b-4ddd-bcc3-3af7be5b9b5d

# ╔═╡ e18e96a6-6577-471f-92fa-6baeadf935de
md"
🐯 use `D★` and `G_reg` to construct the closed-loop response $Y^*(s)$ to the disturbance as a variable `Y★`."

# ╔═╡ 3e6a24f2-a15a-44e4-95fe-91347374f6cd

# ╔═╡ 5ade4299-d037-4fca-977b-eafe95e50853
md"🐯 now use the closed-loop response `Y★`, sensor transfer function `G_s`, and control law `G_c` to assign as variables:
* `E`, the error signal $E(s)$ then
* `U★`, the controller output $U^*(s)$
"

# ╔═╡ ac232dda-15c6-4d53-9838-72de0c2de2de

# ╔═╡ 56b0f552-073a-4a34-aba0-deb4aaa6cebd

# ╔═╡ 9d430eb6-fba9-44ab-b942-c863213b900a
md"### a baseline of no control
🐯 as a baseline, assign the response $Y^*(s)$ to the disturbance _without_ a controller as a variable `Y★_nc` (nc = \"no controller\")."

# ╔═╡ 7db31d53-491d-4bf3-a3d7-1ffc3184f311

# ╔═╡ 39f68f48-057b-4a13-a4e9-21df5442e5de
md"
## simulation time!
🐯 use `simulate` to obtain time series data pertaining to, in response to this step in the disturbance variable $d^*(t)$:
* the closed-loop response $y^*(t)$, assigned as data frame `data_y`
* the response $y^*(t)$, if the controller were \"off\", assigned as data frame `data_y_nc`
* the controller action $u^*(t)$, assigned as data frame `data_u`
* the error signal $e^*(t)$, assigned as data frame `data_e`

!!! note
	[here](https://simonensemble.github.io/Controlz.jl/dev/controls/#feedback-loops-with-time-delays) is a guiding example in the `Controlz.jl` docs.
"

# ╔═╡ fe7265a1-dc26-42a0-9658-4101e6599aa4
final_time = 40.0 # length of time to simulate

# ╔═╡ 3a8cbf80-9c34-4d74-9c6a-69fb9355c937

# ╔═╡ e619be9b-4b41-48a1-99ea-ed4fb870d76b
md"
### visualize the response
the `CairoMakie` code below is to visualize:
* panel 1: the error signal $e(t)$
* panel 2: the controller action $u^*(t)$
* panel 3: the closed-loop response $y^*(t)$ with controller \"off\" as a baseline.

🐯 I left panel 2 blank for you: draw the curve giving the controller action $u^*(t)$ to complete the plot.
"

# ╔═╡ 393221f4-4b09-4390-95f7-30a43ec1e35a
begin
	fig = Figure(resolution=(500, 600))
	# define three axes and link the x-axes
	ax_e = Axis(fig[1, 1], ylabel="e(t)", title="error signal")
	ax_u = Axis(fig[2, 1], ylabel="u*(t)", title="controller action")
	ax_y = Axis(fig[3, 1], ylabel="y*(t)", 
		title="closed-loop response", xlabel="time, t")
	linkxaxes!(ax_e, ax_u, ax_y)
	hidexdecorations!(ax_e, grid=false)
	hidexdecorations!(ax_u, grid=false)

	# plot error signal
	lines!(ax_e, data_e[:, "t"], data_e[:, "output"], color=Cycled(1))

	# plot controller action (I left this one for you 😄)

	# plot output
	lines!(ax_y, data_y_nc[:, "t"], data_y_nc[:, "output"], 
		label="no control", linestyle=:dot, color=Cycled(3))
	lines!(ax_y, data_y[:, "t"], data_y[:, "output"], 
		label="PI control", color=Cycled(4))
	axislegend(ax_y, position=:rc)
	xlims!(-2, final_time)
	fig
end

# ╔═╡ d0a213c4-2f4a-4c83-95b9-e4f46af98528
md"
### rationalize/explain the response, extract intuition from the simulations

**case: $\theta=1$**

🐯 did the (modified) smart and busy operator PI controller tuning rule result in a reasonably effective controller? compare to the baseline of no control. is there any steady state offset error in the closed-loop response? 

[your answer here...]

**case: $\theta=5$**

🐯 increase the time delay of the sensor to $\theta=5$. 

!!! hint
	you'll need to adjust your PI control law if you hard-coded $\theta=1$ instead of using the variable `θ` that I provided.

🐯 with such a large time delay, what qualitative change do you notice in the closed-loop response? think carefully and explain why. 

[your answer here...]

🐯 (this may help) does the peak deviation of $y$ from its set point correspond to the peak in the error signal? shouldn't it? why not?

[your answer here...]

🐯 (this may help) when does the controller first start taking action in response to the disturbance? is this ideal? why doesn't the controller take action right away, at $t=0$?

[your answer here...]

**case: more aggressive controller**

🐯 keeping $\theta=5$, experiment with making the controller more agressive, by doubling the controller gain. what happens to the closed-loop response?

[your answer here...]

**summary**

🐯 what do you conclude about a sensor with a time delay used in a closed-loop control system?

[your answer here...]

🐯 comment on how sensor design and placement are important considerations for control systems. i.e., can we sometimes affect the value of $\theta$ by design?

[your answer here...]
"

# ╔═╡ 0e0bccce-0314-41c4-a959-9042a5594d57
md"!!! warning
	when you turn in your studio, make sure (i) `θ = 5.0` and (ii) your PI-controller settings are set according to SBO.
"

# ╔═╡ Cell order:
# ╠═1225e7da-c723-11ec-24b2-d7f809be5f4b
# ╠═ce3580fe-8419-4abf-a7e0-38fa4a9fbe66
# ╠═39dbedf6-ad18-409a-ac1d-932c743773ed
# ╟─1980e4d0-ec55-4f19-b724-0cb8c8ebc6a6
# ╟─b1aad9d7-847b-4866-a067-a1236b3a603d
# ╠═15b62f12-a8d8-476e-91ab-cd1307480ddc
# ╠═10e21ce0-c4b8-42b0-a824-d55931a480e4
# ╟─1d2184aa-2d2c-48ba-9b12-1f01c8a9eb82
# ╠═9f1ef0b1-7f4a-47e1-9fc7-018655a2f25d
# ╠═b8aab0d0-fff8-4c97-92bd-32a3ed8df72c
# ╟─7cff5e4b-b1aa-4dc0-872c-71e72024728c
# ╠═997abb4d-21a6-4810-b9bf-d4b26d787729
# ╟─6d005433-6589-4e84-99a4-e0b7d44df3df
# ╠═9832413b-4b86-4dd0-bd47-d38df62cb8ff
# ╟─fed8b942-d11e-4740-b24d-24e2e4768623
# ╠═e90883d5-5d3c-499a-bcfd-25c97662e643
# ╟─12af4f60-0758-423d-ab20-fa1d04fd3948
# ╠═4d40b37b-809b-4ddd-bcc3-3af7be5b9b5d
# ╟─e18e96a6-6577-471f-92fa-6baeadf935de
# ╠═3e6a24f2-a15a-44e4-95fe-91347374f6cd
# ╟─5ade4299-d037-4fca-977b-eafe95e50853
# ╠═ac232dda-15c6-4d53-9838-72de0c2de2de
# ╠═56b0f552-073a-4a34-aba0-deb4aaa6cebd
# ╟─9d430eb6-fba9-44ab-b942-c863213b900a
# ╠═7db31d53-491d-4bf3-a3d7-1ffc3184f311
# ╟─39f68f48-057b-4a13-a4e9-21df5442e5de
# ╠═fe7265a1-dc26-42a0-9658-4101e6599aa4
# ╠═3a8cbf80-9c34-4d74-9c6a-69fb9355c937
# ╟─e619be9b-4b41-48a1-99ea-ed4fb870d76b
# ╠═393221f4-4b09-4390-95f7-30a43ec1e35a
# ╟─d0a213c4-2f4a-4c83-95b9-e4f46af98528
# ╟─0e0bccce-0314-41c4-a959-9042a5594d57
